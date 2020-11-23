#encoding :UTF-8

require_relative "jugador"

module ModeloQytetet
  class Especulador < Jugador
    
    def self.copia(un_jugador, fian)
      super.copia(un_jugador)
      @fianza = fian
    end
    
    
    def pagar_impuesto() 
      cantidad = @casilla_actual.coste/2
      modificar_saldo(-cantidad);
    end
    
    def convertirme(fianza)
      self
    end

    def debo_ir_a_carcel()
      if( tengo_carta_libertad() && !pagar_fianza() )
          return true;
      end
      return false;
    end
    
    def pagar_fianza()
      if( tengo_saldo(@fianza) )
        modificar_saldo(-@fianza);
          true
      end
        false
    end

    def puedo_edificar_casa(tit)
      if( tengo_saldo(tit.precio_edificar()) )
        if(tit.num_casas() < 8)
          true
        end
      end
      
      false
      
    end
    
    def puedo_edificar_hotel(tit)
      if( tengo_saldo(tit.precio_edificar()) )
        if( tit.num_casas() >= 4 )
          return true
        end
      end
        
      false
    end
    
    def to_s
      info = super.to_s
      info = info + "Especulador, Fianza: #{@fianza}"
        
      info;
    end    
    
    protected :pagar_impuesto, :convertirme, :debo_ir_a_carcel, :puedo_edificar_casa, :puedo_edificar_hotel
    private :pagar_fianza
  end  
end
