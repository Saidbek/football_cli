module FootballCli
  module Format
    class Base
      attr_reader :title, :response, :attrs, :rows

      def initialize(title, response, attrs)
        @title = title
        @response = response
        @attrs = attrs

        @rows = []
      end

      def output
        raise 'must implement method: output'
      end
    end
  end
end
