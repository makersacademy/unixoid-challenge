class UnixoidChallenge
  def self.run
    puts "Running the Unixoid Challenge Assessor ..."
    File.write 'unixoid_spec.rb', File.readlines(File.join(File.dirname(__FILE__), '..','spec','unixoid_spec.rb')).join
    `rspec unixoid_spec.rb > unixoid_results.txt`
    puts 'Please enter your github user name:'
    username = gets.chomp
    curl = %Q{curl -u #{username} https://api.github.com/user/repos -d '{"name":"unixoid_submission"}'}
    %x[#{curl}]
    `git init`
    `git add unixoid_results.txt`
    `git commit -am 'unixoid submission'`
    add_remote = "git remote add origin git@github.com:#{username}/unixoid_submission.git"
    %x[#{add_remote}]
    `git push origin master`
    puts "Completed Submission!"
  end
end