#encoding :UTF-8

require_relative "estado_juego"
require_relative "metodo_salir_carcel"
require_relative "qytetet"
require_relative "opcion_menu"

require "singleton"

module ControladorQytetet

  class ControladorQytetet
    
    attr_accessor :nombre_jugadores, :controlador, :modelo, :opcion_elegida
    
    include Singleton
    
    @@controlador = nil
    @@modelo = ModeloQytetet::Qytetet.instance
    
    #Propia
    @@obtenido = false #Controla si ha sido obtenido el ranking
    def initialize
      @nombre_jugadores = Array.new
      @opcion_elegida = -1
      
    end
    
    #Devuelve un ArrayList integer
    def obtener_operaciones_juego_validas()
      opciones_validas = Array.new
        
      #Si el juego aun no se ha iniciado
      if(@@modelo.jugadores.size == 0)
          opciones_validas << OpcionMenu.index(:INICIARJUEGO)

      else

        if(@@modelo.estado == ModeloQytetet::EstadoJuego::RANKINGOBTENIDO)
          opciones_validas << OpcionMenu.index(:TERMINARJUEGO)

        else
          #Opciones seguras que se añaden a las validas
          opciones_validas << OpcionMenu.index(:TERMINARJUEGO)
          opciones_validas << OpcionMenu.index(:MOSTRARJUGADORACTUAL)
          opciones_validas << OpcionMenu.index(:MOSTRARJUGADORES)
          opciones_validas << OpcionMenu.index(:MOSTRARTABLERO)
          opciones_validas << OpcionMenu.index(:OBTENERRANKING)

          case @@modelo.estado

            when ModeloQytetet::EstadoJuego::JA_PREPARADO
              opciones_validas << OpcionMenu.index(:JUGAR)

            when ModeloQytetet::EstadoJuego::JA_ENCARCELADO
              opciones_validas << OpcionMenu.index(:PASARTURNO)

            when ModeloQytetet::EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
              opciones_validas << OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD)
              opciones_validas << OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO)

            when ModeloQytetet::EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
              opciones_validas << OpcionMenu.index(:PASARTURNO)
              opciones_validas << OpcionMenu.index(:COMPRARTITULOPROPIEDAD)
              opciones_validas << OpcionMenu.index(:VENDERPROPIEDAD)
              opciones_validas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
              opciones_validas << OpcionMenu.index(:CANCELARHIPOTECA)
              opciones_validas << OpcionMenu.index(:EDIFICARCASA)
              opciones_validas << OpcionMenu.index(:EDIFICARHOTEL)

            when ModeloQytetet::EstadoJuego::JA_PUEDEGESTIONAR
              opciones_validas << OpcionMenu.index(:PASARTURNO)
              opciones_validas << OpcionMenu.index(:VENDERPROPIEDAD)
              opciones_validas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
              opciones_validas << OpcionMenu.index(:CANCELARHIPOTECA)
              opciones_validas << OpcionMenu.index(:EDIFICARCASA)
              opciones_validas << OpcionMenu.index(:EDIFICARHOTEL)                

            when ModeloQytetet::EstadoJuego::JA_CONSORPRESA
              opciones_validas << OpcionMenu.index(:APLICARSORPRESA)

            when ModeloQytetet::EstadoJuego::ALGUNJUGADORENBANCAROTA
              opciones_validas << OpcionMenu.index(:OBTENERRANKING)

          end #En del CASE SWITCH

        end #end del if rankingobtenido

      end #end numero jugadores

      opciones_validas = opciones_validas.sort

      opciones_validas
        
    end
    
    def necesita_elegir_casilla(opc_menu)
        
      de_casillas = Array.new
        
      de_casillas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
      de_casillas << OpcionMenu.index(:CANCELARHIPOTECA)
      de_casillas << OpcionMenu.index(:EDIFICARCASA)
      de_casillas << OpcionMenu.index(:EDIFICARHOTEL)
      de_casillas << OpcionMenu.index(:VENDERPROPIEDAD)
        
      necesario = false
      
      for o in de_casillas
        
        if opc_menu == o
          necesario = true
        end
        
      end
    
      necesario
    
    end
    
    def obtener_casillas_validas(opc_menu)
      casillas_operacion_realizable = Array.new
      
      opc = OpcionMenu.at(opc_menu)
      
      @opcion_elegida = OpcionMenu.index(opc)
      
      case(@opcion_elegida)
        #No se puede vender una propiedad hipotecada
        when OpcionMenu.index(:VENDERPROPIEDAD)
          casillas_operacion_realizable = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
          
        when OpcionMenu.index(:HIPOTECARPROPIEDAD)
          casillas_operacion_realizable = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)

        when OpcionMenu.index(:CANCELARHIPOTECA)
          casillas_operacion_realizable = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true)

        when OpcionMenu.index(:EDIFICARCASA)
          casillas_operacion_realizable = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
          
        when OpcionMenu.index(:EDIFICARHOTEL)
          casillas_operacion_realizable = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
      end
        
      casillas_operacion_realizable
      
    end
    
    def realizar_operacion (opc_elegida, cas_elegida)
        realizar = ""
        
        @opcion_elegida = OpcionMenu.at(opc_elegida)
        
        case (@opcion_elegida)
        
          when :INICIARJUEGO
            realizar = "\n\t\tEL JUEGO HA COMENZADO\n\n"
            @@modelo.inicializar_juego(@nombre_jugadores)

          when :APLICARSORPRESA
            realizar = "\nCarta Sorpresa aplicada:\n"
            realizar = realizar + "\t" + @@modelo.carta_actual.to_s + "\n"

            @@modelo.aplicar_sorpresa

          when :CANCELARHIPOTECA
            
            if cas_elegida == -1
              realizar = "\nNo tienes ninguna propiedad a la que se le pueda cancelar la hipoteca\n"
            else
              realizar = "\nLa propiedad #{cas_elegida} va a cancelar su hipoteca\n"
              @@modelo.cancelar_hipoteca(cas_elegida)
            end
            
          when :COMPRARTITULOPROPIEDAD
            cas = @@modelo.obtener_casilla_jugador_actual()
            cas_elegida = cas.numero_casilla

            if (@@modelo.comprar_titulo_propiedad)
              realizar = "\nLa Propiedad #{cas_elegida} va a ser comprada\n"    
            else
              realizar = "\nLa Propiedad #{cas_elegida} no ha podido comprarse\n"
            end

          when :EDIFICARCASA
            if cas_elegida == -1
              realizar = "\nNo tienes ninguna propiedad en la que construir una casa\n"
            else
              
              if ( @@modelo.edificar_casa(cas_elegida) )
                realizar = "\nEn la Propiedad #{cas_elegida} se construirá una casa\n"
              else
                realizar = "\nNo es posible construir una casa en la Propiedad #{cas_elegida}\n"
              end
              
            end

          when :EDIFICARHOTEL
            if cas_elegida == -1
              realizar = "\nNo tienes ninguna propiedad en la que construir un hotel\n"
            else
              
              if( @@modelo.edificar_hotel(cas_elegida) )
                realizar = "\nEn la Propiedad #{cas_elegida} se construirá un hotel\n"
              else
                realizar = "\No es posible contruir un hotel en la Propiedad #{cas_elegida}"
              end
              
            end

          when :HIPOTECARPROPIEDAD
            if cas_elegida == -1
              realizar = "\nNo tienes ninguna propiedad que se pueda hipotecar\n"
            else
              realizar = "\nLa Propiedad #{cas_elegida} pasará a hipotecarse\n"
              @@modelo.hipotecar_propiedad(cas_elegida)
            end

          when :INTENTARSALIRCARCELPAGANDOLIBERTAD
            realizar = "\nEl Jugador #{@@modelo.jugador_actual.nombre} saldrá de la carcel pagando la libertad\n"
            @@modelo.intentar_salir_carcel(ModeloQytetet::MetodoSalirCarcel::PAGANDOLIBERTAD)

          when :INTENTARSALIRCARCELTIRANDODADO
            realizar = "\nEl Jugador #{@@modelo.jugador_actual.nombre} intentará salir de la cárcel tirando el dado\n"
            @@modelo.intentar_salir_carcel(ModeloQytetet::MetodoSalirCarcel::TIRANDODADO)
            
            if(@@modelo.jugador_actual.encarcelado)
              realizar = realizar + "\n\tNo tuvo suerte en salir de la carcel. Valor del dado: #{@@modelo.valor_dado}\n"
            else
              realizar = realizar + "\n\tLa suerte ha sonreido y de la carcel ha salido. Valor del dado: #{@@modelo.valor_dado}\n"
            end

          when :JUGAR
            realizar = "\nEl jugador " + @@modelo.jugador_actual.nombre + " se dispone a jugar su turno\n"
            cas = @@modelo.obtener_casilla_jugador_actual
            realizar = realizar + "\n\tCasilla Actual del jugador #{cas.numero_casilla}\n"
            @@modelo.jugar()
            cas = @@modelo.obtener_casilla_jugador_actual
            realizar = realizar + "\tAl lanzar el dado ha salido #{@@modelo.dado.valor} y ha avanzado hasta la casilla #{cas.numero_casilla}" 
            
            realizar = realizar + "\n\t " + cas.to_s + "\n"
            
          when :MOSTRARJUGADORACTUAL
            realizar = "\nDatos del jugador actual:\n"
            realizar = realizar + "\t" + @@modelo.jugador_actual.to_s + "\n"
            
          when :MOSTRARJUGADORES
            realizar = "\nDatos de los jugadores:"
            realizar = realizar + @@modelo.mostrar_jugadores

          when :MOSTRARTABLERO
            realizar = "\nTablero\n"
            realizar = realizar + @@modelo.tablero.to_s

          when :OBTENERRANKING
            realizar = "\nRecopilando información para establecer un ranking...\n"
            @@modelo.obtener_ranking
            @@obtenido = true
            
            realizar = realizar + "\n\t\tRESULTADO DE LA PARTIDA\n"
            realizar = realizar + @@modelo.mostrar_ranking
            
          when :PASARTURNO
            realizar = "\nEl jugador #{@@modelo.jugador_actual.nombre} ha finalizado su turno\n"
            @@modelo.siguiente_jugador
            realizar = realizar + "\nTurno del jugador #{@@modelo.jugador_actual.nombre}\n"
          when :TERMINARJUEGO

            if(@@obtenido)
              realizar = "\n\t\tEL JUEGO HA FINALIZADO\n"
              
            else
              realizar = "\n\t\tEL JUEGO HA FINALIZADO\n"
              @@modelo.obtener_ranking
              realizar = realizar + "\n\tRESULTADO DE LA PARTIDA\n"
              realizar = realizar + @@modelo.mostrar_ranking
            end
            
          when :VENDERPROPIEDAD
            
            if cas_elegida == -1
              realizar = "\nNo tienes ninguna propiedad que se pueda vender\n"
            else
              realizar = "\nLa Propiedad #{cas_elegida} va a ser vendida\n";
              @@modelo.vender_propiedad(cas_elegida)
            end
            
        end
        
        realizar
    end
    
    private :initialize
  
  end
end
