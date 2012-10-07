module Poppins
  class InlineLink
    attr_reader :url
    attr_accessor :link_text

    def initialize(url, link_text)
      @url = url
      @link_text = link_text
    end

    def as_found_in_text
      "[#{@link_text}](#{@url})"
    end

    def to_s
      as_found_in_text
    end
  end
end

