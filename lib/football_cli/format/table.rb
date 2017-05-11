module FootballCli
  module Format
    class Table < Base
      def output
        response.each do |data|
          rows.push(
            attrs.values.map do |value|
              if value.is_a?(Hash)
                if value.include?(:result)
                  result = data[:result]

                  "#{result[:goalsHomeTeam]} - #{result[:goalsAwayTeam]}"
                end
              else
                data[value.to_sym]
              end
            end
          )
        end

        table = Terminal::Table.new do |t|
          t.title = title
          t.headings = attrs.keys.map(&:upcase)
          t.rows = rows
        end

        puts table
      end
    end
  end
end
