module Hylafax
  class Faxrm
    require 'expect'
    require 'pty'
    attr_accessor :response

    def initialize(job_id=nil)
      result = nil
      configure_from_env
      raise Hylafax::ConfigError if Hylafax.configuration.faxstat_path.nil?
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
          w_f.print "#{Hylafax.configuration.faxrm_admin_password}\n"
        end

        if r_f.expect(/Job ([\d]+) removed./)
          result = true
        end
      end
      result
    end

    private

    def faxrm(job_id)
      `#{Hylafax.configuration.faxrm_path} #{job_id}`
    end

    def configure_from_env
      if defined?(Rails) && File.exists?(file=Rails.root.join('config/fax.yml'))
        yaml_config = YAML.load_file file
        Hylafax.configuration = Hylafax::configuration.new yaml_config[Rails.env]
      end
      Hylafax.configuration ||= Hylafax::Configuration.new
    end

  end
end