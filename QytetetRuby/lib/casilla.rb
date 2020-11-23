#encoding :UTF-8

module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla
    attr_accessor :coste
    
    def initialize(num_cas)
      @numero_casilla = num_cas
      @coste = 0
    end
=begin    
    def self.crear_calle(num_cas, tit)
      self.new(num_cas, TipoCasilla::CALLE, tit)
    end
    
    def self.crear_casilla(num_cas, tipo)
      self.new(num_cas, tipo, nil)
    end
=end
  
  end
  
end
