module Poppins
  class ReferenceLink
    # RegEx for matching reference links in the text.  (Avoid footnotes!)
    @link_regex = /\[([^\]]+)\]\[([^^\]]+)\]/
    # RegEx for matching labels for reference links.  (Avoid footnotes!)
    @label_regex = /^\[([^^\]]+)\]:\s+(.+)$/
    @label_regex_with_possible_newlines = /^\[([^^\]]+)\]:\s+(.+)(\n)?/

    attr_reader :url, :link_text, :label, :link_regex, :label_regex

    def initialize(url="", link_text="", label="")
      @url = url
      @link_text = link_text
      @label = label
    end

    def self.link_regex
      @link_regex
    end

    def self.label_regex
      @label_regex
    end

    def self.label_regex_with_possible_newlines
      @label_regex_with_possible_newlines
    end

    def as_end_reference
      "[#{@link_text}]: #{@url}"
    end

    def as_found_in_text
      "[#{@link_text}]"
    end

    def to_s
      "[#{@label}]: #{@url}, found for text: #{@link_text}\n"
    end
  end
end
