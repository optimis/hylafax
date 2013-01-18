require 'spec_helper'

describe Fax::Configuration do
  describe 'when no sendfax_path is specified' do
    before do
      ENV['SENDFAX_PATH'] = '/path/to/no/where'
      Fax.configuration = nil
      Fax.configure do |config|
      end
    end

    it 'defaults to ENV["SENDFAX_PATH"]' do
      Fax.configuration.sendfax_path.should == '/path/to/no/where'
    end
  end

  describe 'when sendfax_path is specified' do
    before do
      Fax.configure do |config|
        config.sendfax_path = '/path/to/some/where'
      end
    end

    it 'is used instead of the ENV variable' do
      Fax.configuration.sendfax_path.should == '/path/to/some/where'
    end
  end

  describe 'when a hash is passed in from an old yaml instead' do
    it 'uses those values' do
      Fax.configuration = Fax::Configuration.new({'sendfax_path' => '/path/to/any/where' })
      Fax.configuration.sendfax_path.should == '/path/to/any/where'
    end
  end
end