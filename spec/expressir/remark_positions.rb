# Where does each tail remark of a schema end up?
# For every remark whose text starts with rNN: the model node that owns it after the parse, its placement, and
# the line of format(no_remarks: false) that carries it (or NOT WRITTEN).
# usage: ruby remark_positions.rb remark_positions.exp [--formatted]
#   --formatted: print the formatted schema instead of the table
require "expressir"

path = ARGV[0] or abort "usage: ruby remark_positions.rb <schema.exp> [--formatted]"
model = Expressir::Express::Parser.from_file(path)
out = model.format(no_remarks: false)
if ARGV.include?("--formatted")

  exit
end

found = {}
walk = lambda do |obj, where, seen|
  next if obj.nil? || seen[obj.object_id]

  case obj
  when Array then seen[obj.object_id] = true
                  obj.each_with_index { |v, i| walk.(v, "#{where}[#{i}]", seen) }
  else
    next unless obj.class.name.to_s.start_with?("Expressir::Model")

    seen[obj.object_id] = true
    name = obj.class.name.split("::").last
    name += "(#{obj.id})" if obj.respond_to?(:id) && obj.id.is_a?(String) && name != "ExpFile"
    here = where.empty? ? name : "#{where}/#{name}"
    Array(obj.respond_to?(:untagged_remarks) ? obj.untagged_remarks : nil).each do |r|
      found[r.text[0, 3]] = [here, r.placement] if r.respond_to?(:text) && r.text.to_s =~ /\Ar\d\d/
    end
    obj.instance_variables.each do |iv|
      next if %i[@parent @untagged_remarks @core_wire].include?(iv)

      v = obj.instance_variable_get(iv)
      walk.(v, "#{here}.#{iv.to_s.delete('@')}", seen) if v.is_a?(Array) || v.class.name.to_s.start_with?("Expressir::Model")
    end
  end
end
walk.(model, "", {})

defined?(Expressir::Express::Core) && Expressir::Express::Core::NATIVE_AVAILABLE

File.readlines(path).each do |l|
  m = l.match(/-- (r\d\d) (.*)/) or next
  found[m[1]]
  line = out.lines.find { |x| x.include?("-- #{m[1]} ") }
  line ? "on: #{line.strip.sub(/\s*-- r\d\d.*/, '')}" : "NOT WRITTEN"
  "on its own line" if line&.strip&.start_with?("--")
end
