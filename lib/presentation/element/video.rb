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

      def play(options = {})
        history = options[:history]
        last = history.last unless history.nil?
        was_other_element = !last.nil? && !last.kind_of?(Video)
        player_options = {
          :refresh => was_other_element
        }
        self.class.player(@environment, player_options).play(@file)
        @has_been_launched = true
      end

      def join
        self.class.player(@environment).join
      end

      class << self

        def play(environment, file, options = {})
          video = new(environment, file)
          video.play(options)
          video
        end

        def player(environment, options = {})
          @player ||= {}
          if !@player[environment].nil? && !!options[:refresh]
            @player[environment].quit
            @player[environment] = nil
            sleep(1)
          end
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
