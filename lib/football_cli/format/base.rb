module FootballCli
  module Format
    class Base
      attr_reader :title, :response, :columns, :rows

      def initialize(response, opts={})
        @response = response
        @title = opts[:title]
        @columns = opts[:columns]

        @rows = []
      end

      def output
        raise NotImplementedError, 'Sorry, you have to override output'
      end

      def goal_columns
        %i(goalsHomeTeam goalsAwayTeam)
      end
    end
  end
end
