require 'spec_helper'

describe Poppins::Document do

  before do
    @file = File.dirname(__FILE__) + '/../data/sample.md'
    @inline_file = File.dirname(__FILE__) + '/../data/sample_inline.md'
  end

  it "should be instantiatable" do 
    Poppins::Document.new(@file).should_not be_nil
  end

  it "should accurately identify inline links in the text" do 
    ils = [["succeeded", "http://www.google.com"], 
           ["character", "http://kungfugrippe.com"], 
           ["under\nconfinement", "http://docs.python.org/library/index.html"],
           ["slaves", "http://daringfireball.net/markdown"]]
    Poppins::Document.new(@inline_file).inline_links.should == ils
  end

  it "should convert inline links to reference links" do 
    Poppins::Document.new(@inline_file).convert_inline_to_reference.should == File.open(@file).readlines.join
  end

  it "should accurately identify reference links in the text" do
    Poppins::Document.new(@file).reference_links.should == [["succeeded", "2"], ["character", "4"], ["under confinement", "3"], ["slaves", "1"]]

  end

  it "should accuaretely create a hash of the references" do 
    Poppins::Document.new(@file).labels.should == {"1"=>"http://daringfireball.net/markdown/", "2"=>"http://www.google.com/", "3"=>"http://docs.python.org/library/index.html", "4"=>"http://www.kungfugrippe.com/"}
  end

  it "should correctly idenfity the order of the links as they appear in the text" do
    Poppins::Document.new(@file).order_of_first_appearance.should == ["2", "4", "3", "1"]
  end

  it "should correctly generate a new list of references" do 
    Poppins::Document.new(@file).ordinal_references.should == ["[1]: http://www.google.com/", "[2]: http://www.kungfugrippe.com/", "[3]: http://docs.python.org/library/index.html", "[4]: http://daringfireball.net/markdown/"]
  end
end
