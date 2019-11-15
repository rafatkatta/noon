require "noon"

RSpec.describe Noon do

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
  
  it "check new neen with default value == 1" do
     neen = Noon::Neen.new
     expect(neen.val).to be 1
     expect(neen.neen).not_to be nil
  end

  it "check new neen with default value == 3" do
     neen = Noon::Neen.new 3
     expect(neen.val).to be 3
     expect(neen.neen).not_to be nil
     expect(neen.uptoken).to match(/\A0{4}/)
     expect(neen.downtoken).to match(/\A0{5}/)
  end

  it "check new neen complexity value" do
     neen = Noon::Neen.new 
     expect(neen.complexity).to be > 1 
  end

  it "check new neen energy value" do
     neen = Noon::Neen.new
     expect(neen.energy).to be > 0
  end

  it "neen can be convert to Hash" do
     neen = Noon::Neen.new
     expect(neen.to_h.class).to be Hash
  end

  it "neen can be create from a Hash" do
     neen1 = Noon::Neen.new
     expect(neen1.neen).not_to be nil 
     expect(neen1.neen.class).to be Hash
     neen2 = Noon::Neen.create neen1.to_h
     expect(neen2.class).to be Noon::Neen
     expect(neen1.neen).to be neen2.neen
  end

end
