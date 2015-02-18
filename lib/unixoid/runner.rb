require 'cocaine'
require 'logger'

module Unixoid

  class Runner

    LOG_FILE = 'logfile.log'

    def initialize
      @logger = Logger.new(LOG_FILE)
    end

    def self.run(command, params: {}, outcodes: {})
      new.run(command, params, outcodes)
    end

    def run(command, params: {}, outcodes: [0])
      line = Cocaine::CommandLine.new('', command, expected_outcodes: outcodes, swallow_stderr: true)
      begin
        log(:info, line.run(params))
      rescue Cocaine::ExitStatusError => error
        log(:error, error.message)
      end
    end

    def log(level, message)
      @logger.send(level, message)
      message
    end
  end
end
