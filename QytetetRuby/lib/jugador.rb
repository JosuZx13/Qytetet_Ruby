#encoding :UTF-8

module ModeloQytetet
  class Jugador
    attr_accessor :casilla_actual, :encarcelado, :carta_libertad
    attr_reader :nombre, :saldo, :propiedades

    def initialize(nom)
      @nombre = nom
      @encarcelado = false
      @saldo = 7500
      @carta_libertad = nil
      @propiedades = Array.new
      @casilla_actual = nil
    end
    
    #Constructores explícitos
    def self.nuevo(nom)
      self.new(nom)
    end
    
    def self.copia(otro_jugador)
      self.new(otro_jugador.nombre)
      @encarcelado = otro_jugador.encarcelado
      @saldo = otro_jugador.saldo
      @carta_libertad = otro_jugador.carta_libertad
      @propiedades = otro_jugador.propiedades
      @casilla_actual = otro_jugador.casilla_actual
    end
    
    #Metodos
    def cancelar_hipoteca(tit)
      cancelada = false
      coste_anular = tit.calcular_coste_cancelar()
      si_saldo = tengo_saldo(coste_anular)
        
        if(si_saldo)
            modificar_saldo(-coste_anular)
            tit.hipotecada = false
            cancelada = true;
        end
        
        cancelada
    end
    
    def comprar_titulo_propiedad()
      comprado = false
      coste_compra = @casilla_actual.coste
        
      if(coste_compra < @saldo)
        titulo = @casilla_actual.asignar_propietario(self)
        @propiedades << titulo
        modificar_saldo(-coste_compra)
        comprado = true;
      end
        
      comprado
      
    end
    
    def cuantas_casas_hoteles_tengo()
      total_viviendas = 0
      
      for v in @propiedades
        total_viviendas = total_viviendas + v.num_hoteles + v.num_casas
      end
      
      total_viviendas
      
    end
    
    def debo_pagar_alquiler()
      pagar_alquiler = false;
      titulo = @casilla_actual.titulo;
      es_mi_propiedad = es_de_mi_propiedad(titulo)
        
      if(!es_mi_propiedad)
        tiene_prop = titulo.tengo_propietario()

        if(tiene_prop)
          encarcelado = titulo.propietario_encarcelado();

          if(!encarcelado)
            esta_hipotecada = titulo.hipotecada

            if(!esta_hipotecada)
              pagar_alquiler = true;
            end

          end

        end

      end
        
      pagar_alquiler
    end
    
    def devolver_carta_libertad()
      aux = nil
      if(@carta_libertad != nil)
        aux = @carta_libertad
        @carta_libertad = nil
      end
      aux
    end
    
    def edificar_casa(tit)
      edificada = false
      num_casas = tit.num_casas
        
      if(num_casas < 4)
        coste_edificar_casa = tit.precio_edificar
        si_saldo = tengo_saldo(coste_edificar_casa)
            
        if(si_saldo)
          tit.edificar_casa()
          modificar_saldo(-coste_edificar_casa)
          edificada = true;
        end
            
      end
        
      edificada;
    end
    
    def edificar_hotel(tit)
      edificado = false
      num_casas = tit.num_casas
      num_hoteles = tit.num_hoteles
        
      if(num_casas == 4 && num_hoteles < 4)
        coste_edificar_hotel = tit.precio_edificar
        si_saldo = tengo_saldo(coste_edificar_hotel)
            
        if(si_saldo)
          tit.edificar_hotel()
          modificar_saldo(-coste_edificar_hotel)
          edificado = true;
        end
            
      end
        
      edificado;
    end
    
    def eliminar_de_mis_propiedades(tit)
      @propiedades.delete(tit)
      tit.propietario = nil
    end
    
    def es_de_mi_propiedad(tit)
      mia = false
      
      for p in @propiedades
        if(p == tit)
          mia = true
        end
      end
      
      mia
      
    end
    
    def hipotecar_propiedad(tit)
      coste_hipoteca = tit.hipotecar()
        
      modificar_saldo(coste_hipoteca)
    end
    
    def ir_a_carcel(cas)
      @casilla_actual = cas
      @encarcelado = true
    end
    
    def modificar_saldo(cantidad)
      @saldo = @saldo + cantidad
           
      @saldo
    end
    
    def obtener_capital()
      capital = @saldo + valor_propiedades()
      
      capital
    end
    
    #metodo propio
    def valor_propiedades()
      valor = 0
      valor_prop = 0;
      
      for p in @propiedades
        valor_prop = p.precio_compra
        
        valor_prop = valor_prop + ( ( p.num_casas + p.num_hoteles )*p.precio_edificar )
        
        if(p.hipotecada)
          valor_prop = valor_prop - p.hipoteca_base
        end
        
        valor = valor + valor_prop
        
      end
      
      valor
      
    end
    
    def obtener_propiedades(hipote)
      aux = Array.new
      
      for p in @propiedades
        if(p.hipotecada == hipote)
          aux << p
        end
      end
      
      aux
      
    end
    
    def pagar_alquiler()
      coste_alquiler = @casilla_actual.pagar_alquiler()
        
      modificar_saldo(-coste_alquiler)
    end
    
    def pagar_impuesto()
      @saldo = @saldo - @casilla_actual.coste
    end
    
    def pagar_libertad(cantidad)
      si_saldo = tengo_saldo(cantidad);
        
      if(si_saldo)
        @encarcelado = false
        modificar_saldo(-cantidad)
      end
      
    end
    
    def tengo_carta_libertad()
      tiene = @carta_libertad != nil
      
      tiene
    end
    
    def tengo_saldo(necesario)
      suficiente = @saldo > necesario
      
      suficiente
    end
    
    def vender_propiedad(cas)
      tit = cas.titulo
      eliminar_de_mis_propiedades(tit)
        
      precio_venta = tit.calcular_precio_venta()
        
      modificar_saldo(precio_venta)
    end
    
    def to_s
      "\tJugador {Nombre: #{@nombre}\t Saldo: #{@saldo}\t Capital: #{obtener_capital}\t Encarcelado: #{@encarcelado}\t Carta Libertad: "+ (@carta_libertad == nil ? "No tiene Carta Libertad" : " Tiene Carta Libertad") + "\t Casilla actual: " + (@casilla_actual == nil ? "No esta en ninguna casilla" : "#{@casilla_actual.numero_casilla}") +"\t Propiedades: " + (@propiedades.size < 0 ? "No tiene propiedades" : "Tiene propiedades") + "}"
    end
    
    #CompareTo
    def <=> (otro_jugador)
      otro_capital = otro_jugador.obtener_capital()
      mi_capital = obtener_capital()
      
      valor = 0
      
      if(mi_capital > otro_capital)
        valor = -1
      end
      if (mi_capital < otro_capital)
        valor = 1
      end
      
      valor 
      
    end
    
    private :eliminar_de_mis_propiedades, :es_de_mi_propiedad, :tengo_saldo, :valor_propiedades
  end
end
