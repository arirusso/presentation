module Presentation

  module Element

    class Text

      include Configurable
      include HasID

      attr_reader :text, :created_at

      TEMPLATE_PATH = "../text"

      def initialize(text)
        @text = text
        @created_at = Time.now
        @has_been_launched = false
      end

      def launched?
        @has_been_launched
      end

      def template_url
        "http://localhost:8080/index.html"
      end

      def content_to_js
        "$('.text').hide(); $('.text').text('#{@text}'); $('.text').fadeIn(1000);"
      end

      def display
        unless Browser.browser.open?
          Browser.browser.open(template_url)
          sleep(2)
        end
        Browser.browser.send_content(content_to_js)
        @has_been_launched = true
      end

      class << self

        def display(text)
          text_obj = new(text)
          text_obj.display
          text_obj
        end

        def browser
          @browser ||= External::Chrome.new
        end

      end

    end

    ::Presentation::Configurable.add(Text)

  end

end
