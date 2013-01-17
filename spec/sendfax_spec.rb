require 'spec_helper'

describe Fax::Sendfax do

  describe 'when sendfax is not define' do
    before do
      ENV['SENDFAX'] = '/path/to/nowhere'
    end
  end

  
end