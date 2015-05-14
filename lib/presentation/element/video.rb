module Presentation

  module Element

    class Video

      include HasID

      def initialize(file)
        @file = file
      end

      def play
        Video.player.play(@file)
      end

      def join
        Video.player.join
      end

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

    end

  end

end
