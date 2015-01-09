describe "Unixoid test" do

  it "1. should have a my/private/files directory" do
    expect(File.exist?('my/private/files')).to be true
  end

  it "2. should have a my/public/files directory" do
    expect(File.exist?('my/public/files')).to be true
  end

  it "3. should have a my/private/files/t-vars.env file" do
    expect(File.exist?('my/private/files/t-vars.env')).to be true
  end

  it "4. should have 'List of env vars that begin with T' on first line of t-vars.env" do
    lines = File.readlines('my/private/files/t-vars.env')
    expect(lines.shift).to match(/^List of env vars that begin with T$/i)    
  end

  it "5. should have the list of env vars that begin with T in t-vars.env" do
    lines = File.readlines('my/private/files/t-vars.env')
    lines.shift if lines.first =~ /^List of env vars that begin with T$/i    
    lines.shift if lines.first == "\n"
    expect(lines.map{|l| l[0]}.uniq).to eq(['T'])
  end

  it "6. should have the TESTING_MAKERS env variable set up" do
    expect(ENV["TESTING_MAKERS"]).to eq('working')
  end

  it "7. should have the TESTING_MAKERS env set to be created for new terminal windows" do
    expect(File.read("#{Dir.home}/.bash_profile")).to match(/export\s+TESTING_MAKERS=working/)
  end

  it "8. should have t-vars.count in my/public/files with an overall count" do
    expect(File.exist?('my/public/files/t-vars.count')).to be true
    expect(File.read('my/public/files/t-vars.count')).to match(/^Overall count:\s+\d+\s*$/i)
  end

  it "9. should have rw access for the owner only on my/private/files/t-vars.env" do
    file = "my/private/files/t-vars.env"
    permissions = File.stat(file).mode  
    expect(permissions).to eq(0100600) # rw for the user only
  end

  it "10. should only allow the owner to change into my/private/files" do
    folder = "my/private/files"
    permissions = File.stat(folder).mode
    expect(permissions & 0000100).not_to eq(0)
    expect(permissions & 0000010).to eq(0)
    expect(permissions & 0000001).to eq(0)
  end

  it "11. should have rw permissions for all users on my/public/files/t-vars.count" do
    t_vars_permissions = File.stat('my/public/files/t-vars.count').mode    
    expect(t_vars_permissions & 0666).to eq(0666)    
  end

  it "12. should have the count of text files in my/public/files/text-files-count.txt" do
    expect(File.read('my/public/files/text-files-count.txt')).to match(/^\s*\d{2,6}\s*$/)
  end

  it "13. should have the the first three env vars in my/private/files/first-three-env.txt" do
    lines = File.readlines('my/private/files/first-three-env.txt')
    expect(lines.sort).to eq lines
    expect(lines.count).to eq(3)
  end

  it "14. should have commands.txt in my/private/files" do
    expect(File.exist?('my/private/files/commands.txt')).to be true
  end
end
