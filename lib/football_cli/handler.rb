require 'football_cli'
require 'football_data'
require 'terminal-table'

require_relative 'mapper'
require_relative 'format/base'
require_relative 'format/table'
require_relative 'format/csv'
require_relative 'format/json'

module FootballCli
  class Handler
    include FootballCli::Mapper

    def initialize(options={})
      @league = options[:league]
      @match_day = options[:match_day]
      @players = options[:players]
      @fixtures = options[:fixtures]
      @team = options[:team]
      @format = options[:format] || 'table'

      @client = FootballData::Client.new
    end

    def run
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
        puts 'Please run help to see available `flags` and `switches`'
      end
    end

    def league_table
      response = client.league_table(map_league_id(league), match_day: match_day)

      attrs = {
        pos: 'position',
        club: 'teamName',
        played: 'playedGames',
        goal_diff: 'goalDifference',
        points: 'points'
      }

      print_output(
        title: response[:leagueCaption],
        response: response[:standing],
        attrs: attrs
      )
    end

    def team_players
      response = client.team_players(map_team_id(team))
      team_response = client.team(map_team_id(team))

      attrs = {
        number: 'jerseyNumber',
        name: 'name',
        position: 'position',
        nationality: 'nationality',
        date_of_birth: 'dateOfBirth'
      }

      print_output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        response: response[:players],
        attrs: attrs
      )
    end

    def team_fixtures
      response = client.team_fixtures(map_team_id(team))
      team_response = client.team(map_team_id(team))

      attrs = {
        match_day: 'matchday',
        home_team: 'homeTeamName',
        score: {
          result: %w(goalsHomeTeam goalsAwayTeam)
        },
        away_team: 'awayTeamName',
        status: 'status',
        date: 'date'
      }

      print_output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        response: response[:fixtures],
        attrs: attrs
      )
    end

    def live_scores
      response = client.live_scores

      attrs = {
        championship: 'league',
        home_team: 'homeTeamName',
        score: {
          result: %w(goalsHomeTeam goalsAwayTeam)
        },
        away_team: 'awayTeamName',
        time: 'time'
      }

      print_output(
        title: 'Live scores',
        response: response[:games],
        attrs: attrs
      )
    end

    private

    attr_reader :client, :league, :match_day, :players, :fixtures, :team, :format

    def print_output(title:, response:, attrs:)
      case format
      when 'table'
        FootballCli::Format::Table.new(title, response, attrs).output
      when 'json'
        FootballCli::Format::JSON.new(title, response, attrs).output
      when 'csv'
        FootballCli::Format::CSV.new(title, response, attrs).output
      else
        puts 'Invalid format type. Available options (table, json, csv)'
      end
    end
  end
end
