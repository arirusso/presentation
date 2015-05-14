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
    end

    private

    def invocation
      "/usr/sbin/screencapture #{id}_#{@element.id}_#{Time.now.to_i}.png -x"
    end

    class << self

      def capture(element)
        screenshot = new(element)
        screenshot.capture
      end

      def next_id
        @last_id ||= 0
        @last_id += 1
      end

    end

  end

end
