Feature: Ability to store configuration settings
  Background:
    Given a mocked home directory

  Scenario: Setup the api token
    Given the config file do not exists
    When I run `football_cli config api_token new_key`
    Then the output should contain "Updating config file with api_token: new_key"
    And the config file contain:
      """
      :api_token: new_key
      """
  Scenario: Setup the api_token with existing api_token
    Given the config file with:
      """
      :api_token: old_key
      """
    When I run `football_cli config api_token new_key`
    Then the output should contain "Do you want to overwrite api_token provide --update option"
    When I run `football_cli config api_token new_key --update`
    And the config file contain:
      """
      :api_token: new_key
      """