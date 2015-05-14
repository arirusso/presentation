module Presentation

  module Element

    class Image < Browser

      alias_method :display, :open

      class << self
        alias_method :display, :open
      end

    end

  end

end
