module Fax
  class Faxrm
    require 'expect'
    require 'pty'
    attr_accessor :response

    def initialize(job_id=nil)
      result = nil
      configure_from_env
      raise Fax::ConfigError if Fax.configuration.faxstat_path.nil?
    end

    def rm(job_id)
      if job_id
        response = faxrm(job_id)
        if response.include?('removed')
          result = true
        else
          result = false
        end
      end
    end      

    def force_rm(job_id)
      result = false
      PTY.spawn("faxrm -a #{job_id}") do |r_f,w_f,pid|
        w_f.sync = true
        $expect_verbose = true

        r_f.expect(/^Password:/) do |output|
          w_f.print "#{Fax.configuration.faxrm_admin_password}\n"
        end

        if r_f.expect(/Job ([\d]+) removed./)
          result = true
        end
      end
      result
    end

    private

    def faxrm(job_id)
      `#{Fax.configuration.faxrm_path} #{job_id}`
    end

    def configure_from_env
      if defined?(Rails) && File.exists?(file=Rails.root.join('config/fax.yml'))
        yaml_config = YAML.load_file file
        Fax.configuration = Fax::configuration.new yaml_config[Rails.env]
      end
      Fax.configuration ||= Fax::Configuration.new
    end

  end
end