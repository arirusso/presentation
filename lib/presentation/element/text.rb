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

      def signature
        @id ||= Digest::SHA256.hexdigest(@text + @created_at.to_s)
      end

      def temp_path
        "#{settings.temp_dir}/#{signature}.html"
      end

      def write_temp_file
        File.open(temp_path, "w") { |file| file.write(render_html) }
      end

      def render_html
        template_path = File.expand_path("#{TEMPLATE_PATH}/template.html.erb", __FILE__)
        template = File.new(template_path).read
        ERB.new(template).result(instance_eval { binding })
      end

      def display
        write_temp_file
        Browser.browser.open(temp_path)
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
