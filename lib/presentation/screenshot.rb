module Presentation

  class Screenshot

    include Configurable

    attr_reader :element

    def initialize(element)
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
      "#{settings.temp_dir}/#{filename}"
    end

    def timestamp
      @timestamp ||= Time.now.to_i
    end

    def filename
      "#{id}_#{@element.id}_#{timestamp}.png"
    end

    private

    def invocation
      "/usr/sbin/screencapture #{path} -x"
    end

    class << self

      def capture(element)
        screenshot = new(element)
        screenshot.capture
        screenshot
      end

      def next_id
        @last_id ||= 0
        @last_id += 1
      end

    end

  end

  ::Presentation::Configurable.add(Screenshot)

end
