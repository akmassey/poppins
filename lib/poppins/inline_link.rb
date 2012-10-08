module Poppins
  class InlineLink
    # RegEx for matching inline links in the text.
    @link_regex = /\[([^\]]+)\]\(([^\)]+)\)/

    attr_reader :url
    attr_accessor :link_text

    def initialize(url, link_text)
      @url = url
      @link_text = link_text
    end

    def self.link_regex
      @link_regex
    end

    def as_found_in_text
      "[#{@link_text}](#{@url})"
    end

    def to_s
      as_found_in_text
    end

    ##
    # Returns a regular expression that can be used to find examples of this
    # link in a sample text.
    def regex
      /\[([^\]]+)\]\((#{Regexp.quote(@url)})\)/
    end
  end
end

