require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'cucumber'
require 'cucumber/rake/task'

spec = eval(File.read('football_cli.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

task :cucumber => :features
task :default => [:features]
