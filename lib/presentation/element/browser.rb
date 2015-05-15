module Presentation

  module Element

    class Browser

      include HasID

      def initialize(environment, url)
        @environment = environment
        @url = url
        @has_been_launched = false
      end

      def launched?
        @has_been_launched
      end

      def open
        self.class.browser(@environment).open(@url)
        @has_been_launched = true
      end

      class << self

        def open(environment, url)
          browser = new(environment, url)
          browser.open
          browser
        end

        def browser(environment)
          @browser ||= {}
          @browser[environment] ||= External::Chrome.new(environment)
        end

      end

    end

  end

end
