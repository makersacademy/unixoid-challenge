module Unixoid
  class Challenge

    def self.run_specs
      new.run_specs
    end

    def run_specs
      Runner.run("rspec --out unixoid_results.txt -fp #{spec_file}")
      "Congratulations, you have completed the unixoid challenge"
    end

    private 

    def spec_file
      File.join(File.dirname(__FILE__), '..', '..','challenge_spec.rb')
    end    
  end
end
