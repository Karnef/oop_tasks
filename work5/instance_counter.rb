module InstanceCounter
    def self.included(base)
      base.extend ClassMethods
      base.include InstanceMethods
    end

  module ClassMethods
    attr_accessor :instances
    
  end

  protected

  module InstanceMethods
    def register_instance
      self.class.instances = 0 if self.class.instances.nil?
      self.class.instances += 1
    end  
  end
end