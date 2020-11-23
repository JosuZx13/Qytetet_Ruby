#encoding :UTF-8

module ModeloQytetet
  class OtraCasilla < Casilla

    attr_reader :tipo, :titulo
    
    def initialize(num_cas, tip)
      super(num_cas)
      @tipo = tip
      @titulo = nil

      if(tip == TipoCasilla::IMPUESTO)
        self.coste = 300
      end

    end
    
    def soy_edificable
      false
    end
    
    def tengo_propietario
      false
    end
    
    #Los metodos get/setTitulo, el coste, tengoPropietario no seran necesarios
    
    def to_s
      "\tCasilla\t{Numero: #{@numero_casilla}\t Tipo: #{@tipo}}"  
    end

  end
end