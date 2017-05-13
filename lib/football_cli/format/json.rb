require 'json'
require_relative 'base'

module FootballCli
  module Format
    class Json < Base
      def output
        response.each do |data|
          rows.push(
            Hash[columns.collect {|c|
              if goal_columns.include?(c)
                [c, data[:result][c]]
              else
                [c, data[c]]
              end
            }]
          )
        end

        puts JSON.pretty_generate(rows)
      end
    end
  end
end