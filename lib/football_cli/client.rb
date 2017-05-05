require 'football_data'
require 'json'

module FootballCli
  module Client
    def get_league_table(league, match_day)
      response = client.league_table(league,match_day: match_day)

      json_response(response.body)
    end

    def get_team_players(team)
      response = client.team_players(team)

      json_response(response.body)
    end

    def get_team(team)
      response = client.team(team)

      json_response(response.body)
    end

    def get_team_fixtures(team)
      response = client.team_fixtures(team)

      json_response(response.body)
    end

    private

    def client
      @client ||= FootballData::Client.new
    end

    def json_response(body)
      JSON.parse(body, symbolize_names: true)
    end
  end
end