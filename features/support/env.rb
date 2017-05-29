require 'football_cli/runner'
require 'aruba/cucumber'
require 'aruba/in_process'

Aruba.configure do |config|
  config.command_launcher = :in_process
  config.main_class = FootballCli::Runner
end
