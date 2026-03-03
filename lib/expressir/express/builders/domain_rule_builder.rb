# frozen_string_literal: true

module Expressir
  module Express
    module Builders
      # Builds domain_rule nodes.
      class DomainRuleBuilder
        def call(ast_data)
          inner_data = ast_data[:domain_rule] || ast_data

          id = Builder.build_optional(inner_data[:rule_label_id])
          expression = Builder.build_optional(inner_data[:expression])
          Expressir::Model::Declarations::WhereRule.new(id: id,
                                                        expression: expression)
        end
      end
    end
  end
end

Builder.register(:domain_rule, Expressir::Express::Builders::DomainRuleBuilder.new)
