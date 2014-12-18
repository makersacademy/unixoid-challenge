require 'cocaine'
require 'logger'

module Unixoid

  class Runner

    LOG_FILE = 'logfile.log'

    def initialize
      @logger = Logger.new(LOG_FILE)
    end

    def self.run(command)
      new.run(command)
    end    

    def run(command)
      line = Cocaine::CommandLine.new(command, "", { expected_outcodes: [0, 1], swallow_stderr: true } )
      begin
        log(:info, line.run)
      rescue Cocaine::ExitStatusError => e
        log(:error, e.message)
      end
    end

    def log(level, message)
      @logger.send(level, message)
      message
    end
  end
end
