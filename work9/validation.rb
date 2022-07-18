module Validation
  def self.included(base)
    base.extend ClassMethod
    base.include ValidateMethods
  end 


  module ClassMethod
    def validate(attr_name, type, *params)
      @validations ||= []
      @validations << { attr_name: attr_name, type: type, params: params }      
    end
  end

  module ValidateMethods
    def validate!
      self.class.validations.each do |val|
        value = instance_variable_get("@#{val[:attr_name]}")
        validation_method = "validate_#{val[:type]}"
        parameter = val[:params]
        send(value, validation_method, *parameter)
      end
    end

    def validate_presence(value)
      raise "Err: empty value" if value.empty?
    end

    def validate_format(value, format)
      raise "Err: invalid format" unless value == format
    end

    def validate_type(value, type)
      raise "Value must be equal to class" if value.instance_of(type)
    end

    def valid?
      validate!
      true
    rescue StandartError
      false
    end
  end
end
