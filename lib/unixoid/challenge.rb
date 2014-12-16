module Unixoid
  class Challenge
    def self.run_specs
      Runner.run('rspec challenge_spec.rb')
    end
  end
end
