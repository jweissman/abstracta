module Abstracta
  # this is kind of a weird mixin
  # trying to reduce duplication across world/territory/occupant
  # the cost may be too great :/
  #module Entity 
  #  def self.included(base)
  #    base.send(:include, InstanceMethods)
  #  end

  #  module InstanceMethods
  #    extend Forwardable
  #    attr_reader :age

  #    def age
  #      @age ||= 0
  #    end
  #    
  #    def age!
  #      @age = age + 1
  #    end

  #    def current_developer
  #      @developer ||= Developer.for(self)
  #    end

  #    def step(*args)
  #      current_developer.step(*args)
  #    end
  #  end
  #end
end
