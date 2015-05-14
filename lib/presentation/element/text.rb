module Presentation

  module Element

    class Text

      include Configurable

      attr_reader :text, :created_at

      def initialize(text)
        @text = text
        @created_at = Time.now
      end

      def id
        @id ||= Digest::SHA256.hexdigest(@text + @created_at.to_s)
      end

      def temp_path
        "#{settings.temp_dir}/#{id}.html"
      end

      def write_temp_file
        File.open(yourfile, 'w') { |file| file.write("your text") }
      end

      def display
        write(@text)
        Browser.browser.open(@url)
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
