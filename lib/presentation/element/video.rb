module Presentation

  module Element

    class Video

      include Configurable
      include HasID

      def initialize(environment, file)
        @environment = environment
        @file = file
        @has_been_launched = false
      end

      def launched?
        @has_been_launched
      end

      def play
        self.class.player(@environment).play(@file)
        @has_been_launched = true
      end

      def join
        self.class.player(@environment).join
      end

      class << self

        def play(environment, file)
          video = new(environment, file)
          video.play
          video
        end

        def player(environment)
          @player ||= {}
          if @player[environment].nil?
            display_id = environment.settings.display_index
            mplayer = External::MPlayer.new(environment, :flags => "-fs -vo corevideo:device_id=#{display_id} -framedrop -zoom -osdlevel 0")
            @player[environment] ||= mplayer
          end
          @player[environment]
        end

      end

    end

  end

end
