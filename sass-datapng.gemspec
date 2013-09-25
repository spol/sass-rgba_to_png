# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sass/datapng/version'

Gem::Specification.new do |spec|
  spec.name          = "sass-datapng"
  spec.version       = Sass::Datapng::VERSION
  spec.authors       = ["Seb Pollard"]
  spec.email         = ["seb@spolster.co.uk"]
  spec.description   = %q{Converts a rgba color to a data URI encoded PNG for transparent backgrounds in IE 8}
  spec.summary       = %q{Converts a rgba color to a data URI encoded PNG for transparent backgrounds in IE 8}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'sass', '>= 3.2'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
