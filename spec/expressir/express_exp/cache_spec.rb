require "yaml"
require "tempfile"
require "spec_helper"
require "expressir/express_exp/parser"
require "expressir/express_exp/cache"

RSpec.describe Expressir::ExpressExp::Cache do
  TEST_VERSION = "0.0.0"

  describe ".to_file" do
    it "exports an object" do
      temp_file = Tempfile.new

      repository = Expressir::Model::Repository.new

      begin
        Expressir::ExpressExp::Cache.to_file(temp_file, repository, test_overwrite_version: TEST_VERSION)

        size = File.size(temp_file)

        expect(size).to be > 0
      ensure
        temp_file.close
        temp_file.unlink
      end
    end
  end

  describe ".from_file" do
    it "parses a file" do
      temp_file = Tempfile.new

      repository = Expressir::Model::Repository.new

      begin
        Expressir::ExpressExp::Cache.to_file(temp_file, repository, test_overwrite_version: TEST_VERSION)

        result = Expressir::ExpressExp::Cache.from_file(temp_file, test_overwrite_version: TEST_VERSION)

        expect(result).to be_instance_of(Expressir::Model::Repository)
      ensure
        temp_file.close
        temp_file.unlink
      end
    end

    it "fails parsing a file from a different Expressir version" do
      temp_file = Tempfile.new

      repository = Expressir::Model::Repository.new

      begin
        Expressir::ExpressExp::Cache.to_file(temp_file, repository, test_overwrite_version: TEST_VERSION)

        expect do
          Expressir::ExpressExp::Cache.from_file(temp_file)
        end.to raise_error(Expressir::ExpressExp::CacheLoadError)
      ensure
        temp_file.close
        temp_file.unlink
      end
    end
  end
end
