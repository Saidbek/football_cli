require 'football_cli'
require 'terminal-table'

module FootballCli
  class Handler
    include FootballCli::Client

    def initialize
      @rows = []
    end

    def league_table(league, match_day)
      response = get_league_table(league, match_day)

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
      response = get_team_players(team)

      response[:players].each do |team|
        @rows.push([ team[:jerseyNumber], team[:name], team[:position], team[:nationality], team[:dateOfBirth] ] )
      end

      team_response = get_team(team)

      output(
        title: "#{team_response[:name]} players. Total #{response[:count]}",
        headings: ['NUMBER', 'NAME', 'POSITION', 'NATIONALITY', 'DATE OF BIRTH'],
        rows: @rows
      )
    end

    def team_fixtures(team)
      response = get_team_fixtures(team)

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

      team_response = get_team(team)

      output(
        title: "#{team_response[:name]} fixtures. Total #{response[:count]}",
        headings: ['MATCH DAY', 'HOME TEAM', 'SCORE', 'AWAY TEAM', 'STATUS', 'DATE'],
        rows: @rows
      )
    end

    private

    def output(opts = {})
      table.title = opts[:leagueCaption]
      table.headings = opts[:headings]
      table.rows = opts[:rows]

      puts table
    end

    def table
      @table ||= Terminal::Table.new
    end
  end
end