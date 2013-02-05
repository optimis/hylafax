module Fax
  class Sendfax

    # man sendfax
    attr_accessor :response, :subject, :from, :to, :fax_number, :document, :request_id, :group_id, :files

    def initialize(options={})
      configure_from_env
      raise Fax::ConfigError if Fax.configuration.sendfax_path.nil?
      unless options.empty?
        options[:document]    = '/tmp/cool.pdf'
        options[:fax_number]  = 'james@2037691544'
        options[:from]        = 'James Gem Example'
      end
      @document = '/tmp/cool.pdf'
    end

    def send
      @response = sendfax
      parse_response
      return true
    end


    private
    def sendfax
      `#{Fax.configuration.sendfax_path} -f "#{@from}" -d "#{@to}@#{@fax_number}" -h #{Fax.configuration.sendfax_host} #{@document}`
    end

    def parse_response
      tmp = @response.split('(')
      @request_id = tmp[0].gsub(/request id is ([\d]+) /) {|a| $1}.to_i
      grp_tmp = tmp[1].split(")")
      @group_id = grp_tmp[0].gsub(/group id ([\d]+)/) {|a| $1}.to_i
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