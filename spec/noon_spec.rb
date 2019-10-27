require "noon"

RSpec.describe Noon do

  it "has a version number" do
    expect(Noon::VERSION).not_to be nil
  end

  it "new noon object" do
    noon = Noon.new
    expect(noon).not_to be nil
    expect(noon.amount).to be 0
  end

  it "noon can be convert to String" do
   noon= Noon.new 0.1
   expect(noon.to_s.class).to be String
   expect(noon.inspect.class).to be String
  end

  it "noon can be convert to HASH" do
   noon= Noon.new 0.1
   expect(noon.to_h.class).to be Hash
   expect(noon.to_hash.class).to be Hash
  end

  it "noon can be convert to string JSON" do
   noon= Noon.new 0.1
   expect(noon.to_json.class).to be String
  end

  it "neen can be read from noon Hash" do
   noon= Noon.new 0.1
   expect(noon.to_json.class).to be String
   expect(noon.to_h.class).to be Hash
  end

  it "noon merge to other noon" do
    noon1 = Noon.new(0.1)
    expect(noon1.neens.length).to be 10
    noon2 = Noon.new(0.2)
    expect(noon2.neens.length).to be 20
    noon1.merge noon2
    expect(noon1.neens.length).to be 30
  end

  it "noon ve energy lg zero" do
    noon= Noon.new 1
    expect(noon.energy).to be > 0
  end

  it "noon ve noon complexity lg zero" do
    noon= Noon.new 1
    expect(noon.complexity).to be > 0
  end

  it "noon can be expand with neens" do
    noon1 = Noon.new(0.1)
    noon1_energy = noon1.energy
    expect(noon1.neens.length).to be 10
    noon2 = Noon.new(0.2)
    expect(noon2.neens.length).to be 20
    noon1.expand noon2.neens   
    expect(noon1.neens.length).to be 30
    expect(noon1.energy).to be > noon1_energy
    expect(noon1.energy).to be > noon2.energy
  end
end
