require 'spec_helper'
module Poppins

  describe Document do

    before do
      @file = File.dirname(__FILE__) + '/../data/sample.md'
      @clean_file = File.dirname(__FILE__) + '/../data/clean_formatted_sample.md'
      @inline_file = File.dirname(__FILE__) + '/../data/sample_inline.md'
      @unused_references_file = File.dirname(__FILE__) + '/../data/unused_references.md'
      @footnotes_file = File.dirname(__FILE__) + '/../data/foonotes.md'
    end

    it "should be instantiatable" do
      Document.new(@file).should_not be_nil
    end

    it "should accurately identify inline links in the text" do
      expected_ils = []
      expected_ils.push( InlineLink.new("http://www.google.com", "succeeded") )
      expected_ils.push( InlineLink.new("http://kungfugrippe.com", "character") )
      expected_ils.push( InlineLink.new("http://docs.python.org/library/index.html", "under\nconfinement") )
      expected_ils.push( InlineLink.new("http://daringfireball.net/markdown", "slaves") )

      actual_ils = Document.new(@inline_file).inline_links

      actual_ils.count.should == expected_ils.count

      for i in 0..(actual_ils.count-1)
        actual_ils[i].to_s.should == expected_ils[i].to_s
      end
    end

    it "should accurately identify reference links in the text" do
      expected_rls = []

      expected_rls.push( ReferenceLink.new("http://www.google.com", "succeeded", "2") )
      expected_rls.push( ReferenceLink.new("http://www.kungfugrippe.com", "character", "4") )
      expected_rls.push( ReferenceLink.new("http://docs.python.org/library/index.html", "under confinement", "3") )
      expected_rls.push( ReferenceLink.new("http://daringfireball.net/markdown", "slaves", "1") )

      actual_rls = Document.new(@file).reference_links

      actual_rls.count.should == expected_rls.count

      for i in 0..(actual_rls.count-1)
        actual_rls[i].to_s.should == expected_rls[i].to_s
      end
    end

    it "should convert inline links to reference links and renumber labels in order" do
      actual = Document.new(@inline_file).clean_and_format
      expected = File.open(@clean_file).readlines.join

      actual.should == expected
    end

    it "should not remove reference labels that are not used in the text" do
      expected_reference_links = []

      expected_reference_links.push( ReferenceLink.new("http://www.google.com", "succeeded", "2") )
      expected_reference_links.push( ReferenceLink.new("http://www.kungfugrippe.com", "character", "4") )
      expected_reference_links.push( ReferenceLink.new("http://docs.python.org/library/index.html", "under confinement", "3") )
      expected_reference_links.push( ReferenceLink.new("http://daringfireball.net/markdown", "slaves", "1") )
      expected_reference_links.push( ReferenceLink.new("http://www.ncsu.edu", "", "5") )
      expected_reference_links.push( ReferenceLink.new("http://www.gatech.edu", "", "6") )
      expected_reference_links.push( ReferenceLink.new("http://www.purdue.edu", "", "7") )

      actual_rls = Document.new(@unused_references_file).reference_links

      actual_rls.count.should == expected_reference_links.count

      actual_rls.each_with_index do |actual, i|
        actual.to_s.should == expected_reference_links[i].to_s
      end

    end

    it "should handle implicit reference links that look [like this]"

    it "should handle implicit reference links that look [like this][]"

    it "should normalize footnotes to the end of the file"

  end
end
