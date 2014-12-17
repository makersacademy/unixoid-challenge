require 'cocaine'

module Unixoid

  class Runner

    def self.run(command)
      new.run(command)
    end    

    def run(command)
      line = Cocaine::CommandLine.new(command)
      begin
         line.run
      rescue Cocaine::ExitStatusError => e
         e.message
      end
    end
  end
end
