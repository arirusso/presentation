require "helper"

class Presentation::PDFTest < Minitest::Test

  context "PDF" do

    setup do
      @environment = Presentation::Environment.new
      @elements = []
      @elements << Presentation::Element::Text.new(@environment, "hi")
      @elements << Presentation::Element::Text.new(@environment, "hello again")
      @elements << Presentation::Element::Text.new(@environment, "bye")
      @screenshots = @elements.map { |element| Presentation::Screenshot.new(@environment, element) }
      @screenshots.each(&:capture)
      sleep(1)
      @pdf = Presentation::PDF.new(@environment, @screenshots, :title => "test!")
    end

    context "#write" do

      should "write file" do
        refute_nil @pdf.write
      end

    end

  end

end
