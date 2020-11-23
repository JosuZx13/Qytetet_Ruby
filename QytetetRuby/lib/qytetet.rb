#encoding :UTF-8

require_relative "calle"
require_relative "casilla"
require_relative "dado"
require_relative "especulador"
require_relative "estado_juego"
require_relative "jugador"
require_relative "metodo_salir_carcel"
require_relative "otra_casilla"
require_relative "sorpresa"
require_relative "tablero"
require_relative "tipo_casilla"
require_relative "tipo_sorpresa"
require_relative "titulo_propiedad"

require "singleton"

module ModeloQytetet
  class Qytetet
    include Singleton
    
    #attr_reader, consultores
    attr_reader :mazo
    attr_reader :tablero
    attr_reader :jugador_actual
    attr_accessor :carta_actual
    attr_reader :jugadores
    attr_reader :dado
    attr_reader :qytetet
    attr_accessor :estado
    attr_reader :NUM_CASILLAS
    
    #Atributos estáticos
    @@MAX_JUGADORES = 4
    @@MIN_JUGADORES = 2 #propio
    @@NUM_SORPRESAS = 10
    @@NUM_CASILLAS = 20
    @@PRECIO_LIBERTAD = 200
    @@SALDO_SALIDA = 1000
    
    
    def initialize
      @dado = Dado.instance
      @carta_actual = nil
      @jugador_actual = nil
      @estado = EstadoJuego::JA_PREPARADO
      @jugadores = Array.new
    end
    
    
    #Metodos
    
    def valor_dado
      @dado.valor
    end
    
    def actuar_si_en_casilla_edificable()
      debo = @jugador_actual.debo_pagar_alquiler()

      if(debo)
        @jugador_actual.pagar_alquiler()

        if(@jugador_actual.saldo <= 0)
          @estado = EstadoJuego::ALGUNJUGADORENBANCAROTA
        end
      end

      posicion = obtener_casilla_jugador_actual()

      tengo = posicion.tengo_propietario()

      if( @estado != EstadoJuego::ALGUNJUGADORENBANCAROTA)
        if(tengo)
          @estado = EstadoJuego::JA_PUEDEGESTIONAR
        else
          @estado = EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
          end
      end
    end
    
    def actuar_si_en_casilla_no_edificable()
      @estado = EstadoJuego::JA_PUEDEGESTIONAR
      casilla = @jugador_actual.casilla_actual
        
      if(casilla.tipo == TipoCasilla::IMPUESTO)
        @jugador_actual.pagar_impuesto()
        
      else
        if(casilla.tipo == TipoCasilla::JUEZ)
          encarcelar_jugador()
        else
          if(casilla.tipo == TipoCasilla::SORPRESA)
            @carta_actual = @mazo.at(0)
            @mazo.delete_at(0)
            @estado = EstadoJuego::JA_CONSORPRESA
          end
        end
      end
    end
    
    def aplicar_sorpresa()
      @estado = EstadoJuego::JA_PUEDEGESTIONAR
      
      if(@carta_actual.tipo == TipoSorpresa::SALIRCARCEL)
        @jugador_actual.carta_libertad = @carta_actual
      
      else
        @mazo << @carta_actual
        
        case @carta_actual.tipo
          
          when TipoSorpresa::PAGARCOBRAR
            @jugador_actual.modificar_saldo(@carta_actual.valor)

            if(@jugador_actual.saldo <= 0)
              @estado = EstadoJuego::ALGUNJUGADORENBANCAROTA
            end

          when TipoSorpresa::IRACASILLA
            valor = @carta_actual.valor

            casilla_carcel = @tablero.es_casilla_carcel(valor)

            if(casilla_carcel)
              encarcelar_jugador()
            else
              @jugador_actual.casilla_actual = @tablero.obtener_casilla_numero(valor)
            end
            
          when TipoSorpresa::PORCASAHOTEL
            cantidad = @carta_actual.valor
            numero_total = @jugador_actual.cuantas_casas_hoteles_tengo()

            @jugador_actual.modificar_saldo(cantidad*numero_total)

            if(@jugador_actual.saldo() <= 0)
              @estado = EstadoJuego::ALGUNJUGADORENBANCAROTA
            end

          when TipoSorpresa::PORJUGADOR
            for jug in @jugadores do
                  
              if(jug != @jugadorActual)
                jug.modificar_saldo(@carta_actual.valor)

                if(jug.saldo <= 0)
                  @estado = EstadoJuego::ALGUNJUGADORENBANCAROTA
                end
              end

              @jugador_actual.modificar_saldo(-@carta_actual.valor)
              if(@jugador_actual.saldo <= 0)
                @estado = EstadoJuego::ALGUNJUGADORENBANCAROTA
              end

            end
            
          when TipoSorpresa::CONVERTIRME
            espec = @jugador_actual.convertirme(@carta_actual.valor())                    
            pos = 0;
            
            while( @jugador_actual != @jugadores.at(pos))
              pos=pos+1
            
            end

            #Intercambia el objeto que haya en dicha posición por otro objeto pasado
            @jugadores[pos] = espec
            
            @jugador_actual = espec
        end
      end
    end
    
    def cancelar_hipoteca(numero_casilla)
      cancelada = false
        
      cas = @tablero.obtener_casilla_numero(numero_casilla)
      tit = cas.titulo
      cancelada = @jugador_actual.cancelar_hipoteca(tit);
        
      @estado = EstadoJuego::JA_PUEDEGESTIONAR
        
      cancelada;
    end
    
    def comprar_titulo_propiedad()
      comprado = @jugador_actual.comprar_titulo_propiedad()
        
      if(comprado)
        @estado = EstadoJuego::JA_PUEDEGESTIONAR
      end
        
      comprado;
    end
    
    def edificar_casa(numero_casilla)
      edificada = false
        
      cas = @tablero.obtener_casilla_numero(numero_casilla)
        
      titulo = cas.titulo;
        
      edificada = @jugador_actual.edificar_casa(titulo)
        
      if(edificada)
        @estado = EstadoJuego::JA_PUEDEGESTIONAR
      end
        
      edificada
    end
    
    def edificar_hotel(numero_casilla)
      edificado = false
        
      cas = @tablero.obtener_casilla_numero(numero_casilla)
        
      titulo = cas.titulo
        
      edificado = @jugador_actual.edificar_hotel(titulo)
        
      if(edificado)
        @estado = EstadoJuego::JA_PUEDEGESTIONAR
      end
        
      edificado;
    end
    
    def encarcelar_jugador()
      if(@jugador_actual.debo_ir_a_carcel)
        cas_carcel = @tablero.carcel
        @jugador_actual.ir_a_carcel(cas_carcel)
        
        @estado = EstadoJuego::JA_ENCARCELADO
      else
        carta = @jugador_actual.devolver_carta_libertad()
        @mazo << carta
            
        @estado = EstadoJuego::JA_PUEDEGESTIONAR
      end
    end
    
    def hipotecar_propiedad(numero_casilla)
      cas = @tablero.obtener_casilla_numero(numero_casilla)
      tit = cas.titulo
        
      @jugador_actual.hipotecar_propiedad(tit)
    end
    
    def intentar_salir_carcel(metodo)
      encarcelado = false
        
      if(metodo == MetodoSalirCarcel::TIRANDODADO)
        resultado = tirar_dado()
        
        if(resultado >= 5)
          @jugador_actual.encarcelado = false
        end
        
      else
        @jugador_actual.pagar_libertad(@@PRECIO_LIBERTAD)
      end
        
      encarcelado = @jugador_actual.encarcelado
        
      if(encarcelado)
        @estado = EstadoJuego::JA_ENCARCELADO
      else
        @estado = EstadoJuego::JA_PREPARADO
      end
        
      encarcelado;
    end
    
    def jugar()
      valor = tirar_dado()
      mov = @tablero.obtener_casilla_final(@jugador_actual.casilla_actual, valor);
      mover(mov.numero_casilla);
    end
    
    def mover(num_casilla_destino)
=begin  
      if @jugador_actual.encarcelado
        puts "##############################"
        puts "Estoy en la carcel\n"

        puts "Opciones de salida"
        puts "1.- Tirar Dado y que salga 5"
        puts "2.- Pagando el precio #{@@PRECIO_LIBERTAD}"

        o = gets.to_i
        while (o != 1 && o != 2)
          puts "(Las opciones solo son 1 ó 2)"
          o = gets.chomp
        end

        if( o == 1)
          puts "Has elegido Tirando dado"
          puts "##############################"
          intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
        else
          puts "Has elegido Pagando"
          puts "##############################"
          intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
        end
        
      end
      
      if !@jugador_actual.encarcelado
=end
        c_inicial = @jugador_actual.casilla_actual
        c_final = @tablero.casillas.at(num_casilla_destino)

        @jugador_actual.casilla_actual = c_final
        if(c_final.numero_casilla < c_inicial.numero_casilla)
          @jugador_actual.modificar_saldo(@@SALDO_SALIDA)
        end

        if(c_final.soy_edificable())
          actuar_si_en_casilla_edificable()
        else
          actuar_si_en_casilla_no_edificable()
        end

      #end
      
    end
    
    def obtener_casilla_jugador_actual()
      @jugador_actual.casilla_actual
    end
    
    def obtener_propiedades_jugador()
      num_casillas = Array.new
      prop = @jugador_actual.propiedades

      #Para cada casilla, se comprueba cual es del propietario
      for tc in @tablero.casillas
        for p in prop
          if(tc.titulo_propiedad == p)
            num_casillas << tc.numero_casilla
          end
        end
      end

      num_casillas;
    end
    
    def obtener_propiedades_jugador_segun_estado_hipoteca(estado_hipoteca)
        num_casillas = Array.new
        prop = @jugador_actual.obtener_propiedades(estado_hipoteca);
        
        #Para cada casilla, se comprueba cual es del propietario
        for tc in @tablero.casillas
          for p in prop
            if(tc.titulo == p)
                num_casillas << tc.numero_casilla
            end
          end
        end
        
        num_casillas;
    end
    
    def obtener_ranking()
      @jugadores = @jugadores.sort
      @estado = EstadoJuego::RANKINGOBTENIDO
    end
    
    #PROPIO
    def mostrar_ranking()
      puntuacion = ""
      index = 1
      for jug_puntuado in @jugadores
        
        puntuacion = puntuacion + "\t#{index}.- #{jug_puntuado.nombre}\t\tCapital: #{jug_puntuado.obtener_capital}\n"
        index = index+1
      end
      
      puntuacion
      
    end
    
    def obtener_saldo_jugador_actual()
      @jugador_actual.saldo
    end
    
    def salida_jugadores()
      
      for j in @jugadores
          j.casilla_actual = @tablero.obtener_casilla_numero(0)
      end

      #Un numero aleatorio entre 1 y el numero de jugadores
      primero = rand(@jugadores.size)

      @jugador_actual = @jugadores.at(primero)
      
    end
    
    def siguiente_jugador()
      pos = 0;
      
      for j in @jugadores
        if (@jugador_actual == j)
          break
        end
        pos = pos + 1
      end
      
      @jugador_actual = @jugadores.at( ( (pos + 1) % @jugadores.length ) )
      
      if(@jugador_actual.encarcelado)
            @estado = EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
      else
            @estado = EstadoJuego::JA_PREPARADO
      end

    end
    
    def tirar_dado()
      @dado.tirar
    end
    
    def vender_propiedad(numero_casilla)
      cas = @tablero.obtener_casilla_numero(numero_casilla);
        
      @jugador_actual.vender_propiedad(cas);
    end
    
    def inicializar_cartas_sorpresa
      @mazo = Array.new
      @mazo << Sorpresa.new("IrACasilla", TipoSorpresa::IRACASILLA, 7)        
      @mazo << Sorpresa.new("IrACarcel", TipoSorpresa::IRACASILLA, @tablero.carcel.numero_casilla)
      @mazo << Sorpresa.new("SalirDeCarcel", TipoSorpresa::SALIRCARCEL, 0)
      @mazo << Sorpresa.new("IrACasilla", TipoSorpresa::IRACASILLA, 19)
      @mazo << Sorpresa.new("PagarCobrar", TipoSorpresa::PAGARCOBRAR, 450)
      @mazo << Sorpresa.new("PagarCobrar", TipoSorpresa::PAGARCOBRAR, -300)
      @mazo << Sorpresa.new("PorJugador", TipoSorpresa::PORJUGADOR, 100)
      @mazo << Sorpresa.new("PorJugador", TipoSorpresa::PORJUGADOR, -130)
      @mazo << Sorpresa.new("PorCasaHotel", TipoSorpresa::PORCASAHOTEL, -40)
      @mazo << Sorpresa.new("PorCasaHotel", TipoSorpresa::PORCASAHOTEL, 35)
      @mazo << Sorpresa.new("Conversión", TipoSorpresa::CONVERTIRME, 3000)
      @mazo << Sorpresa.new("Conversión", TipoSorpresa::CONVERTIRME, 5000)
      
      #Ordena de forma aleatoria
      @mazo = @mazo.shuffle!
      
    end
    
    def inicializar_tablero()
        #instancia del atributo
        @tablero = Tablero.new
    end
    
    #length devuelve el tamaño
    def inicializar_jugadores(nombres)
      if nombres.length < @@MIN_JUGADORES || nombres.length > @@MAX_JUGADORES
            raise "Número de jugadores inválido. Mínimo #{@@MIN_JUGADORES} Máximo #{@@MAX_JUGADORES}"
      end
      
      @jugadores = Array.new
      
      nombres.each do |n|
        @jugadores << Jugador.new(n)
      end

    end
    
    #Metodo propio
    def mostrar_jugadores()
        
      datos = "\n";
      
      for jug_info in @jugadores
        datos = datos + "\t" + jug_info.to_s + "\n";
      end
      
      datos
    end
    
    def inicializar_juego(nombres)
      inicializar_jugadores(nombres)
      inicializar_tablero()
      inicializar_cartas_sorpresa()
      salida_jugadores()    
    end
    
    def to_s
      
      puts "\n\nMAZO"
      
      for carta in @mazo
        puts carta.to_s
      end
      
      puts "\n\nTABLERO"
      puts @tablero.to_s
      
      puts "\n\nJUGADORES"
      
      for jugador in @jugadores
        puts jugador.to_s
      end    
      puts "\n\n"
    end
    
    private :encarcelar_jugador, :salida_jugadores, :inicializar_tablero, :inicializar_jugadores
    
  end
end