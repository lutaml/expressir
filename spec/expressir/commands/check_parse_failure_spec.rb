# frozen_string_literal: true

require "spec_helper"
require "tempfile"
require "stringio"

# GH-413: `validate check` must distinguish an unparseable schema from a
# clean one — from_files silently yields nil entries for parse failures,
# which the Checker cannot see.
RSpec.describe Expressir::Commands::Check do
  def check_schema(source)
    f = Tempfile.new(["gh413", ".exp"])
    f.write(source)
    f.close
    command = described_class.new({})
    command.instance_variable_set(:@output, buf = StringIO.new)
    begin
      command.run(f.path)
    rescue StandardError
      # nonzero-exit signaling (Thor::Error / CommandError) is expected
      # for error runs; the output is the contract under test.
    end
    [buf.string, command]
  ensure
    f&.unlink
  end

  it "reports a parse failure for a malformed schema" do
    out, = check_schema("SCHEMA bad;\nENTITY e\n  NOT EXPRESS ((( ;\n")
    expect(out).to include("[error] parse_failure:")
    expect(out).to include("1 error(s)")
  end

  it "keeps a valid schema clean" do
    out, = check_schema("SCHEMA ok;\nENTITY e;\nEND_ENTITY;\nEND_SCHEMA;\n")
    expect(out).to include("0 error(s)")
    expect(out).not_to include("parse_failure")
  end

  it "exposes parse failures in the json output" do
    f = Tempfile.new(["gh413json", ".exp"])
    f.write("SCHEMA bad;\nENTITY e\n  NOT EXPRESS ((( ;\n")
    f.close
    command = described_class.new({ json: true })
    buf = StringIO.new
    command.instance_variable_set(:@output, buf)
    begin
      command.run(f.path)
    rescue StandardError
      nil
    end
    f.unlink
    payload = JSON.parse(buf.string.lines.last)
    expect(payload["valid"]).to be(false)
    expect(payload["errors"].map { |e| e["id"] }).to include("parse_failure")
  end
end
