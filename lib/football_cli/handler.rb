require 'football_cli'
require 'football_data'
require 'terminal-table'
require 'json'

module FootballCli
  class Handler
    def initialize
      @rows = []
    end

    def league_table(code, match_day)
      response = client.league_table(map_league_id(code), match_day: match_day)

      response[:standing].each do |team|
        @rows.push([ team[:position], team[:teamName], team[:playedGames], team[:goalDifference], team[:points] ] )
      end

      output(
        title: response[:leagueCaption],
        headings: ['POS', 'CLUB', 'PLAYED', 'GOAL DIFF', 'POINTS'],
        rows: @rows
      )
    end

    def team_players(code)
      response = client.team_players(map_team_id(code))

      response[:players].each do |item|
        @rows.push([ item[:jerseyNumber], item[:name], item[:position], item[:nationality], item[:dateOfBirth] ] )
      end

      team_response = client.team(map_team_id(code))

      output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        headings: ['NUMBER', 'NAME', 'POSITION', 'NATIONALITY', 'DATE OF BIRTH'],
        rows: @rows
      )
    end

    def team_fixtures(code)
      response = client.team_fixtures(map_team_id(code))

      response[:fixtures].each do |fixture|
        result = fixture[:result]

        @rows.push([
          fixture[:matchday],
          fixture[:homeTeamName],
          "#{result.dig(:goalsHomeTeam)} - #{result.dig(:goalsAwayTeam)}",
          fixture[:awayTeamName],
          fixture[:status],
          fixture[:date]
        ])
      end

      team_response = client.team(map_team_id(code))

      output(
        title: "#{team_response[:name]} fixtures. Total #{response[:count]}",
        headings: ['MATCH DAY', 'HOME TEAM', 'SCORE', 'AWAY TEAM', 'STATUS', 'DATE'],
        rows: @rows
      )
    end

    def live_scores
      response = client.live_scores

      response[:games].each do |game|
        @rows.push([
          game[:league],
          game[:homeTeamName],
          "#{game[:goalsHomeTeam]} - #{game[:goalsAwayTeam]}",
          game[:awayTeamName],
          game[:time]
        ])
      end

      output(
        title: 'Live scores',
        headings: ['CHAMPIONSHIP', 'HOME TEAM', 'SCORE', 'AWAY TEAM', 'TIME'],
        rows: @rows
      )
    end

    private

    def output(opts={})
      raise 'Please specify options: `leagueCaption, headings, rows`' if opts.none?

      table = Terminal::Table.new do |t|
        t.title = opts[:title]
        t.headings = opts[:headings]
        t.rows = opts[:rows]
      end

      puts table
    end

    def map_league_id(code)
      if league = leagues_list.find {|f| f[:league] == code}
        league[:id]
      else
        raise 'No league found'
      end
    end

    def map_team_id(code)
      if team = teams_list.find {|f| f[:code] == code}
        team[:id]
      else
        raise 'No team found'
      end
    end

    def leagues_list
      path = File.expand_path('../../../config/leagues.json', __FILE__)

      JSON.parse(File.read(path), symbolize_names: true)
    end

    def teams_list
      path = File.expand_path('../../../config/teams.json', __FILE__)

      JSON.parse(File.read(path), symbolize_names: true)
    end

    def client
      @client ||= FootballData::Client.new
    end
  end
end