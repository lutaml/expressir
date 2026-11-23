# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

RSpec.describe Expressir::Express::Parser, :ruby_lane do
  let(:source_text) do
    lines = ["SCHEMA source;"]
    100.times do |index|
      lines.push("ENTITY item#{index};", "  value : STRING;", "  (* café *)", "END_ENTITY;")
    end
    lines.push("END_SCHEMA;", "")
    lines.join("\r\n")
  end

  it "keeps native batch source offsets aligned with physical UTF-8 bytes" do
    skip "native batch lane unavailable" unless
      Expressir::Express::Core::NATIVE_AVAILABLE &&
        Expressir::Core.const_defined?(:BatchStream, false)

    Dir.mktmpdir("expressir-source-bytes-") do |directory|
      first_path = File.join(directory, "source.exp")
      second_path = File.join(directory, "second.exp")
      File.binwrite(first_path, source_text)
      File.binwrite(second_path, source_text.sub("SCHEMA source;", "SCHEMA second;"))
      target_paths = [first_path, second_path]

      allow(File).to receive(:read).and_wrap_original do |original, file, *args, **options|
        result = original.call(file, *args, **options)
        if target_paths.include?(file.to_s) && !options.fetch(:mode, "r").include?("b")
          result.gsub("\r\n", "\n")
        else
          result
        end
      end

      repository = described_class.from_files(
        target_paths, skip_references: true, include_source: true
      )

      expect(repository.files.length).to eq(2)
      repository.files.each do |exp_file|
        schema = exp_file.schemas.first
        expect(schema.entities.length).to eq(100)
        last_entity = schema.entities.last
        expect(last_entity.id).to eq("item99")
        expect(last_entity.source).to include("ENTITY item99;", "café")
        expect(last_entity.source_offset + last_entity.source_length).to be <=
          File.binread(exp_file.path).bytesize
        expect(last_entity.source.encoding).to eq(Encoding::UTF_8)
      end
    end
  end
end
