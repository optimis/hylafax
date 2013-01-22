module Fax
  class Faxstat

    attr_accessor :response, :jobs, :running

    def initialize(options={})
      configure_from_env
      raise Fax::ConfigError if Fax.configuration.faxstat_path.nil?
    end

    def running?
      update_status
      @running
    end

    def job_status( job_id )
      update_status
      jobs[job_id].present?
    end

    private

    def update_status
      @response = faxstat
      handle_response
    end

    def faxstat
      `#{Fax.configuration.faxstat_path} -sdl`
    end

    def handle_response
      tmp = @response.split("\r")
      @running = tmp[0].split(":").last.include?("Running")
    end

    def configure_from_env
      Fax.configure do |config|
      end
    end

  end
end