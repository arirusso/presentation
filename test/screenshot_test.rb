require "helper"

class Presentation::ScreenshotTest < Minitest::Test

  context "Screenshot" do

    setup do
      @environment = Presentation::Environment.new
      @text = Presentation::Element::Text.new(@environment, "hi")
      @screenshot = Presentation::Screenshot.new(@environment, @text)
    end

    context "#capture" do

      should "take screenshot" do
        refute_nil @screenshot.capture
      end

    end

  end

end
