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

      def display(options = {})
        history = options[:history]
        last = history.last unless history.nil?
        was_other_element = !last.nil? && !last.kind_of?(Text)
        if !self.class.browser(@environment).open?
          open_browser
        elsif was_other_element
          history.each { |element| element.unfocus if element.respond_to?(:unfocus) }
          sleep(1)
          open_browser
        end
        self.class.browser(@environment).send_content(content_to_js)
        @has_been_launched = true
      end

      def unfocus
        self.class.browser(@environment).send_content("window.close();")
      end

      private

      def template_url
        "http://localhost:9393/index.html"
      end

      def content_to_js
        "$('.text').hide(); $('.text').text('#{@text}'); $('.text').fadeIn(800);"
      end

      def open_browser
        self.class.browser(@environment).open(template_url)
        sleep(2)
      end

      class << self

        def display(environment, text, options = {})
          text_obj = new(environment, text)
          text_obj.display(options)
          text_obj
        end

        def browser(environment)
          @browser ||= {}
          @browser[environment] ||= External::Chrome.new(environment)
        end

      end

    end

  end

end
