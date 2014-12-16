module Unixoid

  class Runner

    def run(command)
      Kernel.system(command)
    end
  end

end
