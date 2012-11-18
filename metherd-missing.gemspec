# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metherd-missing/version'

Gem::Specification.new do |gem|
  gem.name          = "metherd-missing"
  gem.version       = Metherd::Missing::VERSION
  gem.authors       = ["Andrew Vos"]
  gem.email         = ["andrew.vos@gmail.com"]
  gem.description   = %q{Translates misspellings of method calls to actual method calls!}
  gem.summary       = %q{Translates misspellings of method calls to actual method calls!}
  gem.homepage      = "http://github.com/AndrewVos/metherd-missing"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
