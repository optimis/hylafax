module Hylafax
  class Sendfax

    # man sendfax
    attr_accessor :call, :response, :subject, :from, :to, :fax_number, :document, :request_id, :group_id, :files

    def initialize(options={})
      configure_from_env
      raise Hylafax::ConfigError if Hylafax.configuration.sendfax_path.nil?
      # unless options.empty?
      #   options[:document]    = '/tmp/cool.pdf'
      #   options[:fax_number]  = 'james@2037691544'
      #   options[:from]        = 'James Gem Example'
      #   options[:document]    = '/tmp/cool.pdf'
      # end

      # @subject    = options[:subject]
      @document   = options[:document]
      @fax_number = options[:fax_number]
      @from       = options[:from]
      @to         = options[:to]
      
    end

    def send
      @response = sendfax
      parse_response
      return true
    end


    private
    def sendfax
      raise Hylafax::ParamError if @from.empty? || @to.empty? || @fax_number.empty? || @document.empty?
      @call = "#{HylafaxHylafax.configuration.sendfax_path} -f \"#{@from}\" -d \"#{@to}@#{@fax_number}\" -h #{Hylafax.configuration.sendfax_host} #{@document}"
      `#{@call}`
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
        Hylafax.configuration = Hylafax::configuration.new yaml_config[Rails.env]
      end
      Hylafax.configuration ||= Hylafax::Configuration.new
    end    

  end
end