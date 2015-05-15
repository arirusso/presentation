module Presentation

  class Context

    attr_accessor :elements, :environment, :pdf, :screenshots, :title

    def initialize(options = {})
      @environment = Environment.new
      @title = options[:title]
      @screenshots = []
      @elements = []
    end

    def video(file)
      stage do
        Element::Video.play(@environment, file, :history => @elements)
      end
    end

    def text(content)
      stage do
        last_element = @stage
        Element::Text.display(@environment, content, :history => @elements)
      end
    end

    def audio(file)
    end

    def page(url)
      stage do
        Element::Page.open(@environment, url)
      end
    end

    def youtube(url)
      stage do
        Element::Youtube.open(@environment, url)
      end
    end

    def image(url)
      stage do
        Element::Image.display(@environment, url)
      end
    end

    def join
      stage.join
    end

    def create_pdf
      if !@screenshots.empty? && !@stage.nil? && @screenshots.last.element != @stage
        @screenshots << Screenshot.capture(@environment, @stage)
        sleep(1)
      end
      @pdf = PDF.write(@environment, @screenshots, :title => @title)
      @pdf
    end

    private

    def stage(&block)
      @screenshots << Screenshot.capture(@environment, @stage) unless @stage.nil?
      element = yield
      @stage = element
      @elements << element
    end

  end

end
