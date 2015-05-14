module Presentation

  module Configurable

    def self.add(mod)
      modules << mod
    end

    def self.modules
      @modules ||= []
    end

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    def configured?
      !environment.nil?
    end

    def environment
      self.class.environment
    end

    def profile
      environment.profile
    end

    def settings
      environment.settings
    end

    module ClassMethods

      def self.extended(base)
        base.class.send(:attr_reader, :environment)
      end

      def configure(environment)
        @environment = environment
      end

    end

  end

end
