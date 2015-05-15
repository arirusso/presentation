module Presentation

  class Screenshot

    include Configurable

    attr_reader :element

    def initialize(environment, element)
      @environment = environment
      @element = element
    end

    def id
      @id ||= self.class.next_id
    end

    def capture
      invoke = invocation
      @process = ::Presentation::Process.new(invoke)
      self
    end

    def path
      paths.join(" ")
    end

    def paths
      filenames.map { |filename| "#{settings.temp_dir}/#{filename}" }
    end

    def timestamp
      @timestamp ||= Time.now.to_i
    end

    def filenames
      (0..@environment.profile.displays.count-1).to_a.map { |i| "#{id}_#{@element.id}_#{timestamp}_#{i}.png" }
    end

    private

    def invocation
      "/usr/sbin/screencapture #{path} -x"
    end

    class << self

      def capture(environment, element)
        screenshot = new(environment, element)
        screenshot.capture
        screenshot
      end

      def next_id
        @last_id ||= 0
        @last_id += 1
      end

    end

  end

end
