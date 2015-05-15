module Presentation

  module Configurable

    def configured?
      !@environment.nil?
    end

    def environment
      @environment
    end

    def profile
      @environment.profile
    end

    def settings
      @environment.settings
    end

  end

end
