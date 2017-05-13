require_relative 'base'

module FootballCli
  module Format
    class Table < Base
      def output
        response.each do |data|
          rows.push(
            columns.collect {|c|
              if goal_columns.include?(c) && data[:result]
                data[:result][c]
              else
                data[c]
              end
            }
          )
        end

        table = Terminal::Table.new do |t|
          t.title = title
          t.headings = columns.map(&:capitalize)
          t.rows = rows
        end

        puts table
      end
    end
  end
end
