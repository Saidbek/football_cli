require 'football_cli'

# to use Webmock we need the Runner class
# https://github.com/cucumber/aruba#testing-ruby-cli-programs-without-spawning-a-new-ruby-process
module FootballCli
  class Runner
    def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
      @argv = argv
      @stdin = stdin
      @stdout = stdout
      @stderr = stderr
      @kernel = kernel
    end

    def execute!
      exit_code = run_cli
      @kernel.exit(exit_code)
    end

    private

    def run_cli
      exit_code = begin
        $stderr = @stderr
        $stdin = @stdin
        $stdout = @stdout

        FootballCli::CLI.start(@argv)

        0
      rescue StandardError => e
        b = e.backtrace
        @stderr.puts("#{b.shift}: #{e.message} (#{e.class})")
        @stderr.puts(b.map { |s| "\tfrom #{s}" }.join("\n"))
        1
      rescue SystemExit => e
        e.status
      ensure
        $stderr = STDERR
        $stdin = STDIN
        $stdout = STDOUT
      end

      @kernel.exit(exit_code)
    end
  end
end
