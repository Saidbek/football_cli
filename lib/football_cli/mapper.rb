require 'json'

module FootballCli
  module Mapper
    def map_league_id(code)
      league = parse_json(leagues_path).find {|league| code == league[:league]} || {}

      league.dig(:id)
    end

    def map_team_id(code)
      team = parse_json(teams_path).find {|team| code == team[:code]} || {}

      team.dig(:id)
    end

    def leagues_path
      File.join 'config', 'leagues.json'
    end

    def teams_path
      File.join 'config', 'teams.json'
    end

    def parse_json(path)
      file = File.read(path)

      JSON.parse(file, symbolize_names: true)
    end
  end
end