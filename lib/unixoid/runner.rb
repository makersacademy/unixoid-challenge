module Unixoid

  class Runner

    def self.run(command)
      new.run(command)
    end    

    def run(command)
      Kernel.system(command)
    end

  end

end
