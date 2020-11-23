#encoding :UTF-8

require "singleton"

module ModeloQytetet
  class Dado
    include Singleton
    
    attr_reader :valor
    @@dado = nil
    
    def initialize
      @valor = 0
    end
    
    def tirar()
      @valor = rand(6) + 1
      @valor
    end
    
    def to_s
      "Al tirar el dado ha salido un #{@valor}"
    end
    
  end
end
