require 'securerandom'
require_relative 'reference_link'
require_relative 'inline_link'

module Poppins
  class Document
    attr_reader :reference_links, :inline_links, :links

    def initialize(input=nil, output=nil)
      if input.empty?
        raise "invalid input" unless (ARGF.respond_to?(:readlines) and not ARGF.nil?)
        @input = ARGF.readlines.join
      else
        @input = File.open(input, 'r').readlines.join
      end

      @output = output

      identify_inline_links
      identify_reference_links
    end


    ##
    # Identifies inline links in the document
    def identify_inline_links(input=@input)
      inline_links = Hash[input.scan(InlineLink.inline_regex)]

      @inline_links = []

      inline_links.each do |il|
        @inline_links.push( InlineLink.new(il.to_a[1], il.to_a[0]) )
      end

      @inline_links
    end

    ##
    # Identifies reference links in the document
    def identify_reference_links(input=@input)
      reference_links = Hash[input.scan(ReferenceLink.link_regex)]

      labels = Hash[input.scan(ReferenceLink.label_regex)]

      @reference_links = []

      reference_links.each do |rl|
        @reference_links.push( ReferenceLink.new(labels[rl.to_a[1]], rl.to_a[0], rl.to_a[1] ) )
      end

      # identify unused labels at the end of the document
      urls = @reference_links.map do |rl|
        rl.url
      end

      unused_labels = labels.select do |key, value|
        !urls.include?(value)
      end

      count = @reference_links.count + 1
      unused_labels.each do |key, value|
        @reference_links.push( ReferenceLink.new( value.to_s, "", count.to_s) )
        count += 1
      end

      # Note that the order of the links in this list is the same as their
      # appearance in the text.
      @reference_links
    end


    ##
    # Produces the clean, formatted version of the Markdown with new
    # reference numbers.
    def clean_and_format(input=@input)
      result = input
      result = convert_reference_to_inline(result)
      result = convert_inline_to_reference(result)

      identify_reference_links(result)

      # Remove old reference labels from the end
      # TODO: This currently destroys links that don't appear anywhere else in
      # the text since they aren't added back in unless they were used in the
      # text..
      result = result.gsub(ReferenceLink.label_regex_with_possible_newlines, '')

      # Add new reference labels to the end
      @reference_links.each_with_index do |rl, i|
        result += "[#{i+1}]: #{rl.url}\n"
      end

      # Replace old reference numbers with the new ones
      result = result.gsub(ReferenceLink.link_regex) do |match|
        # TODO: There has to be a cleaner way to do this...
        match_data = match.match(ReferenceLink.link_regex)

        link_text = match_data[1].to_s
        label_from_match = match_data[2].to_s
        new_label = @reference_links.index { |rl| rl.label == label_from_match }

        # TODO: Do you really want to strip whitespace here?
        "[#{link_text.strip}][#{new_label + 1}]"
      end

      # return the result
      if @output
        File.open(@output, 'w') do |f|
          f.write(result)
        end
      end

      result
    end

    ##
    # Produces a clean, formatted version of the Markdown while also
    # converting inline links to reference links.
    def convert_inline_to_reference(input=@input)
      result = input
      identify_inline_links(result)

      @inline_links.each do |link|
        reference_label = SecureRandom.hex(8)
        result = result.gsub(link.regex) do |match|
          "[#{link.link_text}][#{reference_label}]"
        end
        result += "[#{reference_label}]: #{link.url}\n"
      end

      result
    end

    ##
    # Convert reference links to inline links.  This can be used prior to
    # converting back to reference links to ensure that all links are
    # reference links and they are numbered in the order they appear.
    def convert_reference_to_inline(input=@input)
      result = input

      # TODO: Should DRY this
      labels = Hash[input.scan(ReferenceLink.label_regex)]
      ref_urls = labels.values

      ref_urls.each do |url|
        regex = /\[([^\]]+)\]\[(#{Regexp.quote(url)})\]/
        result = result.gsub(regex) do |match|
          "[#{match[1]}](#{url})"
        end
      end

      # TODO: Need to be able to store this separately if they want to have
      # inline links only.
      result
    end
  end
end
