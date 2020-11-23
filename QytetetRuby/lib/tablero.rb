#encoding :UTF-8

require_relative "qytetet.rb"

module ModeloQytetet
  class Tablero
    attr_reader :carcel, :casillas
    
    def initialize
      inicializar
    end
    
    #Metodos
    def es_casilla_carcel(numero_casilla)
      if @casillas.at(numero_casilla).tipo == TipoCasilla::CARCEL
        true
      else
        false
      end
    end
    
    def obtener_casilla_final(cas, despl)
        @casillas.at( (cas.numero_casilla + despl) % @casillas.size );
    end
  
    def obtener_casilla_numero(numero_casilla)
        if numero_casilla >= 0 && numero_casilla < @casillas.size
            @casillas.at(numero_casilla);
        else
            nil
        end
    end
    
    def inicializar
      
      propiedades = Array.new
                                          #nom,            pr_com, alq_base, fact_reval, hipot_base, prec_edificar
      propiedades << TituloPropiedad.new("Calle Atenea",        350,  35,  0.17,  175,  100)
      propiedades << TituloPropiedad.new("Calle Artemisa",      350,  40, -0.14,  175,  120)
      propiedades << TituloPropiedad.new("Casino Loki",         600,  200, 13,    340,  130)
      propiedades << TituloPropiedad.new("Avenida de Dioniso",  500,  120, 0.2,   60,   200)
      propiedades << TituloPropiedad.new("Herreria Hefesto",    550,  65,  -0.2,  80,   260)
      propiedades << TituloPropiedad.new("Mar Poseidón",        350,  150, 0.15,  135,  325)
      propiedades << TituloPropiedad.new("Palacio de Afrodita", 460,  110, 0.1,   160,  360)
      propiedades << TituloPropiedad.new("Altar de Freyja",     480,  230, 0.1,   280,  540)
      propiedades << TituloPropiedad.new("Coliseo de Zeus",     580,  150, 0.19,  200,  425)
      propiedades << TituloPropiedad.new("Aposentos de Odin",   600,  195, -0.14, 195,  395)
      propiedades << TituloPropiedad.new("Olimpo",              700,  260, 0.1,   210,  430)
      propiedades << TituloPropiedad.new("Valhalla",            750,  280, 0.2,   230,  480)
      
      @casillas = Array.new
      index_propiedad = 0;
      index_casilla = 0;
      
      #Casillas van de la 0 a la 19
      @casillas << OtraCasilla.new(index_casilla, TipoCasilla::SALIDA) #Casilla 0
      index_casilla += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << OtraCasilla.new(index_casilla, TipoCasilla::CARCEL) #Casilla 5
      index_casilla += 1
      @casillas << OtraCasilla.new(index_casilla, TipoCasilla::SORPRESA)
      index_casilla += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << OtraCasilla.new(index_casilla, TipoCasilla::IMPUESTO) #Casilla 10
      index_casilla += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << OtraCasilla.new(index_casilla, TipoCasilla::SORPRESA)
      index_casilla += 1
      @casillas << OtraCasilla.new(index_casilla, TipoCasilla::PARKING)
      index_casilla += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad)) #Casilla 15
      index_casilla += 1
      index_propiedad += 1
      @casillas << OtraCasilla.new(index_casilla, TipoCasilla::JUEZ)
      index_casilla += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad))
      index_casilla += 1
      index_propiedad += 1
      @casillas << OtraCasilla.new(index_casilla, TipoCasilla::SORPRESA)
      index_casilla += 1
      @casillas << Calle.new(index_casilla, propiedades.at(index_propiedad)) #Casilla 19

      @carcel = @casillas.at(5)
    end
    
    
    def to_s
      "Tablero{\nCasillas{ "

      for cas in @casillas
        puts cas.to_s
      end
      
      "\n\tCarcel: #{@carcel}\n"
    end

    private :inicializar
    
  end
end

