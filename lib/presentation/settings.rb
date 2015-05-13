module Presentation

  class Settings

    attr_accessor :display

    def initialize(profile)
      populate_defaults(profile)
    end

    private

    def populate_defaults(profile)
      # display in highest number monitor available by default
      @display = profile.displays.last
    end

  end

end
