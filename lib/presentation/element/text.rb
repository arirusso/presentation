module Presentation

  module Element

    class Text

      include Configurable
      include HasID

      attr_reader :text, :created_at

      TEMPLATE_PATH = "../text"

      def initialize(environment, text)
        @environment = environment
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
        "$('.text').hide(); $('.text').text('#{@text}'); $('.text').fadeIn(800);"
      end

      def display(options = {})
        history = options[:history]
        last = history.last unless history.nil?
        was_other_element = !last.nil? && !last.kind_of?(Text)
        if !Browser.browser.open?
          open_browser
        elsif was_other_element
          history.each { |element| element.unfocus if element.respond_to?(:unfocus) }
          sleep(1)
          open_browser
        end
        Browser.browser.send_content(content_to_js)
        @has_been_launched = true
      end

      def unfocus
        Browser.browser.send_content("window.close();")
      end

      private

      def open_browser
        Browser.browser.open(template_url)
        sleep(2)
      end

      class << self

        def display(environment, ext, options = {})
          text_obj = new(environment, text)
          text_obj.display(options)
          text_obj
        end

        def browser
          @browser ||= External::Chrome.new
        end

      end

    end

  end

end
