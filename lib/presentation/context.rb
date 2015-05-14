module Presentation

  class Context

    def initialize
      @environment = Environment.new
    end

    def video(file)
      @stage = Element::Video.play(file)
    end

    def audio(file)
    end

    def youtube(url)
    end

    def browser(url)
      @stage = Element::Browser.open(url)
    end

    def join
      @stage.join
    end

  end

end
