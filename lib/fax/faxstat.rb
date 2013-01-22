module Fax
  class Faxstat

    attr_accessor :response, :jobs, :running

    def initialize(options={})
      configure_from_env
      @jobs = {}
      raise Fax::ConfigError if Fax.configuration.faxstat_path.nil?
    end

    def running?
      update_status
      @running
    end

    def job( job_id )
      update_status
      @jobs[job_id]
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
      tmp = @response.split("\n")
      @running = tmp[0].split(":").last.include?("Running")
      tmp_jobs = tmp[(1..-1)].each{|job| job.split("\n")}.delete_if{|str| str.empty? || str.eql?("\n")}
      unless tmp_jobs.empty?
        key = tmp_jobs[0].split(" ")
        tmp_jobs[(1..-1)].each do |job|
          value = job.split(" ")
          @jobs[value[0].to_i] = Hash[key.zip value]
        end
      end
    end

    def configure_from_env
      Fax.configure do |config|
      end
    end

  end
end