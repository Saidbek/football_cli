require 'json'

module FootballCli
  module Mapper
    def get_league_id(code)
      league_info(code).dig(:id)
    end

    def get_team_id(code)
      team_info(code).dig(:id)
    end

    def get_qualification(code)
      league_info(code).dig(:qualification)
    end

    private

    def league_info(code)
      @league_info ||= parse_json(leagues_path).find {|league| code == league[:league]} || {}
    end

    def team_info(code)
      @team_info ||= parse_json(teams_path).find {|team| code == team[:code]} || {}
    end

    def parse_json(path)
      @parse_json ||= JSON.parse(File.read(path), symbolize_names: true)
    end

    def leagues_path
      File.join root, 'config', 'leagues.json'
    end

    def teams_path
      File.join root, 'config', 'teams.json'
    end

    def root
      File.expand_path '../../../', __FILE__
    end
  end
end