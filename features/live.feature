Feature: Display football live scores in the terminal
  @stub_live_scores_response
  Scenario: Getting live scores
    When I run `football_cli live`
    Then the output should contain:
    """
    +----------------+----------------+---------------+---------------+-------------------+------+
    |                                        Live scores                                         |
    +----------------+----------------+---------------+---------------+-------------------+------+
    | League         | Hometeamname   | Goalshometeam | Goalsawayteam | Awayteamname      | Time |
    +----------------+----------------+---------------+---------------+-------------------+------+
    | Premier League | Arsenal        | 0             | 0             | Everton           | 6'   |
    | Premier League | Burnley        | 0             | 0             | West Ham United   | 4'   |
    | Premier League | Chelsea        | 0             | 1             | Sunderland        | 4'   |
    | Premier League | Hull City      | 0             | 0             | Tottenham Hotspur | 6'   |
    | Premier League | Leicester City | 0             | 1             | AFC Bournemouth   | 6'   |
    +----------------+----------------+---------------+---------------+-------------------+------+
    """