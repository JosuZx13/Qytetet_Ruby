#encoding :UTF-8

require_relative "casilla"

module ModeloQytetet
  class Calle < Casilla
    
    attr_reader :tipo_casilla, :coste, :tipo
    attr_accessor :titulo
    
    def initialize(num_cas, tit)
      super(num_cas)
      @titulo = tit
      @coste = tit.precio_compra
      @tipo_casilla = TipoCasilla::CALLE
    end
    
    def asignar_propietario(jug)
      @titulo.propietario = jug
      @titulo
    end
    
    def pagar_alquiler()
      coste_alquiler = @titulo.pagar_alquiler()
      coste_alquiler
    end
    
    def soy_edificable()
      true
    end
    
    def tengo_propietario()
      @titulo.tengo_propietario()
    end

=begin
    def propietario_encarcelado()
      @titulo.propietario_encarcelado()
    end
=end
    
    def to_s
      "\tCalle\t{Numero: #{@numero_casilla}\t Coste: #{@coste}\t Tipo: #{@tipo}\t #{@titulo.to_s}}"  
    end
    
    #protected :asignar_propietario, :soy_edificable, :tipo_casilla, :titulo
    #private :titulo=
    
  end
end
