module FootballCli
  class CLI < Thor
    desc 'config SUBCOMMAND ...ARGS', 'Write options in the configuration file'
    subcommand 'config', Config

    desc 'show', 'Display all the football data feeds'
    option :league, aliases: '-l', banner: 'PD', desc: 'Current standing of league'
    option :match_day, type: :numeric, aliases: '-d', banner: 5, desc: 'Current standing of league for a given day'
    option :format, aliases: '-t', banner: 'json', desc: 'Output format type, default: table'
    option :file, aliases: '-f', banner: 'players.json', desc: 'File name to save the output'
    option :team, aliases: '-t', banner: 'FCB', desc: 'Team details, players or fixtures'
    class_option :players, type: :boolean, aliases: '-p'
    class_option :fixtures, type: :boolean, aliases: '-f'

    def show
      handler.run
    end

    desc 'live', 'Display live scores'
    def live
      handler.live_scores
    end

    private

    def handler
      FootballCli::Handler.new(options)
    end
  end
end