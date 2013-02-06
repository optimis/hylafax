require 'spec_helper'

describe Hylafax::Faxrm do

  before do
    Hylafax.configuration = nil
    ENV['FAX_SENDFAX_PATH'] = '/path/to/somewhere'
    ENV['FAX_FAXSTAT_PATH'] = '/another/path'
    ENV['FAX_FAXRM_PATH']   = '/final/path'
  end

  describe 'removing faxes' do
    it 'removes a fax created by same user' do
      fake_faxrm_response = "Job 8 removed.\n"
      
      Hylafax::Faxrm.any_instance.stub(:faxrm).and_return(fake_faxrm_response)

      Hylafax::faxrm.rm(8).should == true
    end

    it 'doesnt remove a fax created by a differnt user' do
      fake_faxrm_response = "504 Cannot kill job: Operation not permitted."

      Hylafax::Faxrm.any_instance.stub(:faxrm).and_return(fake_faxrm_response)

      Hylafax::faxrm.rm(8).should == false
    end

    it 'force removes a fax created by a different user' do
      fake_faxrm_response = true
      Hylafax::Faxrm.any_instance.stub(:force_rm).and_return(fake_faxrm_response)

      Hylafax::faxrm.force_rm(8).should == true
    end
    
  end

end