#

# Libs
require "cocoa"
require "mplayer-ruby"

# Modules
require "presentation/element"
require "presentation/external"

# Classes
require "presentation/context"
require "presentation/log"
require "presentation/profile"
require "presentation/settings"

module Presentation

  VERSION = "0.0.1"

  def self.new(*args, &block)
    Context.new(*args, &block)
  end

end
