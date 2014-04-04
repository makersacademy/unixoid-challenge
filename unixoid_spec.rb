describe "Unixoid test" do

  it "should have rw access for the owner only on my/private/files/t-vars.env" do
    file = "my/private/files/t-vars.env"
    expect(File.exist?(file)).to be_true
    permissions = File.stat(file).mode  
    expect(permissions).to eq(0100600) # rw for the user only
  end

  it "should only allow the owner to change into my/private/files" do
    folder = "my/private/files"
    permissions = File.stat(folder).mode
    expect(permissions & 0000100).to be_true
    expect(permissions & 0000010).to eq(0)
    expect(permissions & 0000001).to eq(0)
  end

  it "should have t-vars.count and text-files-count.txt in my/public/files" do
    expect(File.exist?('my/public/files/t-vars.count')).to be_true
    expect(File.exist?('my/public/files/text-files-count.txt')).to be_true
  end

  it "should have rw permissions for all users on my/public/files/t-vars.count" do
    t_vars_permissions = File.stat('my/public/files/t-vars.count').mode    
    expect(t_vars_permissions & 0666).to eq(0666)    
  end

  it "should have the list of env vars that begin with T in t-vars.env" do
    lines = File.readlines('my/private/files/t-vars.env')
    expect(lines.shift).to match(/^List of env vars that begin with T$/i)    
    lines.shift if lines.first == "\n"
    expect(lines.map{|l| l[0]}.uniq).to eq(['T'])
  end

  it "should have the TESTING_MAKERS env variable set up" do
    expect(ENV["TESTING_MAKERS"]).to eq('working')
    expect(File.read("#{Dir.home}/.bash_profile")).to match(/export\s+TESTING_MAKERS=working/)
  end

  it "should have the count of env vars in my/public/files/t-vars.count" do
    expect(File.read('my/public/files/t-vars.count')).to match(/^Overall count:\s+\d+\s*$/)
  end

  it "should have the count of text files in my/public/files/text-files-count.txt" do
    expect(File.read('my/public/files/text-files-count.txt')).to match(/^\s*\d{2,6}\s*$/)
  end

end
