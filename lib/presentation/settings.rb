module Presentation

  class Settings

    attr_accessor :display

    def initialize(profile)
      @profile = profile
      populate_defaults
    end

    def display_index
      @profile.displays.index(@display)
    end

    private

    def populate_defaults
      # display in highest number monitor available by default
      @display = @profile.displays.last
    end

  end

end
