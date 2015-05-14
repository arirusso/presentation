module Presentation

  module Thread

    def self.new(&block)
      @thread = ::Thread.new do
        begin
          yield if block_given?
        rescue Exception => exception
          ::Thread.main.raise(exception)
        end
      end
      @thread.abort_on_exception = true
      @thread
    end

  end

end
