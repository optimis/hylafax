require 'spec_helper'

describe Fax::Faxstat do

  describe 'status' do

    it 'checks the status of the HylaFAX scheduler' do
      fake_faxstat_response = "HylaFAX scheduler on dev.teladoc.com: Running\r\n"
      Fax::Faxstat.any_instance.stub(:faxstat).and_return(fake_faxstat_response)

      status = Fax::Faxstat.status

      search_results.first.drug_name.should == 'Allegra'
    end
  end
  
end