require "./lib/racionales.rb"
require "./lib/matriz.rb"
require "./lib/matriz_densa.rb"

class Matriz_dispersa < Matriz
  attr_reader :fil, :col, :pos, :dato
  
  def initialize (m,n)
    raise TypeError, "Error. Tipo de dimensiones incorrectas" if ((m < 0) or (n < 0))
    @fil, @col = m, n
    @pos = Array.new(0){}
    @dato = Array.new(0){}
  end

  #posiciones y datos tienen que tener la misma dim y datos no puede contener ceros
  def llenar (posciones,datos)
    for i in (0...posciones.size)
      @pos << posciones[i]
      @dato << datos[i]
    end
  end
  
  def to_s
    for i in (0...self.fil)
      print "("
      for j in (0...self.col)
	b = buscar(i,j)
	if (b != -1)
	  print " #{self.dato[b]}\t"
	else
	  print " 0\t"
	end
      end
      puts ")\n"
    end
    puts "\n"
  end
end

  def coerce(other)
    #comprobar q other es densa
    a=Matriz_dispersa.new(other.fil,other.col)
    for i in (0...other.fil)
      for j in (0...other.col)
	if (other.mat[i][j] != 0)
	  a.pos << [i,j]
	  a.dato << other.mat[i][j]
	end
      end
    end
    return[a,self]
  end
  
  def ==(other)
    raise unless other.is_a?(Matriz) #deben ser matrices, da = si se comparan densas con dispersas
    if (other.is_a?(Matriz_densa))
      other=self.coerce(other)
      other=other[0]
    end
    if (@fil == other.fil) and (@col == other.col)
      if (@pos.size == 0) #si ambos estan estan vacios...
	return true
      elsif
	for i in (0...@pos.size)
	  k = other.buscar(@pos[i][0],@pos[i][1])
	  if ( k!= -1) #existe esa pos
	    if (@dato[i] == other.dato[k])
	      return true
	    end
	  end
	end #for
# 	false
      end
      false
    end #if
  end
  
  def t #traspuesta
    nueva = Matriz_dispersa.new(@col,@fil)
    for i in (0...@pos.size)
      nueva.pos << [@pos[i][1],@pos[i][0]]
      nueva.dato << @dato[i]
    end
    nueva
  end

