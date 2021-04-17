# frozen_string_literal: true

require File.expand_path('lib/poppins/version', __dir__)

Gem::Specification.new do |gem|
  gem.authors       = ['Aaron Massey']
  gem.email         = ['akmassey@gatech.edu']
  gem.description   = 'Poppins is a basic formatter for Markdown files.'
  gem.summary       = 'Poppins formats Markdown files to ensure reference links are appear in numerical order.'
  gem.homepage      = ''
  gem.license       = 'MIT'

  gem.required_ruby_version = '>=2.7'

  gem.files         = `git ls-files`.split($ORS)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'poppins'
  gem.require_paths = ['lib']
  gem.version       = Poppins::VERSION

  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
