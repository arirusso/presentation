module Presentation

  class Context

    def initialize
      @profile = Profile.new
      @settings = Settings.new(@profile)
    end

    def video(file)
      @stage = Element::Video.play(file)
    end

    def audio(file)
    end

    def youtube(url)
    end

    def browser(url)
    end

    def join
      @stage.join
    end

  end

end
