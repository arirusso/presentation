module Presentation

  module Element

    module Browser

      def self.included(base)
        base.send(:include, HasID)
        base.send(:extend, ClassMethods)
      end

      def initialize(environment, url)
        @environment = environment
        @url = url
        @has_been_launched = false
      end

      def launched?
        @has_been_launched
      end

      def open
        Browser.browser(@environment).open(@url)
        @has_been_launched = true
      end

      def self.browser(environment)
        @browser ||= {}
        @browser[environment] ||= External::Chrome.new(environment)
      end

      module ClassMethods

        def open(environment, url)
          browser = new(environment, url)
          browser.open
          browser
        end

      end

    end

  end

end
