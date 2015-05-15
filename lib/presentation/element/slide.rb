module Presentation

  module Element

    module Slide

      def self.included(base)
        base.send(:include, Configurable)
        base.send(:include, HasID)
        base.send(:extend, ClassMethods)
        base.send(:attr_reader, :content, :created_at)
      end

      def initialize(environment, content)
        @environment = environment
        @content = content
        @created_at = Time.now
        @has_been_launched = false
      end

      def launched?
        @has_been_launched
      end

      def display(options = {})
        history = options[:history]
        last = history.last unless history.nil?
        was_other_element = !last.nil? && !last.kind_of?(Slide)
        if was_other_element
          history.each { |element| element.cleanup if element.respond_to?(:cleanup) }
          sleep(1)
        end
        if was_other_element || !Slide.browser(@environment).open?
          open_browser
        end
        Slide.browser(@environment).send_content(content_to_js)
        @has_been_launched = true
      end

      def cleanup
        Slide.browser(@environment).send_content("window.close();")
      end

      private

      def template_url
        "http://localhost:9393/index.html"
      end

      def open_browser
        Slide.browser(@environment).open(template_url)
        sleep(2)
      end

      def self.browser(environment)
        @browser ||= {}
        @browser[environment] ||= External::Chrome.new(environment)
      end

      module ClassMethods

        def display(environment, text, options = {})
          text_obj = new(environment, text)
          text_obj.display(options)
          text_obj
        end
        alias_method :open, :display

      end

    end

  end

end
