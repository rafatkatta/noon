require "noon/version"
require 'securerandom'
require 'digest'
require 'time'

module Noon
  class Error < StandardError; end

  class Builder
    attr_reader :neens, :amount, :difficult
    
    def initialize(amount= 0, difficult= 2)
        @amount= amount
        @difficult= difficult
        generate if amount > 0
    end

    private

    def units
     @amount * 100
    end
    
    def generate
      @neens = []
      if @amount > 0
        (1..units).each do |i|
           @neens << Noon::Neen.new(@difficult)
        end
      end
      @neens
    end
  end

  class Neen
    attr_reader :neen, :val    
    
    @val = 2
    
    def initialize(value = 2)
      @val = value if value >= 2
      @neen = {uuid: uuid, uptoken: uptoken, downtoken: downtoken}         
    end

    def uptoken
      Neen.uptoken
    end

    def downtoken
      Neen.downtoken
    end 

    def uuid
      Neen.uuid
    end

    private

    def self.val(val)
      @val = val
    end

    def self.uptoken
      int = 1
      begin	
        int += 1
        token = Digest::SHA256.hexdigest "بسم الله الواحد الأحد الجبار الفرد الصمد لا إله إلا هوخالق السموات و الأرض و الخلق أجمعين #{uuid} #{int}" 
      end until token[0..@val] =~ /^0*$/
      token
    end

    def self.downtoken
      int = 1
      begin
        int += 1    
        token = Digest::SHA512.hexdigest "لا غالب إلا الله له الملك الواحد القهار لا إله غلا هو الملك القدوس الرزاق السلام المؤمن المهيمن #{uuid} #{int}"
      end until token[0..(@val+1)] =~ /^0*$/
      token
    end

    def self.uuid
      SecureRandom.uuid      
    end
  end

end
