require 'json'
require 'ostruct'

class Noon
  VERSION = '0.9.1'
  attr_reader :amount, :energy, :complexity, :neens

  def initialize(amount= 0, difficult= 1, additional_value= 1)
    @noon = Builder.new(amount, difficult, additional_value)
    {amount: amount, energy: self.energy, neens: @noon.neens}
  end

  def to_s
   inspect
  end

  def inspect  
    """
    amount: #{@noon.amount} 
    complexity: #{@noon.complexity} 
    energy: #{self.energy}
    neens: #{@noon.neens}
    """
  end  

  def to_h
    @noon.to_h
  end

  def to_hash
    self.to_h
  end

  def to_json
    JSON.generate self.to_h
  end
 
  def amount
    @noon.amount
  end

  def difficult
    @noon.difficult
  end

  def additional_value
    @noon.additional_value
  end

  def neens
    @noon.neens
  end

  def merge(noon)
    @noon.amount = @noon.amount + noon.amount
    @noon.difficult = noon.difficult if @noon.difficult > noon.difficult
    @noon.additional_value = noon.additional_value if @noon.additional_value > noon.additional_value
    @noon.neens.concat noon.neens
    @noon
    {amount: @noon.amount, energy: self.energy, complexity: self.complexity, neens: @noon.neens} 
  end 
  
  def energy
    @noon.energy.to_f.round(4)
  end

  def complexity
    @noon.complexity
  end

  def expand(neens)
    @noon.amount = @noon.amount + neens.length/100
    @noon.neens.concat neens
    {amount: @noon.amount, energy: self.energy, complexity: self.complexity, neens: @noon.neens}
  end
end

require 'noon/neen'
require 'noon/builder'

