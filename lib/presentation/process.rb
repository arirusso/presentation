module Presentation

  module Process

    def self.new(invoke)
      pid, stdin, stdout, stderr = Open4::popen4(invoke)
      unless pid.nil?
        {
          :pid => pid,
          :stdin => stdin,
          :stdout => stdout,
          :stderr => stderr
        }
      end
    end

  end

end
