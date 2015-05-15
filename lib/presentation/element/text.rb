module Presentation

  module Element

    class Text

      include Slide

      alias_method :text, :content

      private

      def content_to_js
        "$('.content').hide(); $('#text').text('#{@content}'); $('#text').fadeIn(800);"
      end

    end

  end

end
