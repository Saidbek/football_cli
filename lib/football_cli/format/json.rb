require 'json'
require_relative 'base'

module FootballCli
  module Format
    class Json < Base
      def generate
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

        @generate ||= JSON.pretty_generate(rows)
      end

      def output
        puts generate

        write_to_file(generate)
      end
    end
  end
end