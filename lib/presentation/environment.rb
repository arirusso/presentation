module Presentation

  class Environment

    attr_reader :profile, :settings

    def initialize
      @profile = Profile.new
      @settings = Settings.new(@profile)
    end

  end

end
