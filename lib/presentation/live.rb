module Presentation

  module Live

    def new_presentation(options = {})
      @context = ::Presentation.new(options)
    end

    def a(file)
      @context.audio(file)
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

    def p(url)
      @context.page(url)
    end
    alias_method :b, :p

    def y(id)
      @context.youtube(id)
    end

    def pdf!
      @context.create_pdf
    end

  end

end
