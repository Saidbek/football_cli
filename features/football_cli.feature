Feature: Football data feeds
  In order see football scores, fixtures, player and more
  I want to run command
  So I don't have to spend my time and open browser

  Scenario: Get Help
    When I run `bundle exec football_cli help`
    Then the output should contain:
      """
      NAME
          football_cli - Football scores for geeks.

      SYNOPSIS
          football_cli [global options] command [command options] [arguments...]

      VERSION
          0.0.1

      GLOBAL OPTIONS
          --help    - Show this message
          --version - Display the program version

      COMMANDS
          help - Shows a list of commands or help for one command
          live - Display live scores
          show - Show leagues, team players, fixtures and more
      """
  Scenario: Get live scores
    When I run `bundle exec football_cli live`
    Then the output should contain:
      """
      yeah
      """