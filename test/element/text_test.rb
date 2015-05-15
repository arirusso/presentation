require "helper"

class Presentation::Element::TextTest < Minitest::Test

  context "Context" do

    setup do
      Presentation::Configurable.add(Presentation::Element::Text)
      @environment = Presentation::Environment.new
    end

    context "#display" do

      setup do
        @text = Presentation::Element::Text.new("hello")
      end

      should "display text" do
        #@text.display
      end

    end

    context "#template_path" do

      setup do
        @text = Presentation::Element::Text.new("hello")
      end


    end

  end

end
