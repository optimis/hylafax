require "fax/version"
require "fax/configuration"
require "fax/sendfax"
require "fax/faxstat"

module Fax
  class << self

    def sendfax(*args)
      Fax::Sendfax.new().send
    end

    def faxstat(*args)
      Fax::Faxstat.new
    end
    
  end
end