require 'webmock/cucumber'

API_ENDPOINT = 'http://api.football-data.org/v1'
LIVE_ENDPOINT = 'http://soccer-cli.appspot.com'

Before('@stub_live_scores_response') do
  stub_request(:get, LIVE_ENDPOINT).to_return(json_response 'live_scores.json')
end

Before('@stub_league') do
  stub_get('/competitions/436/leagueTable/')
    .with(
      headers: { 'X-Auth-Token': 'fake_token' }
    ).to_return(json_response 'league.json')
end

Before('@stub_league_with_match_day') do
  stub_get('/competitions/436/leagueTable/?matchday=1')
    .with(
      headers: { 'X-Auth-Token': 'fake_token' }
    ).to_return(json_response 'league_with_match_day.json')
end

Before('@stub_team') do
  stub_get('/teams/81/')
    .with(
      headers: { 'X-Auth-Token': 'fake_token' }
    ).to_return(json_response 'team.json')
end

Before('@stub_team_players') do
  stub_get('/teams/81/players/')
    .with(
      headers: { 'X-Auth-Token': 'fake_token' }
    ).to_return(json_response 'team_players.json')
end

Before('@stub_team_fixtures') do
  stub_get('/teams/81/fixtures/')
    .with(
      headers: { 'X-Auth-Token': 'fake_token' }
    ).to_return(json_response 'team_fixtures.json')
end

def stub_get(url)
  stub_request(:get, "#{API_ENDPOINT}#{url}")
end

def json_response(file, status=200)
  {
    body: fixture(file),
    status: status,
    headers: { content_type: 'application/json; charset=utf-8' }
  }
end

def fixture(file)
  File.new(File.join(fixture_path,file))
end

def fixture_path
  File.expand_path('../../fixtures', __FILE__)
end
