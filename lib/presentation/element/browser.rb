module Presentation

  module Element

    class Browser

      include HasID

      def initialize(url)
        @url = url
        @has_been_launched = false
      end

      def launched?
        @has_been_launched
      end

      def open
        Browser.browser.open(@url)
        @has_been_launched = true
      end

      class << self

        def open(url)
          browser = new(url)
          browser.open
          browser
        end

        def browser
          @browser ||= External::Chrome.new
        end

      end

    end

  end

end
