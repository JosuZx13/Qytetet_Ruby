#encoding :UTF-8

module ModeloQytetet
  class Sorpresa
    attr_reader :texto, :tipo, :valor
    
    def initialize (t, tp, v)
      @texto = t
      @tipo = tp
      @valor = v
    end

    def to_s
      "\tSorpresa {Texto: #{@texto}\t Tipo: #{@tipo}\t Valor: #{@valor}}"
    end
    
  end
end

