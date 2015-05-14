require "helper"

class Presentation::Element::TextTest < Minitest::Test

  context "Context" do

    setup do
      Presentation::Configurable.add(Presentation::Element::Text)
      @environment = Presentation::Environment.new
    end

    context "#id" do

      setup do
        @text = Presentation::Element::Text.new("hello")
      end

      should "have correct id" do
        @id = Digest::SHA256.hexdigest(@text.text + @text.created_at.to_s)
        assert_equal @id, @text.id
      end

    end

    context "#render_html" do

      setup do
        @text = Presentation::Element::Text.new("hello")
        @html = @text.render_html
      end

      should "generate html" do
        p @html
        refute_nil @html
      end

    end

    context "#temp_path" do

      setup do
        @text = Presentation::Element::Text.new("hello")
      end

      should "have correct temp path" do
        assert @text.temp_path.match(/\/#{@text.id}\.html\z/)
      end

    end

  end

end
