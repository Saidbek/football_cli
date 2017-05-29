Given(/^the config file with:$/) do |string|
  step 'a file "~/.football_cli.yml" with:', string
end

Given(/^the config file do not exists$/) do
  step 'a file "~/.football_cli.yml" does not exist'
end

Then(/^the config file contain:$/) do |string|
  step 'the file "~/.football_cli.yml" should contain:', string
end
