require 'spec_helper'

describe Fax::Sendfax do

  describe 'when sendfax is not define' do
    before do
      ENV['SENDFAX_PATH'] = '/path/to/nowhere'
      Fax.configuration = nil
      Fax.configure do |config|
      end
    end
  
    if 'returns error' do
    end

  end
  
end