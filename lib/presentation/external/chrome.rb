module Presentation

  module External

    class Chrome

      attr_writer :path

      DEFAULT = {
        :path => "/Applications/Google\ Chrome.app//Contents//MacOS/Google\ Chrome"
      }.freeze

      def initialize(settings)
        @settings = settings
      end

      def path
        @path || DEFAULT
      end

      def open
        position = "#{@settings.display[:width]},#{@settings.display[:height]}"
        "#{path} --start-fullscreen --window-position=#{position}"
      end

    end

  end

end
