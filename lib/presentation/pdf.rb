module Presentation

  class PDF

    include Configurable

    def self.write(environment, screenshots, options = {})
      pdf = new(environment, screenshots, options)
      pdf.write
      pdf
    end

    def initialize(environment, screenshots, options = {})
      @environment = environment
      @title = options[:title]
      @screenshots = screenshots
    end

    def path
      "#{filename}"
    end

    def filename
      title = @title || Time.now.to_s
      title.gsub!(/\W/, "")
      "#{title}.pdf"
    end

    def page_size
      [settings.display[:width], settings.display[:height]]
    end

    def write
      screenshots = @screenshots
      size = page_size
      Prawn::Document.generate(path, :margin => 0, :page_size => "A3", :page_layout => :landscape, :print_scaling => :none) do
        screenshots.each do |screenshot|
          image(screenshot.paths.last, :width => 1190.55)
          start_new_page(:layout => :landscape) unless screenshot == screenshots.last
        end
      end
      self
    end

  end

end
