# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'football_cli/version'

Gem::Specification.new do |spec|
  spec.name       = 'football_cli'
  spec.version    = FootballCli::VERSION
  spec.platform   = Gem::Platform::RUBY
  spec.author     = ['Said Kaldybaev']
  spec.email      = ['said.kaldybaev@gmail.com']

  spec.summary       = %q{A command line interface}
  spec.description   = %q{A command line interface for all the football data feeds in Ruby}
  spec.homepage      = 'https://github.com/Saidbek/football_cli'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'bin'
  spec.executables << 'football_cli'
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'football_ruby'
  spec.add_runtime_dependency 'rainbow'
  spec.add_runtime_dependency 'terminal-table'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'webmock'
end
