module Presentation

  module External

    class Chrome

      DEFAULT = {
        :path => "/Applications/Google\ Chrome.app//Contents//MacOS/Google\ Chrome"
      }.freeze

      def open
        "#{DEFAULT[:path]} --start-fullscreen --window-position=1000,0"
      end

    end

  end

end
