# frozen_string_literal: true

require "spec_helper"

# Diagnostic for the windows compiled-set write no-op observed via suma:
# the native extension is available and parsing succeeds, yet the
# artifact never appears. Pin down which guard refuses the write.
RSpec.describe "windows compiled-set diagnostics" do
  let(:dir) { Dir.mktmpdir("expressir-diag") }
  let(:files) do
    %w[syntax syntax_formatted remark].filter_map do |stem|
      path = File.expand_path("../syntax/#{stem}.exp", __dir__)
      File.exist?(path) ? path : nil
    end
  end

  after { FileUtils.remove_entry(dir) }

  it "reports every compiled-set guard state" do
    puts "diag NATIVE_AVAILABLE=#{Expressir::Express::Core::NATIVE_AVAILABLE}"
    puts "diag Core::Set defined=#{Expressir::Core.const_defined?(:Set, false)}"
    puts "diag core_set_available?=#{Expressir::Express::Parser.core_set_available?}" rescue puts "diag core_set_available? raised: #{$!.message}"
    puts "diag batch_available?=#{Expressir::Express::Parser.batch_available?}" rescue puts "diag batch_available? raised: #{$!.message}"
    puts "diag Core.write_set=#{Expressir::Core.respond_to?(:write_set)}"

    set_path = File.join(dir, "schema-closure.exscs")
    repo = Expressir::Express::Parser.from_files(files, compiled_set: set_path)
    puts "diag repo=#{repo.class}"
    puts "diag artifact exists=#{File.exist?(set_path)}"
    puts "diag dir listing=#{Dir[File.join(dir, '*')].map { |f| File.basename(f) }.inspect}"
    expect(File.exist?(set_path)).to be(true)
  end
end
