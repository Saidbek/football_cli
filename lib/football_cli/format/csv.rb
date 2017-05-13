require 'csv'
require_relative 'base'

module FootballCli
  module Format
    class Csv < Base
      def generate
        @generate ||= CSV.generate do |csv|
          csv << columns

          response.each do |data|
            csv << columns.collect {|c|
              if goal_columns.include?(c) && data[:result]
                data[:result][c]
              else
                data[c]
              end
            }
          end
        end
      end

      def output
        puts generate

        write_to_file(generate)
      end
    end
  end
end