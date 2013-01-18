module Fax
  class Faxstat

    attr_accessor :response, :jobs, :running

    def initialize(options={})
      configure_from_env
      raise Fax::ConfigError if Fax.configuration.faxstat_path.nil?

    end

    def running?
      @running
    end

    def configure_from_env
      Fax::Configuration.new
    end

    private
    def faxstat
      @response = `#{Fax.configuration.faxstat_path} -sdl`
    end

    def parse_response
      tmp = @response.split("\r")
      @running = tmp[0].split(":").last.include?("Running")
      
    end

  end
end