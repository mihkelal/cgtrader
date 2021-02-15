# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cgtrader_levels/version'

Gem::Specification.new do |spec|
  spec.name                  = 'cgtrader_levels'
  spec.version               = CgtraderLevels::VERSION
  spec.authors               = ['Vilius Luneckas', 'Mihkel Alavere']
  spec.email                 = ['vilius.luneckas@gmail.com, mihkel.alavere@eesti.ee']
  spec.summary               = 'Manage users, levels and level-up bonuses'
  spec.description           = 'GCTrader is a gem for keeping track of user levels, levels themselves and bonuses that go along with reaching new levels.'
  spec.homepage              = 'https://github.com/mihkelal/cgtrader'
  spec.license               = 'MIT'
  spec.required_ruby_version = '~> 3.0'


  spec.files                 = `git ls-files -z`.split("\x0")
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths         = ['lib']

  spec.add_dependency 'activerecord', '~> 6.0'
  spec.add_dependency 'sqlite3', '~> 1.4'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.21'
end
