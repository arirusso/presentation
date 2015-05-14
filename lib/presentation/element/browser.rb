module Presentation

  module Element

    class Browser

      include HasID
      
      def initialize(url)
        @url = url
      end

      def open
        Browser.browser.open(@url)
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
