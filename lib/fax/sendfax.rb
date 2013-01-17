module fax
  class Sendfax

    def initialize(options={})
      configure_from_env
      raise Fax::ConfigError if Fax.configuration.sendfax_path.nil?

    end

    def configure_from_env
      Fax::Configuration.new
    end

  end
end