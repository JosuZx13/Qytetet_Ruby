#encoding :UTF-8


require_relative "controlador_qytetet"
require_relative "opcion_menu"
require_relative "qytetet"

module VistaTextualQytetet
  
  class VistaTextualQytetet
    
    @@controlador = nil
    @@modelo = nil
    @@vista = nil
    
    def initialize
      @@controlador = ControladorQytetet::ControladorQytetet.instance
      @@modelo = ModeloQytetet::Qytetet.instance
    end
    
    #Metodo propio auxiliar, private
    #Convierte un array de integer a array de string
    def parser_array_int_string(array_elegibles)
      validas_texto = Array.new
      
      for e in array_elegibles
        validas_texto << e.to_s
      end
      
      validas_texto
      
    end
    
    def obtener_nombre_jugadores() 
      nom = Array.new
      
      n = ""

      i = 1;
      until n == "ok" || i>4
        puts "Nombre del jugador #{i}"
        n = gets.chomp
        
        if(n != "ok")
          nom << n
          i=i+1
        end
        
      end
      
=begin
      nom << "A-Player"
      nom << "B-Player"
      nom << "C-Player"
      nom << "D-Player"
=end      
      nom
      
    end
    
    def elegir_casilla(opcion_menu)
      
      casilla_retornada = 0
      
      validas = @@controlador.obtener_casillas_validas(opcion_menu)
      
      if(validas.size == 0)
      
        casilla_retornada =  -1
      
      else
        
        puts "CASILLAS VALIDAS\n\t"
        
        for v in validas
          puts "\tCasilla #{v} "
        end
        
        validas_texto = Array.new
        validas_texto = parser_array_int_string(validas)

        c = leer_valor_correcto(validas_texto)

        casilla_retornada = c.to_i
      end    
      
      casilla_retornada
    end
    
    #recibe un array de valores string
    def leer_valor_correcto(valores_correctos)
      
      lectura = ""
      elegida = false
      
      while !elegida
        lectura = gets.chomp
        
        for va in valores_correctos
          if va == lectura
            elegida = true
          end
        end
        
        if !elegida
          puts "Opcion incorrecta, vuelve a elegirla"
        end
        
      end
      
      lectura
      
    end
    
    def elegir_operacion()
      #array de integer
      validas = @@controlador.obtener_operaciones_juego_validas
      
      #Uso de un método propio
      #Array de string
      validas_texto = parser_array_int_string(validas)
      
      puts "\nOPCIONES POSIBLES"
      for f in validas
        puts "#{f} .- #{ControladorQytetet::OpcionMenu.at(f)}\n"
      end
      puts ""
        
      resultado = leer_valor_correcto(validas_texto)
      res = resultado.to_i
      
      res
      
    end
    
    def VistaTextualQytetet.main
      
      puts "\t\t\t\tQYTETET"
      puts "\t\tMODO DE JUEGO --> VISTA TEXTUAL\n"
      
      @@vista = VistaTextualQytetet.new
      
      operacion_elegida = -1 #int
      casilla_elegida = -1 #int
      debe_elegir_casilla = false #boolean

      @@controlador.nombre_jugadores = @@vista.obtener_nombre_jugadores()

      until operacion_elegida == ControladorQytetet::OpcionMenu.index(:TERMINARJUEGO)
        
        operacion_elegida = @@vista.elegir_operacion()
        
        debe_elegir_casilla = @@controlador.necesita_elegir_casilla(operacion_elegida)
        
        if(debe_elegir_casilla)
          casilla_elegida = @@vista.elegir_casilla(operacion_elegida)          
        end
        
        muestra_textual = @@controlador.realizar_operacion(operacion_elegida, casilla_elegida)
        
        puts muestra_textual
        
      end
      
    end
    
  end
  
  VistaTextualQytetet.main
  
end
