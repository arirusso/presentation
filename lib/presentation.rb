#

# Libs
require "cocoa"
require "digest"
require "mplayer-ruby"
require "open4"
require "prawn"
require "web-repl"

# Modules
require "presentation/configurable"
require "presentation/element"
require "presentation/external"
require "presentation/process"
require "presentation/thread"

# Classes
require "presentation/context"
require "presentation/environment"
require "presentation/log"
require "presentation/pdf"
require "presentation/profile"
require "presentation/screenshot"
require "presentation/settings"

module Presentation

  VERSION = "0.0.1"

  def self.new(*args, &block)
    Context.new(*args, &block)
  end

end
