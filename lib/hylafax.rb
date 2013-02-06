require "hylafax/version"
require "hylafax/errors"
require "hylafax/configuration"
require "hylafax/sendfax"
require "hylafax/faxstat"
require "hylafax/faxrm"

module Hylafax
  class << self

    def sendfax(*args)
      Hylafax::Sendfax.new(args).send
    end

    def faxstat(*args)
      Hylafax::Faxstat.new
    end

    def faxrm(*args)
      Hylafax::Faxrm.new(args[0])
    end
    
  end
end