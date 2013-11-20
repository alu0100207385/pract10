
class Matriz
  attr_reader :fil, :col
  
  def initialize (m,n)
    raise TypeError, "Error. Tipo de dimensiones incorrectas" if ((m < 0) or (n < 0))
    @fil, @col = m, n
  end
  
  def to_s
  end
  
  def introducir_datos (o)
  end
  
  def generar
  end
  
  def +(other)
  end
  
  def -(other)
  end

  def *(other)
  end
  
  def t
  end
  
  def det
  end
  
  def ==(other)
  end

end