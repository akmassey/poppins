require 'spec_helper'

describe Poppins::InlineLink do

  before :each do
    @url = "http://google.com"
    @link_text = "Google"
  end

  it "should initialize with a url and a link_text" do
    il = Poppins::InlineLink.new(@url, @link_text)
    il.url.should == @url
    il.link_text.should == @link_text
  end

  it "should correctly produce the in-text version of the link_text" do
    il = Poppins::InlineLink.new(@url, @link_text)
    il.as_found_in_text.should == "[Google](http://google.com)"
  end
  
  it "should be able to change the link text" do
    il = Poppins::InlineLink.new(@url, @link_text)
    il.link_text.should == @link_text
    il.link_text = "A Search Engine"
    il.link_text.should == "A Search Engine"
  end

  it "should have a regex to identify itself" do
    il = Poppins::InlineLink.new(@url, @link_text)

    sample_text = "This is a [more complex](http://google.com) example."
    good_match = sample_text.match(il.regex)
    good_match.should_not be nil

    bad_sample_text = "This example [shouldn't work](http://yahoo.com)."
    bad_match = bad_sample_text.match(il.regex)
    bad_match.should be nil
  end
end

