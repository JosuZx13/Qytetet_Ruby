#encoding :UTF-8

module ControladorQytetet
  
  #Para extraer la posicion del elemento en el Array OpcionMenu.index(:JUGAR)
  #Para convertir un entero a string, basta con hacer to_s
  #Para devolver un valor basta con usar OpcionMenu.at(numero)
  OpcionMenu = [
    :INICIARJUEGO,
    :JUGAR,
    :APLICARSORPRESA,
    :INTENTARSALIRCARCELPAGANDOLIBERTAD,
    :INTENTARSALIRCARCELTIRANDODADO,
    :COMPRARTITULOPROPIEDAD,
    :HIPOTECARPROPIEDAD,
    :CANCELARHIPOTECA,
    :EDIFICARCASA,
    :EDIFICARHOTEL,
    :VENDERPROPIEDAD,
    :PASARTURNO,
    :OBTENERRANKING,
    :TERMINARJUEGO,
    :MOSTRARJUGADORACTUAL,
    :MOSTRARJUGADORES,
    :MOSTRARTABLERO
  ]
  
end