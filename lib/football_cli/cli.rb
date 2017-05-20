require 'thor'
require_relative 'handler'

module FootballCli
  class CLI < Thor
    desc 'show', 'sample description'

    option :league
    option :match_day, type: :numeric
    option :format
    option :file

    option :team
    class_option :players, type: :boolean
    class_option :fixtures, type: :boolean

    def show
      handler.run
    end

    desc 'live', 'display live scores'
    def live
      handler.live_scores
    end

    private

    def handler
      FootballCli::Handler.new(options)
    end
  end
end