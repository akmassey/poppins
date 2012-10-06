module Poppins
  class ReferenceLink
    attr_reader :url, :link_text

    def initialize(url, link_text)
      @url = url
      @link_text = link_text
    end

    def as_end_reference
      "[#{@link_text}]: #{@url}"
    end

    def as_found_in_text
      "[#{@link_text}]"
    end

    def to_s
      as_end_reference
    end
  end
end
