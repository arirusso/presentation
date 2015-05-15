module Presentation

  module Element

    class Video

      include Configurable
      include HasID

      def initialize(file)
        @file = file
        @has_been_launched = false
      end

      def launched?
        @has_been_launched
      end

      def play
        Video.player.play(@file)
        @has_been_launched = true
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
          if @player.nil?
            display_id = environment.settings.display_index
            @player ||= External::MPlayer.new(:flags => "-fs -vo corevideo:device_id=#{display_id} -framedrop -zoom -osdlevel 0")
          end
          @player
        end

      end

    end

    ::Presentation::Configurable.add(Video)

  end

end
