# Regenerates expected declaration-level model JSON for the
# expressir-core fixture tests, using the real Expressir model as the
# source of truth.
#
#   cd crates/expressir-core
#   bundle exec ruby generate/expected_model.rb <file.exp> <out.json>

require "expressir"
require "json"

path, out_path = ARGV
repo = Expressir::Express::Parser.from_file(path)

def ids(collection)
  (collection || []).map(&:id).compact
end

out = {
  schemas: repo.schemas.map do |s|
    {
      name: s.id,
      version: s.version&.value,
      entities: s.entities.map do |e|
        {
          name: e.id,
          attributes: ids(e.attributes).map { |n| { name: n } },
          whereRules: ids(e.where_rules).map { |l| { label: l } },
        }
      end,
      types: s.types.map { |t| { name: t.id, whereRules: ids(t.where_rules).map { |l| { label: l } } } },
      functions: s.functions.map { |f| { name: f.id, parameters: ids(f.parameters) } },
      procedures: s.procedures.map { |p| { name: p.id, parameters: ids(p.parameters) } },
      rules: s.rules.map { |r| { name: r.id, whereRules: ids(r.where_rules).map { |l| { label: l } } } },
      subtypeConstraints: s.subtype_constraints.map { |sc| { name: sc.id } },
      constants: s.constants.map { |c| { name: c.id } },
    }
  end,
}

File.write(out_path, JSON.pretty_generate(out))
warn "wrote #{out_path}"
