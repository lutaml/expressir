module Expressir
  module ModelElementSpecHelper
    def loop_model_attrs(model, drop_model, result)
      model.class.model_attrs.each do |attr|
        value = model.send(attr)
        drop_value = drop_model.send(attr)
    
        case value
        when Array
          value.each_with_index do |v, i|
            dv = drop_value[i]

            if v.is_a? ::Expressir::Model::ModelElement
              loop_model_attrs(v, dv, result)
            else
              # puts "Expecting #{model.class.name} model_attr: #{attr} " \
              #      "value: #{v} equals to #{drop_model.class.name} " \
              #      "model_attr: #{attr} value: #{dv}"

              result << {
                model: model.class.name,
                attr: attr,
                value: v,
                drop_model: drop_model.class.name,
                drop_value: dv
              }
            end
          end.compact
        when ::Expressir::Model::ModelElement
          loop_model_attrs(value, drop_value, result)
        else
          # puts "Expecting #{model.class.name} model_attr: #{attr} " \
          #      "value: #{value} equals to #{drop_model.class.name} " \
          #      "model_attr: #{attr} value: #{drop_value}"
        
          result << {
            model: model.class.name,
            attr: attr,
            value: value,
            drop_model: drop_model.class.name,
            drop_value: drop_value
          }
        end
      end
    end
  end
end
