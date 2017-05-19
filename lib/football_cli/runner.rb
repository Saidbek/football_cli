require 'gli'
require 'football_cli'

module FootballCli
  class Runner
    include GLI::App

    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel

    end

    def execute!
      begin
        $stdout = @stdout
        $stdin = @stdin
        $stderr = @stderr

        program_desc 'Football scores for geeks.'

        version FootballCli::VERSION
        subcommand_option_handling :normal
        arguments :strict

        desc 'Show leagues, team players, fixtures and more'
        command :show do |c|
          c.desc 'Specify league code'
          c.flag [:l, :league]

          c.desc 'Specify match day'
          c.flag [:md, :match_day]

          c.desc 'Specify team code'
          c.flag [:t, :team]

          c.desc 'Specify format'
          c.flag [:ft, :format]

          c.desc 'Specify file name to save output'
          c.flag [:fl, :file]

          c.switch [:p, :players]
          c.switch [:fs, :fixtures]

          c.action do |global_options, options, args|
            @handler.run
          end
        end

        desc 'Display live scores'
        command :live do |c|
          c.action do |global_options,options,args|
            @handler.run
          end
        end

        pre do |global,command,options,args|
          @handler = FootballCli::Handler.new(command.name, options)
        end

        post do |global,command,options,args|
          # Post logic here
          # Use skips_post before a command to skip this
          # block on that command only
        end

        on_error do |exception|
          # Error logic here
          # return false to skip default error handling
          puts "----- backtrace: #{exception.backtrace}"
          true
        end

        run(@argv)
      ensure
        $stdout = STDOUT
        $stdin = STDIN
        $stderr = STDERR
      end
    end
  end
end
