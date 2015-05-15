require "helper"

class Presentation::Element::TextTest < Minitest::Test

  context "Context" do

    setup do
      @environment = Presentation::Environment.new
    end

    context "#display" do

      setup do
        @text = Presentation::Element::Text.new(@environment, "hello")
      end

      should "display text" do
        #@text.display
      end

    end

    context "#template_path" do

      setup do
        @text = Presentation::Element::Text.new(@environment, "hello")
      end


    end

  end

end
