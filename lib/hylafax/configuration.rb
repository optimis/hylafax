module Hylafax
  class Configuration
    attr_accessor :sendfax_path, :sendfax_host, :faxstat_path, :faxrm_path, :faxrm_admin_password

    def initialize(*args)
      if args[0].is_a?(Hash)
        # old yaml config uses different variable names
        sendfax_path          = args[0]['sendfax_path']
        sendfax_host          = args[0]['sendfax_host']
        faxstat_path          = args[0]['faxstat_path']
        faxrm_path            = args[0]['faxrm_path']
        faxrm_admin_password  = args[0]['faxrm_admin_password']
      end
      @sendfax_path           = sendfax_path          || ENV['FAX_SENDFAX_PATH']
      @sendfax_host           = sendfax_host          || ENV['FAX_SENDFAX_HOST']
      @faxstat_path           = faxstat_path          || ENV['FAX_FAXSTAT_PATH']
      @faxrm_path             = faxrm_path            || ENV['FAX_FAXRM_PATH']
      @faxrm_admin_password   = faxrm_admin_password  || ENV['FAX_FAXRM_ADMIN_PASSWORD']
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

end