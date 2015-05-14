module Presentation

  class Context

    attr_accessor :pdf, :screenshots, :title

    def initialize(options = {})
      @environment = Environment.new
      @title = options[:title]
      @screenshots = []
    end

    def video(file)
      stage(Element::Video.play(file))
    end

    def text(content)
      stage(Element::Text.display(content))
    end

    def audio(file)
    end

    def youtube(url)
    end

    def browser(url)
      stage(Element::Browser.open(url))
    end

    def join
      stage.join
    end

    def create_pdf
      @pdf = PDF.write(@screenshots, :title => @title)
    end

    private

    def stage(element)
      @screenshots << Screenshot.capture(element) unless @stage.nil?
      @stage = element
    end

  end

end
