require "noon"

RSpec.describe Noon do

  it "check new neen with default value == 1" do
     neen = Noon::Neen.new
     expect(neen.index).not_to be nil
  end

  it "check new neen with default value == 3" do
     neen = Noon::Neen.new 3
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

  it "check 2 neens ve not same values" do
     neen1 = Noon::Neen.new
     neen2 = Noon::Neen.new
     expect(neen1).not_to be eql? neen2
  end

  it "check 2 neens ve not same uptukens" do
     neen1 = Noon::Neen.new
     neen2 = Noon::Neen.new
     expect(neen1.uptoken).not_to be eql? neen2.uptoken
  end

  it "check 2 neens ve not same uptukens" do
     neen1 = Noon::Neen.new
     neen2 = Noon::Neen.new
puts neen1.uptoken
puts neen2.uptoken
     expect(neen1.produce).not_to be eql? neen2.produce
  end

  it "neen can be convert to Hash" do
     neen = Noon::Neen.new
     expect(neen.to_h.class).to be Hash
  end

  it "neen can be create from a Hash" do
     neen1 = Noon::Neen.new
     expect(neen1).not_to be nil 
     expect(neen1.to_hash.class).to be Hash
     neen2 = Noon::Neen.create neen1.to_h
     expect(neen2.class).to be OpenStruct
     neen1.to_h == neen2.to_h
  end

  it "from a Hash created neen ve right attributtes" do
     neen1 = Noon::Neen.new
     expect(neen1.to_h.class).to be Hash
     neen2 = Noon::Neen.create neen1.to_h
     expect(neen2.class).to be OpenStruct
     expect(neen2.complexity).to be > 0
     expect(neen2.energy).to be > 0
  end

  it "from a Hash created neen compare attributtes" do
     neen1 = Noon::Neen.new
     expect(neen1).not_to be nil
     neen2 = Noon::Neen.create neen1.to_h
     expect(neen2.class).to be OpenStruct
     expect(neen2.complexity).to be == neen1.complexity
     expect(neen2.energy).to be == neen1.energy
  end
end
