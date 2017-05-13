module FootballCli
  module Format
    class Base
      attr_reader :title, :response, :columns, :rows

      def initialize(opts={})
        @response = opts[:response]
        @title = opts[:title]
        @columns = opts[:columns]

        @rows = []
      end

      def output
        raise NotImplementedError, 'must implement output() method in subclass'
      end

      def goal_columns
        %i(goalsHomeTeam goalsAwayTeam)
      end
    end
  end
end
