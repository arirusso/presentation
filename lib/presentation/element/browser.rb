module Presentation

  module Element

    class Browser

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

      def initialize(url)
        @url = url
      end

      def open
        Browser.browser.open(@url)
      end

    end

  end

end
