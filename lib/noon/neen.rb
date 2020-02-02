require 'securerandom'
require 'digest'
require 'time'
require 'bigdecimal'
require "ostruct"

class Noon::Neen
  attr_reader :uptoken, :downtoken, :uuid, :energy, :complexity
    
  def initialize(base_value = 1, additional_value= 1)
    raise 'negative input data exception' if base_value < 1 || additional_value < 1
    @base_value= base_value  
    @additional_value= additional_value
    @produce= produce_time 
    @uptoken= up_token
    @downtoken= down_token
    @uuid= u_uid
    @energy= energy
    @complexity= complexity
  end

  def self.create(neen_hash)
    OpenStruct.new neen_hash
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

  def index
    "#{@base_value}/#{@additional_value}"
  end

  def complexity
    down_index = downtoken.index(/[a-zA-Z1-9]/).to_f 
    up_index =  uptoken.index(/[a-zA-Z1-9]/).to_f
    Math.log2(up_index*down_index)      
  end

  def energy
    if @energy.nil?
     ptime = Time.now.to_i - produce
     ptime = 1 if ptime == 0  
     eng = complexity * ptime
     eng *= eng * BigDecimal("0.0375")
     @energy = eng.to_f
    end
    @energy  
  end

  def to_h
   {
    produce: @produce,
    base_value: @base_value,
    additional_value: @additional_value,
    uptoken: @uptoken,
    downtoken: @downtoken,
    uuid: @uuid,
    energy: @energy,
    complexity: @complexity
   }
  end

  def to_hash
    self.to_h
  end

  private
    
  def up_token
    # uptoken ve base_valuse of 0 at start of string token
    int = 1
    begin	
      int += 1
      token = Digest::SHA256.hexdigest "بسم الله الواحد الأحد الجبار الفرد الصمد لا إله إلا هوخالق السموات و الأرض و الخلق أجمعين #{uuid} #{int}" 
    end until token[0..@base_value] =~ /^0*$/
      token
  end

  def down_token
    # downtoken ve base_valuse + additional_value of 0 at start of string token
    int = 1
    begin
      int += 1    
      token = Digest::SHA512.hexdigest "لا غالب إلا الله له الملك الواحد القهار لا إله غلا هو الملك القدوس الرزاق السلام المؤمن المهيمن #{uuid} #{int}"
    end until token[0..(@base_value+@additional_value)] =~ /^0*$/
    token
  end

  def u_uid
    SecureRandom.uuid      
  end

  def produce_time
    Time.now.to_i
  end
end
