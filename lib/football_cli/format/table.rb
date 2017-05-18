require 'rainbow/ext/string'
require_relative 'base'

module FootballCli
  module Format
    class Table < Base
      def generate
        response.each do |data|
          rows.push(
            columns.collect {|c|
              if goal_columns.include?(c) && data[:result] # when requesting team's fixtures
                data[:result][c]
              else
                pretty_table(data, c)
              end
            }
          )
        end

        Terminal::Table.new do |t|
          t.title = title
          t.headings = columns.map(&:capitalize)
          t.rows = rows
        end
      end

      def output
        puts generate

        write_to_file(generate)
      end
    end
  end
end
