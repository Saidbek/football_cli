require_relative 'table'
require_relative 'json'
require_relative 'csv'

module FootballCli
  module Format
    class FormatFactory
      def self.build(format, *args)
        case format
        when 'table' then Table.new(*args)
        when 'json' then Json.new(*args)
        when 'csv' then Csv.new(*args)
        else
          raise 'Invalid format type. Available options (table, json, csv)'
        end
      end
    end
  end
end