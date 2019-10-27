require 'ostruct'

class Noon::Builder
  #build noon every noon conatine neens
  attr_reader :neens, :amount, :energy, :complexity
  attr_reader :difficult, :additional_value 
  
  def initialize(amount= 0, difficult= 1, additional_value= 1)
    @amount = amount
    @difficult = difficult
    @additional_value = additional_value
    generate if amount > 0
  end

  def self.create(builder_hash)
    builder = Noon::Builder.new
    builder.amount = builder_hash[:amount]
    builder.neens = builder_hash[:neens].map{|neen| Noon::Neen.create neen}
    builder.energy
    builder.complexity
    builder
  end

  def energy
    @energy = 0
    if @neens
      @neens.each do |neen|
        @energy += neen.energy
      end
    end
    @energy
  end

  def to_h
    neens_hash = neens.map{|n| n.to_h}
    { amount: @amount,
      energy: self.energy,
      complexity: self.complexity,
      neens: neens_hash
    }
  end

  def to_hash
    self.to_h
  end

  def to_json
    JSON.generate(self.to_h)
  end

  def amount=(amount)
    @amount = amount
  end

  def neens=(neens)
    @neens = neens
  end

  def difficult=(difficult)
    @difficult = difficult
  end

  def additional_value=(additional_value)
    @additional_value = additional_value
  end

  def complexity
    @complexity = 0.0
    if @neens
      @neens.each do |neen|
        @complexity += neen.complexity
      end
      @complexity = (@complexity / @neens.length).round(4)
    end
    @complexity  
  end

  private

  def units
    # every noon unit ve 100 neens 
    @amount * 100
  end
    
  def generate
    @neens = []
    if @amount > 0
      (1..units).each do |i|
         @neens << Noon::Neen.new(@difficult,@additional_value)
      end
    end
    @neens
  end
end
