module Presentation

  class Context

    def initialize
      @environment = Environment.new
      initialize_externals
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

    private

    def initialize_externals
      External.modules.each { |mod| mod.configure(@environment) }
    end

  end

end
