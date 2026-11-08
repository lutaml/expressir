# frozen_string_literal: true

require "tempfile"

RSpec.describe Expressir::Express::Formatter do # remark-item conservation (expressir#603)
  # WG12-shaped source: every construct carries a `(*"path"` remark
  # item, the blocks sitting at the file tail like the real corpora.
  # The formatter must render every RemarkItem, with the schema-relative
  # tag, so a parse → format → parse round trip conserves them.
  let(:source) do
    <<~EXP
      SCHEMA sample_schema;
        ENTITY sample_entity;
          sample_attr : STRING;
        END_ENTITY;
      END_SCHEMA;

      (*"sample_schema.__published_in"
      ISO 10303-9999:2026
      *)

      (*"sample_schema.sample_entity.__note"
      A note on the entity.
      *)

      (*"sample_schema.sample_entity.sample_attr.description"
      A note on the attribute.
      And a second line.
      *)
    EXP
  end

  def count_remark_items(model)
    total = 0
    walk = lambda do |node|
      total += Array(node.remark_items).length if node.respond_to?(:remark_items)
      %i[schemas entities attributes types functions procedures rules constants
         parameters variables unique_rules where_rules informal_propositions
         subtype_constraints interfaces].each do |children|
        node.respond_to?(children) &&
          node.public_send(children)&.each { |child| walk.call(child) }
      end
      node.respond_to?(:enumeration_items) &&
        node.enumeration_items&.each { |child| walk.call(child) }
    end
    Array(model.schemas).each { |schema| walk.call(schema) }
    total
  end

  it "renders every remark item with a schema-relative tag" do
    model = Expressir::Express::Parser.from_file(write_source)
    model = rehydrate_with_parents(model)

    formatted = described_class.new.format(model)
    nodes = count_remark_items(model)
    markers = formatted.scan('(*"').length + formatted.scan('--"').length

    expect(nodes).to eq(3)
    expect(markers).to eq(nodes)
    # single-line remarks render the tail form; a multi-line remark
    # renders the block form
    expect(formatted).to include('--"sample_schema.__published_in" ISO 10303-9999:2026')
    expect(formatted)
      .to include('(*"sample_schema.sample_entity.sample_attr.description"')
    expect(formatted).not_to include("/tmp")
  end

  it "conserves remark items across a format round trip" do
    model = Expressir::Express::Parser.from_file(write_source)
    model = rehydrate_with_parents(model)

    formatted = described_class.new.format(model)
    reparsed = Expressir::Express::Parser.from_file(write_text(formatted))

    expect(count_remark_items(reparsed)).to eq(count_remark_items(model))
  end

  def write_source
    file = Tempfile.new(["remark_items", ".exp"])
    file.write(source)
    file.close
    file.path
  end

  def write_text(text)
    file = Tempfile.new(["remark_items", ".exp"])
    file.write(text)
    file.close
    file.path
  end

  # from_file without root_path leaves the ExpFile id as the absolute
  # file path; rehydrate through the same lane the product uses so the
  # parent chain (and therefore the rendered tag) is established.
  def rehydrate_with_parents(model)
    model.wire_parents if model.respond_to?(:wire_parents)
    model
  end
end
