module Fax

  # Raised when no base url is defined for the application
  class ConfigError < RuntimeError; end


  # Raised when no parameters are passed into the sendfax application
  class ParamError < RuntimeError; end

  # Raised when an api calls raise
  module Error; end

  # tags all exceptions with Fax::Error
  def self.tag_errors
    yield
  rescue Exception => error
    error.extend Fax::Error
    raise
  end
end
