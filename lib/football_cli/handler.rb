require 'football_cli'
require 'football_ruby'
require 'terminal-table'

require_relative 'mapper'
require_relative 'format/format_factory'

module FootballCli
  class Handler
    include FootballCli::Mapper

    def initialize(options={})
      @league = options[:league]
      @match_day = options[:match_day]
      @players = options[:players]
      @fixtures = options[:fixtures]
      @team = options[:team]
      @file = options[:file]
      @format = options.fetch(:format, 'table')
    end

    def run
      if league
        league_table
      elsif team
        if players
          team_players
        elsif fixtures
          team_fixtures
        end
      end
    end

    def league_table
      response = client.league_table(league_id, match_day: match_day)

      output(
        title: response[:leagueCaption],
        response: response[:standing],
        columns: %i(position teamName playedGames goalDifference points),
        qualification: qualification
      )
    end

    def team_players
      response = client.team_players(team_id)
      team_response = client.team(team_id)

      output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        response: response[:players],
        columns: %i(jerseyNumber name position nationality dateOfBirth)
      )
    end

    def team_fixtures
      response = client.team_fixtures(team_id)
      team_response = client.team(team_id)

      output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        response: response[:fixtures],
        columns: %i(matchday homeTeamName goalsHomeTeam goalsAwayTeam awayTeamName status date)
      )
    end

    def live_scores
      response = client.live_scores

      output(
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

    def output(opts = {})
      FootballCli::Format::FormatFactory.build(
        format,
        {
          qualification: opts[:qualification],
          response: opts[:response],
          columns: opts[:columns],
          title: opts[:title],
          file_name: file
        }
      ).output
    end

    def client
      @client ||= FootballRuby::Client.new
    end
  end
end
