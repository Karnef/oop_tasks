module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = []

      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
      var_name_history << value
    end
    define_method("@#{name}_history".to_sym) { var_name_history }
  end
  
  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { inastance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise TypeError "Invalid value" unless class_name == self.class
      instance_variable_set(var_name, value)    
    end
  end
end
