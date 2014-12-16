module Unixoid

  class Runner

    def run(command)
      Kernel.system(command)
    end

    def self.run(command)
      Runner.new.run(command)
    end    
  end

end
