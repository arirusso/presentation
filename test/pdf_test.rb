require "helper"

class Presentation::PDFTest < Minitest::Test

  context "PDF" do

    setup do
      Presentation::Configurable.add(Presentation::Screenshot)
      @environment = Presentation::Environment.new
      @elements = []
      @elements << Presentation::Element::Text.new("hi")
      @elements << Presentation::Element::Text.new("hello again")
      @elements << Presentation::Element::Text.new("bye")
      @screenshots = @elements.map { |element| Presentation::Screenshot.new(element) }
      @screenshots.each(&:capture)
      sleep(1)
      @pdf = Presentation::PDF.new(@screenshots, :title => "test!")
    end

    context "#write" do

      should "write file" do
        refute_nil @pdf.write
      end

    end

  end

end
