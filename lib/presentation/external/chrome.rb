module Presentation

  module External

    class Chrome

      include Configurable

      attr_reader :process
      attr_writer :data_dir, :path

      DEFAULT = {
        :data_dir => "/tmp/presentation/chrome",
        :path => "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
      }.freeze

      def data_dir
        @data_dir || DEFAULT[:data_dir]
      end

      def path
        @path || DEFAULT[:path]
      end

      def open(url)
        invoke = invocation(url)
        @process = ::Presentation::Process.new(invoke)
      end

      def open?
        !@process.nil?
      end

      private

      def start_position
        width = settings.display[:width] * settings.display_index
        "#{width},#{0}"
      end

      def invocation(url)
        "open -n -a #{path} --args #{url} --new-window --start-fullscreen --window-position=#{start_position} --user-data-dir=#{data_dir}"
      end

    end

    ::Presentation::Configurable.add(Chrome)

  end

end
