require 'cocaine'

module Unixoid

  class Runner

    def self.run(command)
      new.run(command)
    end    

    def run(command)
      Cocaine::CommandLine.new(command).run
    end
  end
end
