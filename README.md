# Poppins

Poppins formats Markdown files to ensure that reference links are
numbered and appear in numerical order.  Inspired by [Dr. Drang's
script][1] for tidying reference links.

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[1]: http://www.leancrew.com/all-this/2012/09/tidying-markdown-reference-links/

