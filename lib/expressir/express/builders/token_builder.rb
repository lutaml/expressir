# frozen_string_literal: true

# Token builders - operator tokens that return nil.
# These are used as separators in lists and don't produce model objects.

# Operator tokens - return nil
%i[op_comma op_colon op_decl op_delim op_leftparen op_rightparen
   op_leftbracket op_rightbracket op_left_curly_brace op_right_curly_brace
   op_period op_pipe op_double_backslash op_double_pipe op_double_asterisk
   op_asterisk op_slash op_plus op_minus op_less_equal op_greater_equal
   op_less_greater op_less_than op_greater_than op_equals
   op_colon_less_greater_colon op_colon_equals_colon
   op_query_begin op_query_end op_question_mark].each do |token|
  Builder.register(token) { |_d| nil }
end
