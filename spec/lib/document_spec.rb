require 'spec_helper'

describe Poppins::Document do

  before do
    @file = File.dirname(__FILE__) + '/../data/sample.md'
  end

  it "should be instantiatable" do 
    Poppins::Document.new(@file).should_not be_nil
  end

  it "should accurately identify links in the text" do 
    Poppins::Document.new(@file).links.should == [["succeeded", "2"], ["character", "4"], ["under confinement", "3"], ["slaves", "1"]]
  end

  it "should accuaretely identify a hash of the references" do 
    Poppins::Document.new(@file).labels.should == {"1"=>"http://daringfireball.net/markdown/", "2"=>"http://www.google.com/", "3"=>"http://docs.python.org/library/index.html", "4"=>"http://www.kungfugrippe.com/"}
  end

  it "should correctly idenfity the order of the links as they appear in the text" do
    Poppins::Document.new(@file).order_of_first_appearance.should == ["2", "4", "3", "1"]
  end

  it "should correctly generate a new list of references" do 
    Poppins::Document.new(@file).ordinal_references.should == ["[1]: http://www.google.com/", "[2]: http://www.kungfugrippe.com/", "[3]: http://docs.python.org/library/index.html", "[4]: http://daringfireball.net/markdown/"]
  end
end
