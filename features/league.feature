Feature: Display league details in the terminal
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

  @stub_league
  Scenario: Getting current standing for a league in table
    When I run `football_cli show --league=PD`
    Then the output should contain:
    """
    +----------+-------------------------+-------------+----------------+--------+
    |                          Primera Division 2016/17                          |
    +----------+-------------------------+-------------+----------------+--------+
    | Position | Teamname                | Playedgames | Goaldifference | Points |
    +----------+-------------------------+-------------+----------------+--------+
    | 1        | Real Madrid CF          | 37          | 63             | 90     |
    | 2        | FC Barcelona            | 37          | 77             | 87     |
    | 3        | Club Atlético de Madrid | 37          | 41             | 75     |
    | 4        | Sevilla FC              | 38          | 20             | 72     |
    | 5        | Villarreal CF           | 38          | 22             | 67     |
    +----------+-------------------------+-------------+----------------+--------+
    """

  @stub_league
  Scenario: Getting current standing for a league in csv
    When I run `football_cli show --league=PD --format=csv`
    Then the output should contain:
    """
    position,teamName,playedGames,goalDifference,points
    1,Real Madrid CF,37,63,90
    2,FC Barcelona,37,77,87
    3,Club Atlético de Madrid,37,41,75
    4,Sevilla FC,38,20,72
    5,Villarreal CF,38,22,67
    """

  @stub_league
  Scenario: Getting current standing for a league in json
    When I run `football_cli show --league=PD --format=json`
    Then the output should contain:
    """
    [
      {
        "position": 1,
        "teamName": "Real Madrid CF",
        "playedGames": 37,
        "goalDifference": 63,
        "points": 90
      },
      {
        "position": 2,
        "teamName": "FC Barcelona",
        "playedGames": 37,
        "goalDifference": 77,
        "points": 87
      },
      {
        "position": 3,
        "teamName": "Club Atlético de Madrid",
        "playedGames": 37,
        "goalDifference": 41,
        "points": 75
      },
      {
        "position": 4,
        "teamName": "Sevilla FC",
        "playedGames": 38,
        "goalDifference": 20,
        "points": 72
      },
      {
        "position": 5,
        "teamName": "Villarreal CF",
        "playedGames": 38,
        "goalDifference": 22,
        "points": 67
      }
    ]
    """
  @stub_league_with_match_day
  Scenario: Getting current standing for a league in json
    When I run `football_cli show --league=PD --match_day=1`
    Then the output should contain:
    """
    +----------+------------------------+-------------+----------------+--------+
    |                         Primera Division 2016/17                          |
    +----------+------------------------+-------------+----------------+--------+
    | Position | Teamname               | Playedgames | Goaldifference | Points |
    +----------+------------------------+-------------+----------------+--------+
    | 1        | FC Barcelona           | 1           | 4              | 3      |
    | 2        | Real Madrid CF         | 1           | 3              | 3      |
    | 3        | Sevilla FC             | 1           | 2              | 3      |
    | 4        | UD Las Palmas          | 1           | 2              | 3      |
    | 5        | RC Deportivo La Coruna | 1           | 1              | 3      |
    +----------+------------------------+-------------+----------------+--------+
    """