require "fax/version"

module Fax
  class << self

    def sendfax(*args)
      Fax::Sendfax.new().send
    end
    
  end
end