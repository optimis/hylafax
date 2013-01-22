require 'spec_helper'

describe Fax::Faxstat do

  describe 'running' do

    before do
      Fax.configuration = nil
      ENV['SENDFAX_PATH'] = '/path/to/somewhere'
      ENV['FAXSTAT_PATH'] = '/another/path'
    end

    it 'checks the status of the HylaFAX scheduler' do
      fake_faxstat_response = "HylaFAX scheduler on dev.teladoc.com: Running\r\n"
      Fax::Faxstat.any_instance.stub(:faxstat).and_return(fake_faxstat_response)

      Fax.faxstat.running?.should == true
    end

  end
  
end