module Presentation

  class Context

    attr_accessor :environment, :pdf, :screenshots, :title

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

    def image(url)
      stage(Element::Image.display(url))
    end

    def join
      stage.join
    end

    def create_pdf
      if !@screenshots.empty? && !@stage.nil? && @screenshots.last.element != @stage
        @screenshots << Screenshot.capture(@stage)
        sleep(1)
      end
      @pdf = PDF.write(@screenshots, :title => @title)
    end

    private

    def stage(element)
      @screenshots << Screenshot.capture(@stage) unless @stage.nil?
      @stage = element
    end

  end

end
