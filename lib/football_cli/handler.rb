require 'football_cli'
require 'football_ruby'
require 'terminal-table'

require_relative 'mapper'
require_relative 'format/format_factory'

module FootballCli
  class Handler
    include FootballCli::Mapper

    def initialize(command, options={})
      @command = command
      @league = options[:league]
      @match_day = options[:match_day]
      @players = options[:players]
      @fixtures = options[:fixtures]
      @team = options[:team]
      @format = options[:format] || 'table'
      @file = options[:file]

      @client = FootballRuby::Client.new
    end

    def run
      case command
      when :live
        live_scores
      when :show
        case
        when league, match_day
          league_table
        when team && players, fixtures
          if players
            team_players
          elsif fixtures
            team_fixtures
          end
        else
          raise 'Invalid option'
        end
      else
        raise 'Invalid command'
      end
    end

    def league_table
      response = client.league_table(map_league_id(league), match_day: match_day)

      print_output(
        title: response[:leagueCaption],
        response: response[:standing],
        columns: %i(position teamName playedGames goalDifference points)
      )
    end

    def team_players
      response = client.team_players(map_team_id(team))
      team_response = client.team(map_team_id(team))

      print_output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        response: response[:players],
        columns: %i(jerseyNumber name position nationality dateOfBirth)
      )
    end

    def team_fixtures
      response = client.team_fixtures(map_team_id(team))
      team_response = client.team(map_team_id(team))

      print_output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        response: response[:fixtures],
        columns: %i(matchday homeTeamName goalsHomeTeam goalsAwayTeam awayTeamName status date)
      )
    end

    def live_scores
      response = client.live_scores

      print_output(
        title: 'Live scores',
        response: response[:games],
        columns: %i(league homeTeamName goalsHomeTeam goalsAwayTeam awayTeamName time)
      )
    end

    private

    attr_reader :client, :command, :league, :match_day, :players, :fixtures, :team, :format, :file

    def print_output(response:, title:, columns:)
      factory = FootballCli::Format::FormatFactory.build(
        format,
        {
          response: response,
          title: title,
          columns: columns,
          file_name: file
        }
      )

      factory.output
    end
  end
end
