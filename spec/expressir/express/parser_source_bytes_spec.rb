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

  context "with multiline CRLF remarks" do
    let(:remark_source) do
      <<~EXP.gsub("\n", "\r\n")
        (* café header
        second header line *)
        SCHEMA source;
        (*"source" tagged first
        tagged second *)
        ENTITY item;
          value : STRING;
          (* café untagged
          second comment line *)
        END_ENTITY;
        (*"source.item.note" item first
        item second *)
        END_SCHEMA;
      EXP
    end

    let(:native_lanes) { %i[core batch] }

    %i[ruby core batch string].each do |lane|
      context "with the #{lane} lane" do
        let(:native_lane) { native_lanes.include?(lane) }

        it "normalizes logical remarks while preserving physical source in the #{lane} lane" do
          skip "native core unavailable" if native_lane &&
            !Expressir::Express::Core::NATIVE_AVAILABLE

          Dir.mktmpdir("expressir-remark-newlines-") do |directory|
            first_path = File.join(directory, "source.exp")
            second_path = File.join(directory, "second.exp")
            File.binwrite(first_path, remark_source)
            File.binwrite(second_path, remark_source.sub("SCHEMA source;", "SCHEMA second;"))
            original = remark_source.dup
            exp_file = case lane
                       when :batch
                         described_class.from_files([first_path, second_path],
                                                    skip_references: true,
                                                    include_source: true).files.first
                       when :string
                         described_class.from_exp(remark_source, use_native: false,
                                                                 skip_references: true,
                                                                 include_source: true)
                       else
                         described_class.from_file(first_path, use_core: lane == :core,
                                                               use_native: lane != :ruby,
                                                               skip_references: true,
                                                               include_source: true)
                       end

            schema = exp_file.schemas.first
            entity = schema.entities.first
            expect(schema.header).to eq("café header\nsecond header line")
            expect(schema.remarks).to eq(["tagged first\ntagged second"])
            expect(entity.remark_items.first.remarks).to eq(["item first\nitem second"])
            expect(entity.untagged_remarks.map(&:text)).to include("café untagged\n  second comment line")
            expect(entity.untagged_remarks.first.source_offset).to eq(
              remark_source.b.index("(* café untagged".b),
            )
            [schema, entity].each do |node|
              captured = node.instance_variable_get(:@source)
              expect(captured).to eq(remark_source.byteslice(node.source_offset, node.source_length))
              expect(captured).to include("\r\n")
              expect(captured.encoding).to eq(Encoding::UTF_8)
            end
            expect(Expressir::Express::Formatter.format(exp_file)).to include("tagged first\ntagged second")
            expect(remark_source).to eq(original)
            expect(File.binread(first_path)).to eq(original.b)
          end
        end
      end
    end
  end
end
