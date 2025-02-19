require "tempfile"
require "spec_helper"
require_relative "../../../lib/expressir/express/parser"
require_relative "../../../lib/expressir/express/cache"

TEST_VERSION = "0.0.0".freeze

RSpec.describe Expressir::Express::Cache do
  describe ".to_file" do
    it "exports an object" do |example|
      print "\n[#{example.description}] "
      temp_file = Tempfile.new

      repository = Expressir::Model::Repository.new

      begin
        Expressir::Express::Cache.to_file(temp_file, repository, test_overwrite_version: TEST_VERSION)

        size = File.size(temp_file)

        expect(size).to be > 0
      ensure
        temp_file.close
        temp_file.unlink
      end
    end
  end

  describe ".from_file" do
    it "throws an exception if the cache file does not exist" do |example|
      print "\n[#{example.description}] "
      expect do
        Expressir::Express::Cache.from_file("non-existing-file", test_overwrite_version: TEST_VERSION)
      end.to raise_error(Errno::ENOENT)
    end

    it "loads a cache file" do |example|
      print "\n[#{example.description}] "
      temp_file = Tempfile.new

      repository = Expressir::Model::Repository.new

      begin
        Expressir::Express::Cache.to_file(temp_file, repository, test_overwrite_version: TEST_VERSION)

        result = Expressir::Express::Cache.from_file(temp_file, test_overwrite_version: TEST_VERSION)

        expect(result).to be_instance_of(Expressir::Model::Repository)
      ensure
        temp_file.close
        temp_file.unlink
      end
    end

    it "fails parsing a cache from a different Expressir version" do |example|
      print "\n[#{example.description}] "
      temp_file = Tempfile.new

      repository = Expressir::Model::Repository.new

      begin
        Expressir::Express::Cache.to_file(temp_file, repository, test_overwrite_version: TEST_VERSION)

        expect do
          Expressir::Express::Cache.from_file(temp_file)
        end.to raise_error(Expressir::Error)
      ensure
        temp_file.close
        temp_file.unlink
      end
    end
  end
end
