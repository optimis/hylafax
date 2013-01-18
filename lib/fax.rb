require "fax/version"
require "fax/configuration"
require "fax/sendfax"

module Fax
  class << self

    def sendfax(*args)
      Fax::Sendfax.new().send
    end

    def faxstat(*args)
      Fax::Faxstat.status
    end
    
  end
end