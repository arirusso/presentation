module Presentation

  module Element

    class Image

      include Slide

      alias_method :url, :content

      private

      def content_to_js
        "$('.content').hide(); $('#image').html('<img src=\\'#{@content}\\' />'); $('#image').fadeIn(800);"
      end

    end

  end

end
