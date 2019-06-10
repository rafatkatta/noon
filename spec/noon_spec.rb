RSpec.describe Noon do

  it "has a version number" do
    puts Noon::VERSION
    expect(Noon::VERSION).not_to be nil
  end

  it "check neen uptoken" do
    expect(Noon::Neen.uptoken).not_to be nil
  end

  it "check neen downtoken" do
    expect(Noon::Neen.downtoken).not_to be nil
  end

  it "check neen uuid" do
    expect(Noon::Neen.uuid).not_to be nil
  end

  it "check neen uptoken diff true" do
    uptokens = []
    (0..5).each do |i|
     uptokens << Noon::Neen.uptoken
    end
    expect(uptokens.uniq.size).to be uptokens.size
  end

  it "check neen downtoken diff true" do
    downtokens = []
    (0..5).each do |i|
     downtokens << Noon::Neen.downtoken
    end
    expect(downtokens.uniq.size).to be downtokens.size
  end

  it "set value 3 at start check up and down tokens" do
    Noon::Neen.val 3
    uptoken = Noon::Neen.uptoken
    downtoken = Noon::Neen.downtoken
    expect(uptoken).to match(/\A0{4}/)
    expect(downtoken).not_to match(/\A0{8}/)         
  end
  
  it "check new neen with default value == 2" do
     neen = Noon::Neen.new
     expect(neen.val).to be 2
     expect(neen.neen).not_to be nil
  end

  it "check new neen with default value == 3" do
     neen = Noon::Neen.new 3
     expect(neen.val).to be 3
     expect(neen.neen).not_to be nil
     expect(neen.uptoken).to match(/\A0{4}/)
     expect(neen.downtoken).to match(/\A0{5}/)
  end

end
