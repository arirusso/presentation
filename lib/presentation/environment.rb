module Presentation

  class Environment

    attr_reader :profile, :settings

    def initialize
      @profile = Profile.new
      @settings = Settings.new(@profile)
      configure
      setup
    end

    private

    def configure
      Configurable.modules.each { |mod| mod.configure(self) }
    end

    def setup
      Dir.mkdir(@settings.temp_dir) unless Dir.exists?(@settings.temp_dir)
    end

  end

end
