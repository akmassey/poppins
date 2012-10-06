require 'spec_helper'

describe Poppins::ReferenceLink do

  before :each do
    @link = "http://google.com"
    @label = "Google"
  end

  it "should initialize with a link and a label" do
    rl = Poppins::ReferenceLink.new(@link, @label)
    rl.url.should == @link
    rl.link_text.should == @label
  end

  it "should correctly produce the end reference" do 
    rl = Poppins::ReferenceLink.new(@link, @label)
    rl.as_end_reference.should == "[Google]: http://google.com"
  end

  it "should correctly produce the in-text version of the label" do
    rl = Poppins::ReferenceLink.new(@link, @label)
    rl.as_found_in_text.should == "[Google]"
  end
  
end
