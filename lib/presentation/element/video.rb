module Presentation

  module Element

    class Video

      class << self

        def play(file)
          video = new(file)
          video.play
          video
        end

        def player
          @player ||= External::Mplayer.new
        end

      end

      def initialize(file)
        @file = file
      end

      def play
      end

    end

  end

end
