# Poppins

Poppins formats Markdown files to ensure that reference links are
numbered and appear in numerical order.  Currently, this is a seriously
basic tool.  Still, it does what I needed, and I hope to expand it.
Poppins was inspired by [Dr. Drang's script][1] for tidying reference
links.

## Installation

Add this line to your application's Gemfile:

    gem 'poppins'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install poppins

## Usage

    Poppins: a Markdown cleaner and formatter
    Usage: poppins [options] <filename>
    
    Examples:
      poppins ./README.md
      poppins --output 'output.md' ./input.md
    
    Options:
        -o, --output [FILE]              Write the clean, formatted Markdown to FILE.
        -h, --help                       Show this message
        -v, --version                    Show version

## Roadmap

Poppins is intended to be similar to [formd][2], but with easier
integration with Ruby projects.  Also, I would like to add the ability
to insert reference links they way Dr. Drang describes
[here](http://www.leancrew.com/all-this/2012/08/markdown-reference-links-in-bbedit/)
and [here][3].

It would also be really awesome if we could re-flow paragraph text and
wrap it at user-specified column lengths.

Currently, Poppins doesn't handle implicit reference links.  Those are
links that look [like this] or perhaps [like this][].


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



[1]: http://www.leancrew.com/all-this/2012/09/tidying-markdown-reference-links/
[2]: http://www.drbunsen.org/formd-a-markdown-formatting-tool.html
[3]: http://www.leancrew.com/all-this/2012/08/more-markdown-reference-links-in-bbedit/

[like this]: http://google.com
