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
      response = client.league_table(league_id, match_day: match_day)

      display(
        title: response[:leagueCaption],
        response: response[:standing],
        columns: %i(position teamName playedGames goalDifference points),
        qualification: qualification
      )
    end

    def team_players
      response = client.team_players(team_id)
      team_response = client.team(team_id)

      display(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        response: response[:players],
        columns: %i(jerseyNumber name position nationality dateOfBirth)
      )
    end

    def team_fixtures
      response = client.team_fixtures(team_id)
      team_response = client.team(team_id)

      display(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        response: response[:fixtures],
        columns: %i(matchday homeTeamName goalsHomeTeam goalsAwayTeam awayTeamName status date)
      )
    end

    def live_scores
      response = client.live_scores

      display(
        title: 'Live scores',
        response: response[:games],
        columns: %i(league homeTeamName goalsHomeTeam goalsAwayTeam awayTeamName time)
      )
    end

    private

    attr_reader :client, :command, :league, :match_day, :players, :fixtures, :team, :format, :file

    def league_id
      get_league_id(league)
    end

    def team_id
      get_team_id(team)
    end

    def qualification
      get_qualification(league)
    end

    def display(opts = {})
      response = opts[:response]
      title = opts[:title]
      columns = opts[:columns]
      qualification = opts[:qualification]

      factory = FootballCli::Format::FormatFactory.build(
        format,
        {
          response: response,
          title: title,
          columns: columns,
          file_name: file,
          qualification: qualification
        }
      )

      factory.output
    end

    def client
      @client ||= FootballRuby::Client.new
    end
  end
end
