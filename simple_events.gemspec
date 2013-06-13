# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_events/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_events"
  spec.version       = SimpleEvents::VERSION
  spec.authors       = ["Jason R. Clark"]
  spec.email         = ["jason@jasonrclark.net"]
  spec.description   = %q{A basic event notification system}
  spec.summary       = %q{Simple Events provides basic, synchronous, in-process event dispatch to help in decoupling your app}
  spec.homepage      = "http://github.com/jasonrclark/simple_events"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
