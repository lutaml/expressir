# frozen_string_literal: true

require "rake"

namespace :model_attrs do
  desc "Regenerate the class→attrs oracle table (expressir#634)"
  task :generate do
    require "expressir/tools/model_attr_table"
    path = File.expand_path("../spec/fixtures/model_attr_table.json", __dir__)
    Expressir::Tools::ModelAttrTable.write(path)
    puts "wrote #{path}"
  end
end
