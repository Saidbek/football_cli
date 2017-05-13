module FootballCli
  module Format
    class Base
      attr_reader :title, :response, :columns, :rows, :file_name

      def initialize(opts={})
        @response = opts[:response]
        @title = opts[:title]
        @columns = opts[:columns]
        @file_name = opts[:file_name]

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
    end
  end
end
