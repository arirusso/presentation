module Presentation

  module External

    module Configuration

      def self.included(base)
        base.send(:extend, ClassMethods)
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

end
