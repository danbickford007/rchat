# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rchat/version'

Gem::Specification.new do |spec|
  spec.name          = "rchat"
  spec.version       = Rchat::VERSION
  spec.authors       = ["dan bickford"]
  spec.email         = ["danbickford007@yahoo.com"]
  spec.summary       = %q{Required.}
  spec.description   = %q{Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency 'colorize'
  spec.add_dependency 'json'
  spec.add_dependency 'green_shoes'
end
