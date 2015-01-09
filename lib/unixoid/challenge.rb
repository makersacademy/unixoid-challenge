module Unixoid
  class Challenge
    
    RESULTS_FILE = 'unixoid_results.txt'

    def self.run_specs
      new.run_specs
    end

    def run_specs
      results = Runner.run("rspec --order defined -fp #{spec_file}", outcodes: [0,1]).lines.first
      File.write("#{RESULTS_FILE}", results)
      results
    end

    private 

    def spec_file
      File.join(File.dirname(__FILE__), '..', '..','challenge_spec.rb')
    end    
  end
end
