module Poppins
  class Document
    attr_accessor :output_filename, :input_filename

    def initialize(input)
      @input_filename = input

      @input = File.open(@input_filename, 'r').readlines.join

      # RegEx for matching reference links in the text.  (Avoid footnotes!)
      @links = /\[([^\]]+)\]\[([^^\]]+)\]/
      # RegEx for matching labels for reference links.  (Avoid footnotes!)
      @labels = /^\[([^^\]]+)\]:\s+(.+)$/
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
      newlabels = []
      order_of_first_appearance.each_with_index do |o, i| 
        newlabels.push("[#{i+1}]: #{labels[o]}")
      end

      newlabels 
    end

    def clean_and_format
      p links
      p labels
      p order_of_first_appearance
      p ordinal_references
    end
  end
end
