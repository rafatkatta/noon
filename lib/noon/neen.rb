require 'securerandom'
require 'digest'
require 'time'
require 'bigdecimal'

class Noon::Neen
  attr_reader :neen
    
  @base_value = 1
  @additional_value= 1
    
  def initialize(base_value = 1, additional_value= 1)
    @produce= Noon::Neen.produce
    @base_value = base_value if base_value >= 1
    @additional_value= additional_value
    @uptoken= Noon::Neen.uptoken
    @downtoken= Noon::Neen.downtoken
    @uuid= Noon::Neen.uuid
    @energy= self.energy
    @neen = {uuid: @uuid, uptoken: @uptoken, downtoken: @downtoken, produce: @produce, energy: @energy, complexity: self.complexity}         
  end

  def self.create(neen_hash)
    neen = Noon::Neen.new
    neen.neen = neen_hash
    neen
  end  
 
  def uptoken
    @uptoken
  end

  def downtoken
    @downtoken
  end 

  def uuid
    @uuid
  end

  def produce
    @produce
  end

  def val
    @base_value
  end

  def neen=(neen)
    @neen = neen
  end

  def complexity
    down_index = self.downtoken.index(/[a-zA-Z1-9]/).to_f 
    up_index =  self.uptoken.index(/[a-zA-Z1-9]/).to_f
    Math.log2(up_index*down_index)      
  end

  def energy
    ptime = Time.now.to_i - produce
    ptime = 1 if ptime == 0  
    eng = complexity * ptime
    eng *= eng * BigDecimal("0.0375")
  end

  def to_h
    @neen
  end

  def to_hash
    @neen
  end

  private
    
  def self.additional_value(additional_value)
    @additional_value= additional_value
  end

  def self.val(val)
    Noon::Neen.base_value val
  end

  def self.base_value(base_value)
    @base_value = base_value
  end

  def self.uptoken
    # uptoken ve base_valuse of 0 at start of string token
    int = 1
    begin	
      int += 1
      token = Digest::SHA256.hexdigest "بسم الله الواحد الأحد الجبار الفرد الصمد لا إله إلا هوخالق السموات و الأرض و الخلق أجمعين #{uuid} #{int}" 
    end until token[0..@base_value] =~ /^0*$/
      token
  end

  def self.downtoken
    # downtoken ve base_valuse + additional_value of 0 at start of string token
    int = 1
    begin
      int += 1    
      token = Digest::SHA512.hexdigest "لا غالب إلا الله له الملك الواحد القهار لا إله غلا هو الملك القدوس الرزاق السلام المؤمن المهيمن #{uuid} #{int}"
    end until token[0..(@base_value+@additional_value)] =~ /^0*$/
    token
  end

  def self.uuid
    SecureRandom.uuid      
  end

  def self.produce
    Time.now.to_i
  end
end
