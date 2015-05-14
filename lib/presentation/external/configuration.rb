module Presentation

  module External

    module Configuration

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      def settings
        self.class.settings
      end

      def profile
        self.class.profile
      end

      module ClassMethods

        def self.extended(base)
          base.class.send(:attr_reader, :profile, :settings)
        end

        def configure(profile, settings)
          @profile = profile
          @settings = settings
        end

      end

    end

  end

end
