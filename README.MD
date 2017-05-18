<p align="center">
  <img src="http://i.imgur.com/FLITgqs.jpg">
</p>

# Fottball CLI

A command line interface for all the football data feeds in Ruby

## Installation

    $ gem install football_ruby

## Usage

### Help
    $ bundle exec bin/football_cli help
### Show league table
    $ bundle exec bin/football_cli show --league=PD
### Show league table for a given day
    $ bundle exec bin/football_cli show --league=PD --match_day=1
### Show team players
    $ bundle exec bin/football_cli show --team=FCB --players
### Show team fixtures
    $ bundle exec bin/football_cli show --team=FCB --fixtures
### Show the output in csv or json
    $ bundle exec bin/football_cli show --league=PD --format=json
    $ bundle exec bin/football_cli show --league=PD --format=csv
### Save the output in a file
    $ bundle exec bin/football_cli show --league=PD --format=json --file=leagues.json
    $ bundle exec bin/football_cli show --league=PD --format=csv --file=leagues.csv
### Show live scores
    $ bundle exec bin/football_cli live

## Demo

### League table
![](http://i.imgur.com/lsxa1Zw.png)
### League table for a given day
![](http://i.imgur.com/PnMVy1o.png)
### Team players
![](http://i.imgur.com/SUthQEx.png)

## Todo

1. Make api_token configurable
2. Improve error handling
3. Add more cucumber features
4. And more ...

