module Presentation

  module Live

    def new_presentation(options = {})
      @context = ::Presentation.new(options)
    end

    def v(file)
      @context.video(file)
    end

    def i(url)
      @context.image(url)
    end

    def t(content)
      @context.text(content)
    end

    def b(url)
      @context.browser(url)
    end

    def y(id)
      @context.youtube(id)
    end

  end

end
