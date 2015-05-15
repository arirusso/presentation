module Presentation

  class Context

    attr_accessor :environment, :pdf, :screenshots, :title

    def initialize(options = {})
      @environment = Environment.new
      @title = options[:title]
      @screenshots = []
    end

    def video(file)
      stage do
        Element::Video.play(file)
      end
    end

    def text(content)
      stage do
        Element::Text.display(content)
      end
    end

    def audio(file)
    end

    def youtube(url)
    end

    def browser(url)
      stage do
        Element::Browser.open(url)
      end
    end

    def image(url)
      stage do
        Element::Image.display(url)
      end
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

    def stage(&block)
      @screenshots << Screenshot.capture(@stage) unless @stage.nil?
      @stage = yield
    end

  end

end
