module FootballCli
  module Format
    class Base
      attr_reader :title, :response, :columns, :rows, :file_name

      def initialize(opts={})
        @response = opts[:response]
        @title = opts[:title]
        @columns = opts[:columns]
        @file_name = opts[:file_name]
        @qualification = opts[:qualification]

        @rows = []
      end

      def generate
        raise NotImplementedError, 'must implement generate() method in subclass'
      end

      def output
        raise NotImplementedError, 'must implement output() method in subclass'
      end

      def write_to_file(output)
        File.write(file_name, output) if file_name
      end

      def goal_columns
        %i(goalsHomeTeam goalsAwayTeam).freeze
      end

      def pretty_table(data, column)
        if qualification
          color = case data[:position]
                  when qualification[:cl] then :green
                  when qualification[:el] then :yellow
                  when qualification[:rl] then :red
                  else
                    :aqua
                  end

          data[column].to_s.color(color)
        else
          data[column]
        end
      end

      def qualification
        Hash[@qualification.collect {|k, v| [ k, v.each_cons(2).map {|from, to| from..to }.max ] }] if @qualification
      end
    end
  end
end
