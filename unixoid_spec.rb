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

end