module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      define_method("#{attr}_history".to_sym) { instance_variable_get("@#{attr}_history".to_sym) }
      define_method("#{attr}_history=".to_sym) { instance_variable_set("@#{attr}_history".to_sym, []) unless instance_variable_get("@#{attr}_history".to_sym) }
      define_method(attr) { instance_variable_get("@#{attr}".to_sym) }
      define_method("#{attr}=".to_sym) do |value|
        var = instance_variable_get("@#{attr}_history".to_sym)
        var ||= []
        var << instance_variable_get("@#{attr}".to_sym) if var.empty?
        var << value
        instance_variable_set("@#{attr}_history".to_sym, var)
        instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    define_method(attr_name) { instance_variable_get("@#{attr_name}".to_sym) }
    define_method("#{attr_name}=".to_sym) do |value|
      raise "Wrong type!" if value.class != attr_class
      instance_variable_set("@#{attr_name}".to_sym, value)
    end
  end
end
