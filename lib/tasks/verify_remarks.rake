# frozen_string_literal: true

# `rake verify:remarks` — the remark conservation gate. Runs only the
# production-scale checks (`:production_scale` tag; see spec_helper's
# filter), which the default suite excludes: they parse a full-size
# schema and cost about a minute.
RSpec::Core::RakeTask.new(:"verify:remarks") do |task|
  task.rspec_opts = "--tag production_scale"
end
