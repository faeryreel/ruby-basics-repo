# frozen_string_literal: true

module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(attr_name, validation_type, *parameters)
      validations
      @validations << { :attr_name => attr_name, :validation_type => validation_type, :parameter => parameters }
    end

    def validate_by_type(validation, attr_val)
      case validation[:validation_type]
      when :presence
        raise "#{validation[:attr_name].capitalize} shouldn't be nil or empty!" if attr_val.nil? || attr_val.to_s.empty?
      when :format
        raise "Wrong format!" if attr_val !~ validation[:parameter].first
      when :type
        raise "Wrong type!" if attr_val.class != validation[:parameter].first
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attr_val = self.instance_variable_get("@#{validation[:attr_name]}".to_sym)
        self.class.validate_by_type(validation, attr_val)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
