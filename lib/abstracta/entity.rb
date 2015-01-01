module Abstracta
  # this is kind of a weird mixin
  # trying to reduce duplication across world/territory/occupant
  module Entity 
    def self.included(base)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      extend Forwardable
      attr_reader :age

      def age
	@age ||= 0
      end
      
      def age!
	@age = age + 1
      end

      def step(*args)
	(@dev ||= Developer.for(self)).step(*args)
      end
    end
  end
end
