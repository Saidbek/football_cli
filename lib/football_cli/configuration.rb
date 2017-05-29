require 'yaml'

module FootballCli
  module Configuration
    CONFIG_FILE = '.football_cli.yml'
    CONFIG_CONTENTS = {
      api_token: '',
    }

    def self.write(value, key, options)
      create_config_file unless File.exist? config_file
      update_value(value, key) && return if options['update'] && !send(key).empty?

      if send(key).empty?
        puts "Updating config file with #{key}: #{value}"
        update_value(value, key)
      else
        puts "Do you want to overwrite #{key} provide --update option"
      end
    end

    def self.update_value(value, key)
      content = config_data
      content.send(:[]=, key, value)

      File.open(config_file, 'w') do |f|
        f.write(content.to_yaml)
      end
    end

    def self.create_config_file
      File.open(config_file, 'w+') { |f| f.write(CONFIG_CONTENTS.to_yaml) }
    end

    def self.api_token
      config_data[:api_token] if config_data
    end

    def self.config_file
      File.join(ENV['HOME'], CONFIG_FILE)
    end

    def self.config_data
      YAML::load_file(config_file) if File.exist? config_file
    end
  end
end
