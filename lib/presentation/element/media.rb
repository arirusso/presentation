module Presentation

  module Element

    module Media

      def self.included(base)
        base.send(:include, Configurable)
        base.send(:include, HasID)
        base.send(:extend, ClassMethods)
      end

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
        was_other_element = !last.nil? && !last.kind_of?(Media)
        if was_other_element
          history.each { |element| element.cleanup if element.respond_to?(:unfocus) }
        end
        begin
          player = Media.player(@environment, :refresh => was_other_element)
          player.play(@file)
        rescue Exception => exception
          cleanup
          retry
        end
        @has_been_launched = true
      end

      def join
        Media.player(@environment).join
      end

      def cleanup
        Media.cleanup(@environment)
      end

      def self.cleanup(environment)
        @player[environment].quit unless @player[environment].nil?
        @player[environment] = nil
      end

      def self.player(environment, options = {})
        @player ||= {}
        if !@player[environment].nil? && !!options[:refresh]
          cleanup(environment)
          sleep(1)
        end
        if @player[environment].nil?
          display_id = environment.settings.display_index
          mplayer = External::MPlayer.new(environment, :flags => "-fs -vo corevideo:device_id=#{display_id} -framedrop -zoom -osdlevel 0")
          @player[environment] ||= mplayer
        end
        @player[environment]
      end

      module ClassMethods

        def play(environment, file, options = {})
          media = new(environment, file)
          media.play(options)
          media
        end

      end

    end

  end

end
