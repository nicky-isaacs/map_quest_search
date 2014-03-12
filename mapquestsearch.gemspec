# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mapquestsearch/version'

Gem::Specification.new do |spec|
  spec.name          = "mapquestsearch"
  spec.version       = Mapquestsearch::VERSION
  spec.authors       = ["Nick Isaacs"]
  spec.email         = ["nisaacs@splickit.com"]
  spec.summary       = "Simple wrapper for the MapQuest Nomination API"
  spec.description   = ''
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.5"
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rest_client', "~> 1.7"
  spec.add_development_dependency 'json', '~> 1.8'
end
