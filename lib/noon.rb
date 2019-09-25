require "noon/version"
require 'securerandom'
require 'digest'
require 'time'

module Noon
  class Error < StandardError; end

  class Builder
    #build noon every noon conatine neens
    attr_reader :neens, :amount, :difficult, :additional_value
    
    def initialize(amount= 0, difficult= 1, additional_value= 1)
        @amount= amount
        @difficult= difficult
        @additional_value= additional_value
        generate if amount > 0
    end

    def energy
      @energy = 0
      unless @neens.nil
        @neens.each do |neen| 
          @energy += neen.energy
        end
      end
      @energy
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

  class Neen
    attr_reader :neen
    
    @base_value = 1
    @additional_value= 1
    
    def initialize(base_value = 1, additional_value= 1)
      @produce= Neen.produce
      @base_value = base_value if base_value >= 1
      @additional_value= additional_value
      @uptoken= Neen.uptoken
      @downtoken= Neen.downtoken
      @uuid= Neen.uuid
      @energy= self.energy
      @neen = {uuid: @uuid, uptoken: @uptoken, downtoken: @downtoken, produce: @produce, energy: @energy}         
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

    def complexity
      down_index = self.downtoken.index(/[a-zA-Z1-9]/).to_f 
      up_index =  self.uptoken.index(/[a-zA-Z1-9]/).to_f
      up_index*down_index      
    end

    def energy
      ptime= Neen.produce-self.produce
      Math.log2(self.complexity * ptime).round(4)
    end

    private
    
    def self.additional_value(additional_value)
      @additional_value= additional_value
    end

    def self.val(val)
       Neen.base_value val
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

end
