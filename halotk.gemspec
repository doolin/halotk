# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'halotk/version'

Gem::Specification.new do |spec|
  spec.name          = 'halotk'
  spec.version       = Halotk::VERSION
  spec.authors       = ['Dave Doolin']
  spec.email         = ['david.doolin@gmail.com']
  spec.summary       = 'API tools.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
