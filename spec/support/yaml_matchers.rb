require "yaml"

RSpec::Matchers.define :be_yaml_equivalent do |expected|
  match do |actual|
    actual_parsed = YAML.safe_load(actual)
    expected_parsed = YAML.safe_load(expected)
    actual_parsed == expected_parsed
  rescue Psych::SyntaxError => e
    @error = e
    false
  end

  failure_message do |actual|
    if @error
      "Expected valid YAML, but got syntax error: #{@error.message}"
    else
      actual_parsed = YAML.safe_load(actual)
      expected_parsed = YAML.safe_load(expected)
      "Expected YAML content to be equivalent, but got differences:\n" \
      "Expected: #{expected_parsed.inspect}\n" \
      "Actual:   #{actual_parsed.inspect}"
    end
  end

  failure_message_when_negated do |_actual|
    "Expected YAML content to be different, but they were equivalent"
  end

  description do
    "be YAML equivalent to the expected content"
  end
end
