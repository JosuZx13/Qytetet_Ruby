#encoding :UTF-8

module ModeloQytetet
  class TituloPropiedad
    #attr_reader es consultores
    attr_reader :nombre, :precio_compra, :alquiler_base, :factor_revalorizacion, :hipoteca_base, :precio_edificar, :num_hoteles, :num_casas
    #Con attr_accessor se permite la consulta y modificacion del atributo
    #Basta con usar titulo.hipotecada = false, o titulo.hipotecada para que haga un retorno
    attr_accessor :hipotecada,:calle, :propietario 
    
    def initialize(nom, pr_com, alq_base, fact_reval, hipot_base, prec_edificar)
      @nombre = nom
      @hipotecada = false
      @precio_compra = pr_com
      @alquiler_base = alq_base
      @factor_revalorizacion = fact_reval
      @hipoteca_base = hipot_base
      @precio_edificar = prec_edificar
      @num_hoteles = 0
      @num_casas = 0
      @calle = nil
      @propietario = nil
      
    end
    
    def calcular_coste_cancelar()
      coste_anular = 0;
      coste_calculado = calcular_coste_hipotecar()
      coste_anular = (coste_calculado * 0.10)
        
      coste_anular
    end
    
    def calcular_coste_hipotecar()
      coste_hipotecar = 0
      coste_hipotecar = (@hipoteca_base + (@num_casas*0.5*@hipoteca_base) + (@num_hoteles*@hipoteca_base) )
        
      coste_hipotecar
    end
    
    def calcular_importe_alquiler()
      importe = 0
      importe = ( @alquiler_base + (@num_casas*0.5 + @num_hoteles*2) )
        
      importe
    end
    
    def calcular_precio_venta()
      precio_venta = 0
      precio_venta = (@precio_compra + ( ( (@num_casas + @num_hoteles)*@precio_edificar) * @factor_revalorizacion) )
                
      precio_venta
    end
    
    def cancelar_hipoteca()
      @hipotecada = false
    end
    
    def edificar_casa()
      @num_casas = @num_casas + 1
    end
    
    def edificar_hotel()
      @num_hoteles = @num_hoteles + 1
      @num_casas = 0
    end

    def hipotecar()
      @hipotecada = true
      coste_hipoteca = calcular_coste_hipotecar()
      
      coste_hipoteca
    end
    
    def pagar_alquiler()
      coste_alquiler = calcular_importe_alquiler()
      @propietario.modificar_saldo(coste_alquiler)
        
      coste_alquiler
    end
    
    def propietario_encarcelado()
      @propietario.encarcelado
    end
    
    def tengo_propietario()
      if(@propietario != nil)
        true
      else
        false
      end
    end

    def to_s
      "Titulo Propiedad {Nombre: #{@nombre}\t Hipotecada: #{@hipotecada}\t Precio Compra: #{@precio_compra}\t Alquiler Base: #{@alquiler_base}\t Factor Revalorización: #{@factor_revalorizacion}\t Hipoteca Base: #{@hipoteca_base}\t Precio Edificar: #{@precio_edificar}\t Numero Casas: #{@num_casas}\t Numero Hoteles: #{@num_hoteles}\t Propietario: " + (@propietario == nil ? "No tiene propietario" : @propietario.nombre) +"}"    
    end
  
  end

end

