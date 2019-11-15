require "noon"
require 'byebug'

RSpec.describe Noon do

  it "check currency amout == 0" do
    noon = Noon::Builder.new
    expect(noon).not_to be nil
    expect(noon.amount).to be 0
    expect(noon.difficult).to be 1
    expect(noon.neens).to be nil
  end 

 it "check currency amout == 0.01" do
    noon = Noon::Builder.new(0.01)
    expect(noon).not_to be nil
    expect(noon.amount).to be 0.01
    expect(noon.difficult).to be 1
    expect(noon.neens.size).to be 1 
  end

 it "check currency amout == 0.15" do
    noon = Noon::Builder.new(0.15)
    expect(noon).not_to be nil
    expect(noon.amount).to be 0.15
    expect(noon.difficult).to be 1
    expect(noon.neens.size).to be 15
  end

 it "check currency pruduce times at amout == 0.15" do
    noon = Noon::Builder.new(0.15)
    expect(noon).not_to be nil
    expect(noon.amount).to be 0.15
    expect(noon.difficult).to be 1
    expect(noon.neens.size).to be 15
    expect(noon.neens.first.produce).not_to be noon.neens.last.produce
  end

  it "check currency energy value" do
    noon = Noon::Builder.new(0.15)
    expect(noon.energy).to be > 0
  end

  it "noon Builder can be convert to Hash" do
     noon = Noon::Builder.new 0.1
     expect(noon.to_h.class).to be Hash
  end

  it "noon Builder Hash be paresd as Valid JSON" do
     noon = Noon::Builder.new 0.1
     expect(noon.to_json.class).to be String
     JSON.parse noon.to_json
  end

  it "noon Builder can be created from hash" do
     noon = Noon::Builder.new(0.1).to_h
     expect(noon.class).to be Hash
     noon = Noon::Builder.create(noon)
     expect(noon.class).to be Noon::Builder
  end
  it "validate selfs neens" do
    noon = Noon::Builder.new(0.1)
    expect(noon.validate).to be true
  end

  it "validate others neens" do
    noon1 = Noon::Builder.new(0.1)
    noon2 = Noon::Builder.new(0.1)
    expect(noon1.validate).to be true
    expect(noon2.validate).to be true
    expect(noon1.validate noon2.neens).to be true
  end 
  
end
