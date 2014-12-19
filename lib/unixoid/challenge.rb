module Unixoid
  class Challenge
    
    RESULTS_FILE = 'unixoid_results.txt'

    def self.run_specs
      new.run_specs
    end

    def run_specs
      Runner.run("rspec --out #{RESULTS_FILE} -fp #{spec_file}", outcodes: [0,1])
    end

    private 

    def spec_file
      File.join(File.dirname(__FILE__), '..', '..','challenge_spec.rb')
    end    
  end
end
