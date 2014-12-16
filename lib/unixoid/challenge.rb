module Unixoid
  class Challenge

    def run_specs
      Runner.run("rspec #{spec_file} > unixoid_results.txt")
    end

    private

    def spec_file
      File.join(File.dirname(__FILE__), '..', '..','challenge_spec.rb')
    end    
  end
end
