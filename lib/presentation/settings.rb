module Presentation

  class Settings

    DEFAULT = {
      :temp_dir => "/tmp/presentation"
    }

    attr_accessor :display
    attr_writer :temp_dir

    def initialize(profile)
      @profile = profile
      populate_defaults
    end

    def temp_dir
      @temp_dir || DEFAULT[:temp_dir]
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
