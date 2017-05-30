<p align="center">
  <img src="http://i.imgur.com/FLITgqs.jpg">
</p>

![Travis Master](https://travis-ci.org/Saidbek/football_cli.svg?branch=master)
# Football CLI

A command line interface for all the football data feeds in Ruby

## Installation

    $ gem install football_cli
    
## Configuration

To use this gem you have to have an account at [football-data.org](http://football-data.org/client/register). Then, execute the following command in your terminal:

```ruby
$ football_cli config api_token <API-TOKEN>
```

## Usage

### Help
    $ football_cli help
### Show league table
    $ football_cli show --league=PD
### Show league table for a given day
    $ football_cli show --league=PD --match_day=1
### Show team players
    $ football_cli show --team=FCB --players
### Show team fixtures
    $ football_cli show --team=FCB --fixtures
### Show the output in csv or json
    $ football_cli show --league=PD --format=json
    $ football_cli show --league=PD --format=csv
### Save the output in a file
    $ football_cli show --league=PD --format=json --file=leagues.json
    $ football_cli show --league=PD --format=csv --file=leagues.csv
### Show live scores
    $ football_cli live

## Demo

### League table
<p align="center">
  <img src="http://i.imgur.com/E2us9uS.png">
</p>

### League table for a given day
<p align="center">
  <img src="http://i.imgur.com/9mlj2b9.png">
</p>

### Team players
<p align="center">
  <img src="http://i.imgur.com/uS4s9D8.png">
</p>

### Live scores
<p align="center">
  <img src="http://i.imgur.com/102utJf.png">
</p>

## Help

To get more help about usage, execute the following command in your terminal:

```ruby
$ football_cli help
```

