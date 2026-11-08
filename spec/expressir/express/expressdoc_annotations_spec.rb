# frozen_string_literal: true

require "tempfile"

RSpec.describe "EXPRESSdoc annotations" do # rubocop:disable RSpec/DescribeClass
  # metanorma/annotated-express#94 (expressir#91): `--- note` and
  # `(** note *)` are the display channel, distinct from remarks. The
  # forms are recognized only in annotations mode; the default reading
  # of every existing source is unchanged.
  let(:source) do
    <<~EXP
      SCHEMA demo_schema;
        ENTITY demo_entity;
          (** an inline annotation on the attribute *)
          name : STRING;
        END_ENTITY;
        --- a tail annotation in the schema scope
      END_SCHEMA;
    EXP
  end

  def parse_with(mode)
    file = Tempfile.new(["annotations", ".exp"])
    file.write(source)
    file.close
    Expressir::Express::Parser.from_file(file.path, annotations: mode)
  ensure
    file&.unlink
  end

  # The annotation distinction is a scanner feature of the core lane
  # (expressir#91). The grammar lane keeps its remark reading, so the
  # specs are native-gated like the other core-lane coverage.
  before do
    unless Expressir::Express::Core::NATIVE_AVAILABLE
      skip "core extension absent — annotations are a core-lane feature"
    end
  end

  def remark_formats(node, acc = [])
    Array(node.untagged_remarks).each do |remark|
      acc << remark.format if remark.respond_to?(:format) && remark.respond_to?(:text)
    end
    %i[schemas entities attributes types functions procedures rules].each do |children|
      next unless node.respond_to?(children)

      node.public_send(children)&.each { |child| remark_formats(child, acc) }
    end
    acc
  end

  def annotation_remarks(node, acc = [])
    Array(node.untagged_remarks).each do |remark|
      acc << remark if remark.is_a?(Expressir::Model::RemarkInfo) &&
        remark.tail_annotation?
    end
    %i[schemas entities attributes types functions procedures rules].each do |children|
      next unless node.respond_to?(children)

      node.public_send(children)&.each { |child| annotation_remarks(child, acc) }
    end
    acc
  end

  it "recognizes annotations only in annotations mode" do
    model = parse_with(true)

    annotations = annotation_remarks(model)
    expect(annotations.map(&:text)).to include("a tail annotation in the schema scope")
    expect(annotations.first.format)
      .to eq(Expressir::Model::RemarkFormat::TAIL_ANNOTATION)
  end

  it "leaves the default reading of existing sources unchanged" do
    model = parse_with(false)

    formats = remark_formats(model).compact
    expect(formats - [Expressir::Model::RemarkFormat::TAIL,
                      Expressir::Model::RemarkFormat::EMBEDDED]).to be_empty
    annotation_remarks(model).tap { |found| expect(found).to be_empty }
  end

  it "renders annotations with their own markers" do
    model = parse_with(true)

    formatted = Expressir::Express::Formatter.new.format(model)
    expect(formatted).to include("(** an inline annotation on the attribute *)")
    expect(formatted).not_to include("(* an inline annotation on the attribute *)")
  end

  it "scans annotations on the fallback scanner like the native one" do
    native = Expressir::Express::Core.scan_remarks(source, annotations: true).map do |unit|
      [unit[:format], unit[:text]]
    end
    fallback = Expressir::Express::RemarkScanner.new(source, annotations: true)
      .send(:run_state_machine)
      .map { |r| [r.format, r.text] }

    expect(fallback).to eq(native)
  end
end
