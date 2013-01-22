require 'spec_helper'

describe Fax::Faxstat do

  before do
    Fax.configuration = nil
    ENV['SENDFAX_PATH'] = '/path/to/somewhere'
    ENV['FAXSTAT_PATH'] = '/another/path'
  end

  describe 'running' do

    it 'checks the status of the HylaFAX scheduler' do
      fake_faxstat_response = "HylaFAX scheduler on dev.teladoc.com: Running\r\n"
      Fax::Faxstat.any_instance.stub(:faxstat).and_return(fake_faxstat_response)

      Fax.faxstat.running?.should == true
    end

  end

  describe 'jobs' do

    it 'checks the presence of a job that does not exist' do
      fake_faxstat_response = "HylaFAX scheduler on dev.teladoc.com: Running\r\n\nJID  Pri S  Owner Number       Pages Dials     TTS Status\n2    127 W jthull 2037421719    0:0   0:12         \r\n"
      Fax::Faxstat.any_instance.stub(:faxstat).and_return(fake_faxstat_response)

      Fax.faxstat.job(19).should == nil
    end

    it 'checks the presence of a job that does exist' do
      fake_faxstat_response = "HylaFAX scheduler on dev.teladoc.com: Running\r\n\nJID  Pri S  Owner Number       Pages Dials     TTS Status\n2    127 W jthull 2037421719    0:0   0:12         \r\n"
      Fax::Faxstat.any_instance.stub(:faxstat).and_return(fake_faxstat_response)

      Fax.faxstat.job(2).should_not == nil
    end

    it 'checks the status of 2 jobs' do
      fake_faxstat_response = "HylaFAX scheduler on jthullbery.dev.teladoc.com: Running\r\n\nJID  Pri S  Owner Number       Pages Dials     TTS Status\n3    127 W jthull 2037421719    0:0   0:12         \r\n\nJID  Pri S  Owner Number       Pages Dials     TTS Status\n2    127 F jthull 2037421719    0:0   0:12         Kill time expired\r\n"
      Fax::Faxstat.any_instance.stub(:faxstat).and_return(fake_faxstat_response)

      Fax.faxstat.job(2)[:status].should == 'F'
      Fax.faxstat.job(3)[:status].should == 'W'
    end

  end
  
end