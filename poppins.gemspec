# -*- encoding: utf-8 -*-
require File.expand_path('../lib/poppins/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Aaron Massey"]
  gem.email         = ["akmassey@gatech.edu"]
  gem.description   = %q{Poppins is a basic formatter for Markdown files.}
  gem.summary       = %q{Poppins formats Markdown files to ensure that reference links are numbered and appear in numerical order.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "poppins"
  gem.require_paths = ["lib"]
  gem.version       = Poppins::VERSION


  gem.add_development_dependency 'rspec'
end
