require "helper"

class Presentation::ScreenshotTest < Minitest::Test

  context "Screenshot" do

    setup do
      @text = Presentation::Element::Text.new("hi")
      @screenshot = Presentation::Screenshot.new(@text)
    end

    context "#capture" do

      should "take screenshot" do
        refute_nil @screenshot.capture
      end

    end

  end

end
