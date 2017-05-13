# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__), 'lib', 'football_cli', 'version.rb'])

Gem::Specification.new do |s|
  s.name = 'football_cli'
  s.version = FootballCli::VERSION
  s.author = 'Said Kaldybaev'
  s.email = 'said.kaldybaev@gmail.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A command line interface for all the football data feeds in Ruby'
  s.files = `git ls-files`.split('')
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'football_cli'

  s.add_dependency 'football_ruby'
  s.add_development_dependency('rake')
  s.add_development_dependency('aruba')
  s.add_development_dependency('terminal-table')
  s.add_runtime_dependency('gli','2.16.0')
end
