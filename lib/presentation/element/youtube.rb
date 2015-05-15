module Presentation

  module Element

    class Youtube

      include Browser

      def initialize(environment, url, options = {})
        super(environment, url)
        @start = options[:start]
        populate_url
      end

      private

      def populate_url
        @url = "https://www.youtube.com/watch?v=#{@url}" unless @url.match(/youtube\.com/)
        @url += "#t=#{@start}" if !@start.nil? && !@url.match(/\#t/)
        @url
      end

    end

  end

end
