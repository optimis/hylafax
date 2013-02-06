require 'rspec/autorun'
require 'hylafax'
require 'pry'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'
end