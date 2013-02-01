module Fax
  class Sendfax

    # man sendfax
    attr_accessor :subject, :from, :to, :fax_number, :document

    def initialize(options={})
      configure_from_env
      raise Fax::ConfigError if Fax.configuration.sendfax_path.nil?
      if options.empty?
        options[:document]    = '/tmp/cool.pdf'
        options[:fax_number]  = 'james@2037691544'
        options[:from]        = 'James Gem Example'
      end
      @document = '/tmp/cool.pdf'
    end

    def configure_from_env
      Fax::Configuration.new
    end

    private
    def sendfax
      `#{Fax.configuration.sendfax_path} -f "#{@from}" -d "#{@to}@#{@fax_number}" -h #{Fax.configuration.sendfax_host} #{@document}`
    end

  end
end