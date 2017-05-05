require 'football_cli'
require 'terminal-table'
require 'football_data'

module FootballCli
  class Handler
    def initialize
      @rows = []
    end

    def league_table(league, match_day)
      response = client.league_table(league, match_day: match_day)

      response[:standing].each do |team|
        @rows.push([ team[:position], team[:teamName], team[:playedGames], team[:goalDifference], team[:points] ] )
      end

      output(
        title: response[:leagueCaption],
        headings: ['POS', 'CLUB', 'PLAYED', 'GOAL DIFF', 'POINTS'],
        rows: @rows
      )
    end

    def team_players(team)
      response = client.team_players(team)

      response[:players].each do |item|
        @rows.push([ item[:jerseyNumber], item[:name], item[:position], item[:nationality], item[:dateOfBirth] ] )
      end

      team_response = client.team(team)

      output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        headings: ['NUMBER', 'NAME', 'POSITION', 'NATIONALITY', 'DATE OF BIRTH'],
        rows: @rows
      )
    end

    def team_fixtures(team)
      response = client.team_fixtures(team)

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

      team_response = client.team(team)

      output(
        title: "#{team_response[:name]} fixtures. Total #{response[:count]}",
        headings: ['MATCH DAY', 'HOME TEAM', 'SCORE', 'AWAY TEAM', 'STATUS', 'DATE'],
        rows: @rows
      )
    end

    private

    def output(opts={})
      raise 'Please specify options: `leagueCaption, headings, rows`' if opts.none?

      table = Terminal::Table.new do |t|
        t.title = opts[:leagueCaption]
        t.headings = opts[:headings]
        t.rows = opts[:rows]
      end

      puts table
    end

    def client
      @client ||= FootballData::Client.new
    end
  end
end