module Presentation

  module External

    # Wrapper for MPlayer functionality
    class MPlayer

      attr_reader :player, :state

      # @param [Hash] options
      # @option options [String] :flags MPlayer command-line flags to use on startup
      def initialize(options = {})
        @invoker = Invoker.new(options)
        @state = State.new
        @threads = []
      end

      # Play a media file
      # @param [String] file
      # @return [Boolean]
      def play(file)
        @player ||= @invoker.ensure_invoked(file, @state)
        if @player.nil?
          false
        else
          @threads << Thread.new do
            @player.load_file(file)
            handle_start
          end
          true
        end
      end

      # Is MPlayer active?
      # @return [Boolean]
      def active?
        !(@player ||= @invoker.player).nil?
      end

      # Toggles pause
      # @return [Boolean]
      def pause
        @state.toggle_pause
        @player.pause
        @state.pause?
      end

      # Handle events while the player is running
      # @return [Boolean]
      def playback_loop
        loop do
          #handle_eof if handle_eof?
          sleep(0.05)
        end
        true
      end

      # Shortcut to send a message to the MPlayer
      # @return [Object]
      def mplayer_send(method, *args, &block)
        if @player.nil? && MPlayer::Slave.method_defined?(method)
          # warn
        else
          @messenger.send_message do
            @player.send(method, *args, &block)
          end
        end
      end

      # Does the MPlayer respond to the given message?
      # @return [Boolean]
      def mplayer_respond_to?(method, include_private = false)
        (@player.nil? && MPlayer::Slave.method_defined?(method)) ||
        @player.respond_to?(method)
      end

      # Cause MPlayer to exit
      # @return [Boolean]
      def quit
        @player.quit
        @threads.each(&:kill)
        @invoker.destroy
        true
      end

      private

      # Get player output from stdout
      def get_player_output
        @player.stdout.gets.inspect.strip.gsub(/(\\n|[\\"])/, '').strip
      end

      # Handle the beginning of playback for a single media file
      def handle_start
        loop until get_player_output.size > 1
        @state.handle_start
      end

      # Invoke MPlayer
      class Invoker

        attr_reader :player, :thread

        # @param [Hash] options
        # @option options [String] :flags MPlayer command-line flags to use on startup
        def initialize(options = {})
          @flags = "-fixed-vo -idle"
          @flags += " #{options[:flags]}" unless options[:flags].nil?
          @player.nil?
          @thread = nil
        end

        def destroy
          @thread.kill unless @thread.nil?
        end

        # Ensure that the MPlayer process is invoked
        # @param [String] file The media file to invoke MPlayer with
        # @param [MMplayer::Player::State] state
        # @return [MPlayer::Slave]
        def ensure_invoked(file, state)
          if @player.nil? && @thread.nil?
            @thread = ::MMPlayer::Thread.new(:timeout => false) do
              @player = MPlayer::Slave.new(file, :options => @flags)
              state.handle_start
            end
          end
          @player
        end

      end

    end

  end
end
