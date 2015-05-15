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

      def send_content(content)
        ensure_repl
        @repl.evaluate(content)
      end

      def open(url)
        unless @repl.nil?
          @repl.close
          @repl = nil
        end
        invoke = invocation(url)
        @process = ::Presentation::Process.new(invoke)
      end

      def open?
        !@process.nil?
      end

      private

      def ensure_repl
        if @repl.nil?
          @repl = WebRepl::REPL.new(:host => "localhost", :port => 9997)
          @repl.start(:background => true)
        end
      end

      def start_position
        width = settings.display[:width] * settings.display_index
        "#{width},#{0}"
      end

      def invocation(url)
        "open -n -a #{path} --args #{url} --new-window --start-fullscreen --window-position=#{start_position} --user-data-dir=#{data_dir}"
      end

    end
  end

end
