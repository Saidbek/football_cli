require 'rainbow/ext/string'
require_relative 'base'

module FootballCli
  module Format
    class Table < Base
      def generate
        response.each do |data|
          rows.push(columns.collect {|column| pretty_table(data, column) })
        end

        @generate ||= Terminal::Table.new do |t|
          t.title = title
          t.headings = columns.map(&:capitalize)
          t.rows = rows
        end
      end

      def pretty_table(data, column)
        if qualification
          data[column].to_s.color(get_color(data[:position]))
        elsif goal_columns.include?(column) && data[:result]
          data[:result][column]
        else
          data[column]
        end
      end

      def get_color(data)
        case data
        when qualification[:cl] then :green
        when qualification[:el] then :yellow
        when qualification[:rl] then :red
        else
          :aqua
        end
      end
    end
  end
end
