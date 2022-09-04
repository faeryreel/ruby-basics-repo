module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def define_instances_count
      class << self
        attr_accessor :instances_count
      end

      @instances_count ||= 0
    end

    def instances
      @instances_count
    end
  end

  module InstanceMethods

    private

    def register_instance
      self.class.define_instances_count
      self.class.instances_count += 1
    end
  end
end