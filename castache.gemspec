# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'castache/version'

Gem::Specification.new do |gem|
  gem.name          = "castache"
  gem.version       = Castache::VERSION
  gem.authors       = ["StyleSeek Engineering"]
  gem.email         = ["engineering@styleseek.com"]
  gem.description   = %q{Simple structured object cache for ruby apps. }
  gem.summary       = %q{Simple structured object cache for ruby apps. Marshals objects to and from Redis quickly and painlessly. }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('redis', '~> 3.0')
  
  gem.add_development_dependency('rake',        '~> 10')
  gem.add_development_dependency('minitest',    '~> 4.2')
  gem.add_development_dependency('ansi',        '~> 1.4')
  gem.add_development_dependency('turn',        '~> 0.9')
  gem.add_development_dependency('pry',         '~> 0.9')
  gem.add_development_dependency('mocha',       '~> 0.13')
  gem.add_development_dependency('gem-release', '~> 0.4')
end
