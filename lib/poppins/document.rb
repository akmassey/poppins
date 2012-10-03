module Poppins
  class Document

    def initialize(input=nil, output=nil)
      if input.empty?
        # TODO: Probably need to raise an error if ARGF is nil...
        @input = ARGF.readlines.join
      else
        @input = File.open(input, 'r').readlines.join
      end

      @output = output

      # RegEx for matching reference links in the text.  (Avoid footnotes!)
      @links = /\[([^\]]+)\]\[([^^\]]+)\]/
      # RegEx for matching labels for reference links.  (Avoid footnotes!)
      @labels = /^\[([^^\]]+)\]:\s+(.+)$/
      @labels_with_possible_newlines = /^\[([^^\]]+)\]:\s+(.+)(\n)?/
    end

    ##
    # Returns an array of the links found in the document in order.
    def links 
      @input.scan(@links)
    end

    def labels
      Hash[@input.scan(@labels)]
    end

    def order_of_first_appearance
      order = []
      links.each do |l|
        order.push(l[1]) unless order.include?(l[1])
      end

      order
    end

    def ordinal_references
      references = []
      order_of_first_appearance.each_with_index do |o, i| 
        references.push("[#{i+1}]: #{labels[o]}")
      end

      references 
    end

    ##
    # Returns an array of the link text and the new reference number when
    # passed links based on the old reference numbering system
    def get_replacement(string)
      md = string.match(@links)
      link_text = md[1].to_s
      reference_number = (order_of_first_appearance.index(md[2]) + 1).to_s

      return [link_text, reference_number]
    end


    ##
    # Produces the clean, formatted version of the Markdown with new
    # reference numbers.
    def clean_and_format
      # Remove old references (TOOD: Need to remove blank lines resulting from
      # this.)
      result = @input.gsub(@labels_with_possible_newlines, '')
      #
      # Add new references
      ordinal_references.each do |r| 
        result += r.to_s + "\n"
      end

      # Replace old reference numbers with the new ones
      result = result.gsub(@links) do |m| 
        replacement = get_replacement(m) 
        "[#{replacement[0]}][#{replacement[1]}]"
      end

      # output the result
      # puts result

      if @output
        File.open(@output, 'w') do |f|
          f.write(result)
        end
      else 
        puts result
      end
    end
  end
end
