module GithubBackup
  class Shell
    attr_reader :debug

    def initialize(opts = {})
      @debug = opts[:debug] || false
    end

    def run(command)
      puts "EXECUTING: #{command}" if debug
      IO.popen(command, 'r') do |io|
        output = io.read
        puts "OUTPUT:" if debug
        puts output if debug
      end
    end
  end
end
