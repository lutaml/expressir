require "spec_helper"

RSpec.describe Expressir::Express::Parser do
  # expressir#635: when the native extension is available, resolution
  # delegates to the Rust pass over the model wire; otherwise the Ruby
  # ResolveReferencesModelVisitor runs. Both lanes must agree.
  let(:source) do
    <<~EXPRESS
      SCHEMA resolve_base;
        ENTITY base_entity;
        END_ENTITY;
        TYPE label_type = LABEL;
        END_TYPE;
      END_SCHEMA;
      SCHEMA resolve_user;
        USE FROM resolve_base (base_entity AS renamed_entity);
        REFERENCE FROM resolve_base (label_type);
        ENTITY user_entity SUBTYPE OF (renamed_entity);
          a : label_type;
        END_ENTITY;
      END_SCHEMA;
    EXPRESS
  end

  def resolved_base_paths(model)
    refs = []
    walk = lambda do |node|
      return unless node.is_a?(Expressir::Model::ModelElement)

      if node.is_a?(Expressir::Model::References::SimpleReference) && node.base_path
        refs << [node.id, node.base_path]
      end
      Expressir::Model::ModelElement.collection_registry[node.class]&.each do |attr|
        collection = node.respond_to?(attr) ? node.public_send(attr) : nil
        next unless collection.is_a?(Array)

        collection.each { |child| walk.call(child) }
      end
    end
    walk.call(model)
    refs.sort
  end

  it "resolves identically on both lanes" do
    delegated = described_class.from_exp(source).tap(&:wire_parents)

    model = described_class.from_exp(source, skip_references: true, use_native: false)
    Expressir::Express::ResolveReferencesModelVisitor.new.visit(model)
    model.tap(&:wire_parents)

    expect(resolved_base_paths(delegated)).to eq(resolved_base_paths(model))
  end

  it "resolves the interface closure through the rename" do
    model = described_class.from_exp(source).tap(&:wire_parents)
    user = model.schemas[1]

    subtype_ref = user.entities[0].subtype_of.first
    expect(subtype_ref.base_path).to eq(".resolve_base.base_entity")
  end

  # expressir#667: visibilities union across interfaces — a REFERENCE
  # FROM to a schema already visited through USE FROM still contributes
  # (the visited dedup is per interface, bounding the transitive-USE
  # recursion, not deduplicating sibling interfaces).
  it "resolves the second same-schema interface (USE + REFERENCE FROM the same schema)" do
    model = described_class.from_exp(source).tap(&:wire_parents)
    user = model.schemas[1]

    attr_ref = user.entities[0].attributes[0].type
    expect(attr_ref.base_path).to eq(".resolve_base.label_type")
  end

  it "keeps the bound-variable shadow unresolved" do
    source = <<~EXPRESS
      SCHEMA shadow_schema;
        FUNCTION probe(i : INTEGER) : INTEGER;
          LOCAL
            total : INTEGER;
          END_LOCAL;
          total := SQRT(i);
          RETURN (QUERY(x <* total | x > i));
        END_FUNCTION;
      END_SCHEMA;
    EXPRESS
    model = described_class.from_exp(source).tap(&:wire_parents)
    query = model.schemas[0].functions[0].statements[1].expression
    # The aggregate source is the real LOCAL variable (fills normally);
    # the query's own bound id `x` never fills — a lookup of it resolves
    # to the query node, which has no path — and never leaks past the
    # shadow to the function parameter `i`.
    expect(query.aggregate_source.base_path).to eq(".shadow_schema.probe.total")
    expect(resolved_base_paths(model)).not_to include(["x", anything])
  end
end
