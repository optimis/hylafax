module Fax
  class Configuration
    attr_accessor :sendfax_path

    def initialize(*args)
      if args[0].is_a?(Hash)
        # old yaml config uses different variable names
        sendfax_path = args[0]['sendfax_path']
      end
      @sendfax_path = sendfax_path || ENV['SENDFAX_PATH']
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