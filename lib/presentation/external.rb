module Presentation

  module External

    extend self

    def add(mod)
      modules << mod
    end

    def modules
      @modules ||= []
    end

  end

end

# Modules
require "presentation/external/controls"
require "presentation/external/configuration"

# Classes
require "presentation/external/chrome"
require "presentation/external/mplayer"
