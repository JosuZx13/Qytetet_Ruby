#encoding :UTF-8

require_relative "calle"
require_relative "casilla"
require_relative "dado"
require_relative "jugador"
require_relative "metodo_salir_carcel"
require_relative "qytetet"
require_relative "sorpresa"
require_relative "tablero"
require_relative "tipo_casilla"
require_relative "tipo_sorpresa"
require_relative "titulo_propiedad"


module ModeloQytetet
  class PruebaQytetet
    
    #Hace uso de constructor para un singleton
    @@juego = Qytetet.instance
    
    def principal
      
      nom = Array.new
=begin
      n = ""

      i = 1;
      until n == "ok" || i>4
        puts "Nombre del jugador #{i}"
        n = gets.chomp
        i=i+1
        
        nom << n
      end
=end
      nom << "A-Player"
      nom << "B-Player"
      nom << "C-Player"
      nom << "D-Player"
      
      @@juego.inicializar_juego(nom)
      
      @@juego.to_s

=begin     
      puts "\n\n"

      for d in 1..6 do
        @@juego.dado.tirar
        puts @@juego.dado.to_s
      end
=end  
      puts"\t\t#################################################"
      puts "\t\t#\tPRUEBA DE LOS METODOS CREADOS\t\t#\n"
      
      puts "\nEl jugador actual es " + @@juego.jugador_actual.nombre
      
      puts "\n" +@@juego.jugador_actual.nombre + " está en la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "\tEl saldo del jugador "+@@juego.jugador_actual.nombre+ " es #{@@juego.jugador_actual.saldo}\n\n"
      
      
      
=begin
      @@juego.siguiente_jugador
      
      puts "El siguiente jugador actual es #{@@juego.jugador_actual.nombre}"
      
      @@juego.siguiente_jugador
      
      puts "El siguiente jugador actual es #{@@juego.jugador_actual.nombre}"
      
      @@juego.siguiente_jugador
      
      puts "El siguiente jugador actual es #{@@juego.jugador_actual.nombre}"
      
      
      @@juego.siguiente_jugador
=end      
      
=begin      
      @@juego.carta_actual = Sorpresa.new("Vas a la carcel", TipoSorpresa::IRACASILLA, @@juego.tablero.carcel.numero_casilla) 
      
      @@juego.aplicar_sorpresa
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      
      if @@juego.jugador_actual.encarcelado
        puts "Está en la carcel"
      end
=end      
      #@@juego.jugar

=begin
      @@juego.mover(16)
      
      if @@juego.jugador_actual.encarcelado
        puts "Estoy la carcel por jugar con Heisenberg"
        puts "En la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      else
         puts "Aun no me han pillado"
         puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      end
      
      puts "El saldo del jugador "+@@juego.jugador_actual.nombre+ " es #{@@juego.jugador_actual.saldo}"
      
      @@juego.mover(3)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      
      puts "El saldo del jugador "+@@juego.jugador_actual.nombre+ " es #{@@juego.jugador_actual.saldo}"
=end
      
=begin    
      salida = "El jugador tiene las propiedades [ "
      for p in @@juego.obtener_propiedades_jugador do
        salida = salida + "#{p} "
      end
      salida = salida + " ]"
      
      puts salida

      @@juego.mover(3)

      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      
      puts "El nombre de la propiedad es " + @@juego.jugador_actual.casilla_actual.titulo.nombre
      
      if @@juego.comprar_titulo_propiedad
        puts "La calle ha sido comprada y su precio era de #{@@juego.jugador_actual.casilla_actual.titulo.precio_compra}"
      end
      
      puts "El saldo del jugador "+@@juego.jugador_actual.nombre+ " es #{@@juego.jugador_actual.saldo}"
      
      salida = "El jugador tiene sin hipotecar propiedades [ "
      for p in @@juego.obtener_propiedades_jugador_segun_estado_hipoteca(false) do
        salida = salida + "#{p} "
      end
      salida = salida + " ]"
      
      puts salida
      
      salida = "El jugador tiene hipotecadas las propiedades [ "
      for p in @@juego.obtener_propiedades_jugador_segun_estado_hipoteca(true) do
        salida = salida + "#{p} "
      end
      salida = salida + " ]"
      
      puts salida
      
      puts "\n\nSe hipoteca la propiedad"
      @@juego.hipotecar_propiedad(3)
      
      puts "El saldo del jugador "+@@juego.jugador_actual.nombre+ " es #{@@juego.jugador_actual.saldo}"
      
      salida = "El jugador tiene sin hipotecar propiedades [ "
      for p in @@juego.obtener_propiedades_jugador_segun_estado_hipoteca(false) do
        salida = salida + "#{p} "
      end
      salida = salida + " ]"
      
      puts salida
      
      salida = "El jugador tiene hipotecadas las propiedades [ "
      for p in @@juego.obtener_propiedades_jugador_segun_estado_hipoteca(true) do
        salida = salida + "#{p} "
      end
      salida = salida + " ]"
      
      puts salida

      puts "Se cancela la hipoteca"
      @@juego.cancelar_hipoteca(3)
      
      puts "El saldo del jugador "+@@juego.jugador_actual.nombre+ " es #{@@juego.jugador_actual.saldo}"
      
      salida = "El jugador tiene sin hipotecar propiedades [ "
      for p in @@juego.obtener_propiedades_jugador_segun_estado_hipoteca(false) do
        salida = salida + "#{p} "
      end
      salida = salida + " ]"
      
      puts salida
      
      salida = "El jugador tiene hipotecadas las propiedades [ "
      for p in @@juego.obtener_propiedades_jugador_segun_estado_hipoteca(true) do
        salida = salida + "#{p} "
      end
      salida = salida + " ]"
      
      puts salida
=end      
      
      
=begin      
      @@juego.mover(18)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
      
      @@juego.mover(3)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
      
=end      

=begin      
      @@juego.mover(3)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
      
      @@juego.comprar_titulo_propiedad
      puts "Compra la propiedad\n"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}\n"
      
      
      @@juego.siguiente_jugador
      
      puts "\n\nEl jugador " + @@juego.jugador_actual.nombre + " está en la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      
      @@juego.mover(3)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}\n"
      
      
      @@juego.siguiente_jugador
      
      puts "\n\nEl jugador " + @@juego.jugador_actual.nombre + " está en la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      
      @@juego.mover(3)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
      
      
      @@juego.siguiente_jugador
      
      puts "\n\nEl jugador " + @@juego.jugador_actual.nombre + " está en la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      
      @@juego.mover(3)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
      
      @@juego.siguiente_jugador
      
      puts "\n\nEl jugador " + @@juego.jugador_actual.nombre + " está en la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      
      @@juego.mover(3)
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
      
=end      

=begin      
      puts "La primera carta es:"
      puts @@juego.mazo.at(0).to_s
      
      @@juego.mover(6)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
      
      @@juego.aplicar_sorpresa()
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
      
=end      
      
=begin
      @@juego.carta_actual = Sorpresa.new("PORCASAHOTEL", TipoSorpresa::PORCASAHOTEL, -40)
      
      puts @@juego.carta_actual.to_s
      puts "\n"

      Sorpresa.new("IR", TipoSorpresa::IRACASILLA, 7)
      Sorpresa.new("CARCEL", TipoSorpresa::IRACASILLA, @@juego.tablero.carcel.numero_casilla)
      Sorpresa.new("SALIR", TipoSorpresa::SALIRCARCEL, 0)
      Sorpresa.new("IR", TipoSorpresa::IRACASILLA, 19)
      Sorpresa.new("PAGARCOBRAR", TipoSorpresa::PAGARCOBRAR, 450)
      Sorpresa.new("PAGARCOBRAR", TipoSorpresa::PAGARCOBRAR, -300)
      Sorpresa.new("PORJUGADOR", TipoSorpresa::PORJUGADOR, 100)
      Sorpresa.new("PORJUGADOR", TipoSorpresa::PORJUGADOR, -130)
      Sorpresa.new("PORCASAHOTEL", TipoSorpresa::PORCASAHOTEL, -40)
      Sorpresa.new("PORCASAHOTEL", TipoSorpresa::PORCASAHOTEL, 35)

      
      @@juego.mover(3)
      
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
=end
      
=begin para carta CasaHotel
      
      t = @@juego.jugador_actual.casilla_actual.titulo
      puts "Se compra la calle con un precio de: #{t.precio_compra}"
      
      @@juego.comprar_titulo_propiedad
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}\n\n"
      
      
      
      puts "\tSe edifica una casa. Coste: #{t.precio_edificar}"
      @@juego.edificar_casa(3)
     
      puts "\tSe edifica un hotel. Coste: #{t.precio_edificar}"
      @@juego.edificar_hotel(3)
      
      puts "\tSe edifica una casa. Coste: #{t.precio_edificar}"
      @@juego.edificar_casa(3)
     
      puts "\tSe edifica una casa. Coste: #{t.precio_edificar}"
      @@juego.edificar_casa(3)
      
      puts "\tSe edifica una casa. Coste: #{t.precio_edificar}"
      @@juego.edificar_casa(3)
      
      puts "\tSe edifica una casa. Coste: #{t.precio_edificar}"
      @@juego.edificar_casa(3)
     
      puts "\tSe edifica un hotel. Coste: #{t.precio_edificar}"
      @@juego.edificar_hotel(3)
      
      puts "\tSe edifica un hotel. Coste: #{t.precio_edificar}"
      @@juego.edificar_hotel(3)
      
      puts "\tSe edifica un hotel. Coste: #{t.precio_edificar}"
      @@juego.edificar_hotel(3)
      
      puts "\tSe edifica un hotel. Coste: #{t.precio_edificar}"
      @@juego.edificar_hotel(3)
      
      puts "\tSe edifica un hotel. Coste: #{t.precio_edificar}"
      @@juego.edificar_hotel(3)
      
      puts "La Propiedad comprada del jugador " + @@juego.jugador_actual.nombre + " tiene #{t.num_casas} casas"
      
      puts "La Propiedad comprada del jugador " + @@juego.jugador_actual.nombre + " tiene #{t.num_hoteles} hoteles"
      
      
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}\n\n"
      
      @@juego.aplicar_sorpresa
      
      puts "Se aplica la sorpresa"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}\n\n"
=end      
      
=begin Para cartas PorJugador
      for pj in @@juego.jugadores
        puts "El saldo del jugador " + pj.nombre + " es de #{pj.saldo}"
      end
=end
      
=begin para carta Sorpresa Libertad      
      if @@juego.jugador_actual.encarcelado
        puts "\nEl jugador está encarcelado"
      else
        puts "\nNot today"
      end
      
      if @@juego.jugador_actual.carta_libertad != nil
        puts "\nTengo la carta Libertad"
      else
        puts "\nSin salvoconducto"
      end
      
      @@juego.mover(16)
      
      if @@juego.jugador_actual.encarcelado
        puts "Con Heisenberg"
      else
        puts "Haciendo drogas"
      end
      
      @@juego.mover(4)
      
      puts "y " +@@juego.jugador_actual.nombre + " se mueve a la casilla #{@@juego.jugador_actual.casilla_actual.numero_casilla}"
      puts "El saldo del jugador es #{@@juego.jugador_actual.saldo}"
=end      

=begin
      @@juego.obtener_ranking
      
      puts "\n\nRANKING"
      for pjs in @@juego.jugadores do
        puts pjs.to_s
      end
=end   
    end
  end
  
  #PruebaQytetet.main
  
end
