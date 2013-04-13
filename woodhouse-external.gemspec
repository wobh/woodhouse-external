# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'woodhouse/external/version'

Gem::Specification.new do |spec|
  spec.name          = "woodhouse-external"
  spec.version       = Woodhouse::External::VERSION
  spec.authors       = ["Matthew Boeh"]
  spec.email         = ["matt@crowdcompass.com", "matthew.boeh@gmail.com"]
  spec.description   = %q{Woodhouse extension for dispatching jobs to another application.}
  spec.summary       = %q{Woodhouse extension for dispatching jobs to another application.}
  spec.homepage      = "http://github.com/mboeh/woodhouse-external"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "woodhouse", ">= 0.1.5"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
