# frozen_string_literal: true

require "spec_helper"

# expressir#614/#616: the Rust attach stage panicked (`byte index 8 is
# not a char boundary; it is inside '先'`) on a remark line whose first
# non-space character is multi-byte — the scope walk's keyword prefix
# compare sliced `trimmed[..keyword.len()]` in bytes. iso-10303 pinned
# its corpus back to 2.4.48 over this (metanorma/iso-10303#822); the
# byte-wise compare matches only ASCII keywords on ASCII prefixes, so
# the attach stage handles any text. Un-gated (issue #623): the spec
# runs on whichever lane from_file picks — the core lane and the
# pure-Ruby RemarkAttacher must both attach cleanly.
RSpec.describe "multi-byte remark lines" do # rubocop:disable RSpec/DescribeClass
  require "tempfile"

  let(:source) do
    <<~EXPRESS
      SCHEMA demo;
      ENTITY e;
        a : STRING;
      END_ENTITY;
      (*"demo.e" The threshold of
      // ↑先行して作業中
      by numerical test. *)
      END_SCHEMA;
    EXPRESS
  end

  it "attaches the remark without panicking" do
    file = File.join(Dir.mktmpdir, "multibyte616.exp")
    File.write(file, source)
    model = Expressir::Express::Parser.from_file(file)
    entity = model.schemas[0].entities[0]
    texts = Array(entity.remarks).map { |r| r.respond_to?(:text) ? r.text : r.to_s }
    expect(texts.join("\n")).to include("先行して作業中")
  end
end
