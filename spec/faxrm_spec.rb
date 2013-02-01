require 'spec_helper'

describe Fax::Faxrm do

  before do
    Fax.configuration = nil
    ENV['SENDFAX_PATH'] = '/path/to/somewhere'
    ENV['FAXSTAT_PATH'] = '/another/path'
    ENV['FAXRM_PATH']   = '/final/path'
  end

  describe 'removing faxes' do
    it 'removes a fax created by same user' do
      fake_faxrm_response = "Job 8 removed.\n"
      
      Fax::Faxrm.any_instance.stub(:faxrm).and_return(fake_faxrm_response)

      Fax::faxrm.rm(8).should == true
    end

    it 'doesnt remove a fax created by a differnt user' do
      fake_faxrm_response = "504 Cannot kill job: Operation not permitted."

      Fax::Faxrm.any_instance.stub(:faxrm).and_return(fake_faxrm_response)

      Fax::faxrm.rm(8).should == false
    end

    it 'force removes a fax created by a different user' do
      fake_faxrm_response = true
      Fax::Faxrm.any_instance.stub(:force_rm).and_return(fake_faxrm_response)

      Fax::faxrm.force_rm(8).should == true
    end
    
  end

end