module FootballCli
  module Format
    class Base
      attr_reader :title, :response, :columns, :rows

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
        if @file_name
          File.write(@file_name, generate)
        else
          puts generate
        end
      end

      def goal_columns
        %i(goalsHomeTeam goalsAwayTeam).freeze
      end

      def qualification
        Hash[@qualification.collect {|k, v| [ k, v.each_cons(2).map {|from, to| from..to }.max ] }] if @qualification
      end
    end
  end
end
