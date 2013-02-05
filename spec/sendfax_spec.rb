require 'spec_helper'

describe Fax::Sendfax do

  before do
    Fax.configuration = nil
    ENV['SENDFAX_PATH'] = '/path/to/somewhere'
    ENV['SENDFAX_HOST'] = '0.0.0.0'
    ENV['FAXSTAT_PATH'] = '/another/path'
    ENV['FAXRM_PATH']   = '/final/path'
  end

  describe 'sending a fax' do

    it 'successfully sends a fax' do

      fake_sendfax_response = "request id is 19 (group id 29) for host 0.0.0.0 (1 file)\n"
      Fax::Sendfax.any_instance.stub(:sendfax).and_return(fake_sendfax_response)      

      tmp = Fax::Sendfax.new
      tmp.send.should == true
      tmp.request_id.should == 19
      tmp.group_id.should == 29

    end

  end

end