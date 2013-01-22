module Fax
  class Configuration
    attr_accessor :sendfax_path, :faxstat_path

    def initialize(*args)
      if args[0].is_a?(Hash)
        # old yaml config uses different variable names
        sendfax_path = args[0]['sendfax_path']
        faxstat_path = args[0]['faxstat_path']
      end
      @sendfax_path = sendfax_path || ENV['SENDFAX_PATH']
      @faxstat_path = faxstat_path || ENV['FAXSTAT_PATH']
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