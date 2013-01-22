require 'rspec/autorun'
require 'fax'
require 'pry'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'
end