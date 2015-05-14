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
          @player ||= External::MPlayer.new
        end

      end

      def initialize(file)
        @file = file
      end

      def play
        Video.player.play(@file)
      end

      def join
        Video.player.join
      end

    end

  end

end
