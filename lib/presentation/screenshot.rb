module Presentation

  class Screenshot

    include Configurable

    def self.capture(element)
      screenshot = new(element)
      screenshot.capture
    end

    def capture(element)
      invoke = invocation(element)
      @process = ::Presentation::Process.new(invoke)
    end

    private

    def invocation(element)
      "/usr/sbin/screencapture #{Time.now.to_i}.png"
    end

  end

end
