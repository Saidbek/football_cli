Feature: Display team details in the terminal
  Background:
    Given a mocked home directory
    Given the config file with:
    """
    :api_token: fake_token
    """

  Scenario: No api token provided
    Given a mocked home directory
    Given the config file with:
      """
      :api_token:
      """
    And I run `football_cli show --league=PD`
    Then the output should contain exactly:
      """
      ERROR: You must config the api_token
      SOLUTION: Set up with `config api_token TOKEN`
      """

  @stub_team @stub_team_players
  Scenario: Getting players list
    When I run `football_cli show --team=FCB --players`
    Then the output should contain:
    """
    +--------------+-----------------------+------------------+-------------+-------------+
    |                           FC Barcelona players. Total 22                            |
    +--------------+-----------------------+------------------+-------------+-------------+
    | Jerseynumber | Name                  | Position         | Nationality | Dateofbirth |
    +--------------+-----------------------+------------------+-------------+-------------+
    | 12           | Rafinha               | Central Midfield | Brazil      | 1993-02-12  |
    | 1            | Marc-André ter Stegen | Keeper           | Germany     | 1992-04-30  |
    | 13           | Jasper Cillessen      | Keeper           | Netherlands | 1989-04-22  |
    | 25           | Jordi Masip           | Keeper           | Spain       | 1989-01-03  |
    | 3            | Gerard Piqué          | Centre-Back      | Spain       | 1987-02-02  |
    +--------------+-----------------------+------------------+-------------+-------------+
    """

  @stub_team @stub_team_fixtures
  Scenario: Getting fixtures list
    When I run `football_cli show --team=FCB --fixtures`
    Then the output should contain:
    """
    +----------+---------------+---------------+---------------+------------------+----------+----------------------+
    |                                        FC Barcelona fixtures. Total 48                                        |
    +----------+---------------+---------------+---------------+------------------+----------+----------------------+
    | Matchday | Hometeamname  | Goalshometeam | Goalsawayteam | Awayteamname     | Status   | Date                 |
    +----------+---------------+---------------+---------------+------------------+----------+----------------------+
    | 1        | FC Barcelona  | 6             | 2             | Real Betis       | FINISHED | 2016-08-20T16:15:00Z |
    | 2        | Athletic Club | 0             | 1             | FC Barcelona     | FINISHED | 2016-08-28T18:15:00Z |
    | 3        | FC Barcelona  | 1             | 2             | Deportivo Alavés | FINISHED | 2016-09-10T18:30:00Z |
    | 1        | FC Barcelona  | 7             | 0             | Celtic FC        | FINISHED | 2016-09-13T18:45:00Z |
    | 4        | CD Leganes    | 1             | 5             | FC Barcelona     | FINISHED | 2016-09-17T11:00:00Z |
    +----------+---------------+---------------+---------------+------------------+----------+----------------------+
    """

  @stub_team @stub_team_players
  Scenario: Getting players list in csv
    When I run `football_cli show --team=FCB --players --format=csv`
    Then the output should contain:
    """
    jerseyNumber,name,position,nationality,dateOfBirth
    12,Rafinha,Central Midfield,Brazil,1993-02-12
    1,Marc-André ter Stegen,Keeper,Germany,1992-04-30
    13,Jasper Cillessen,Keeper,Netherlands,1989-04-22
    25,Jordi Masip,Keeper,Spain,1989-01-03
    3,Gerard Piqué,Centre-Back,Spain,1987-02-02
    """

  @stub_team @stub_team_players
  Scenario: Getting players list in json
    When I run `football_cli show --team=FCB --players --format=json`
    Then the output should contain:
    """
    [
      {
        "jerseyNumber": 12,
        "name": "Rafinha",
        "position": "Central Midfield",
        "nationality": "Brazil",
        "dateOfBirth": "1993-02-12"
      },
      {
        "jerseyNumber": 1,
        "name": "Marc-André ter Stegen",
        "position": "Keeper",
        "nationality": "Germany",
        "dateOfBirth": "1992-04-30"
      },
      {
        "jerseyNumber": 13,
        "name": "Jasper Cillessen",
        "position": "Keeper",
        "nationality": "Netherlands",
        "dateOfBirth": "1989-04-22"
      },
      {
        "jerseyNumber": 25,
        "name": "Jordi Masip",
        "position": "Keeper",
        "nationality": "Spain",
        "dateOfBirth": "1989-01-03"
      },
      {
        "jerseyNumber": 3,
        "name": "Gerard Piqué",
        "position": "Centre-Back",
        "nationality": "Spain",
        "dateOfBirth": "1987-02-02"
      }
    ]
    """
