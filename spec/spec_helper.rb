require 'rspec/autorun'
require 'webmock/rspec'
require 'fax'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'
end