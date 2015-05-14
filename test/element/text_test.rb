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

    context "#signature" do

      setup do
        @text = Presentation::Element::Text.new("hello")
      end

      should "have correct id" do
        @sig = Digest::SHA256.hexdigest(@text.text + @text.created_at.to_s)
        assert_equal @sig, @text.signature
      end

    end

    context "#render_html" do

      setup do
        @text = Presentation::Element::Text.new("hello")
        @html = @text.render_html
      end

      should "generate html" do
        refute_nil @html
        assert @html.match(/hello/)
      end

    end

    context "#temp_path" do

      setup do
        @text = Presentation::Element::Text.new("hello")
      end

      should "have correct temp path" do
        assert @text.temp_path.match(/\/#{@text.signature}\.html\z/)
      end

    end

  end

end
