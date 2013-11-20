require "./lib/racionales.rb"
require "./lib/matriz.rb"
require "./lib/matriz_dispersa.rb"

class Matriz_densa < Matriz
  attr_reader :fil, :col, :mat
  
  def initialize (m,n)
    raise TypeError, "Error. Tipo de dimensiones incorrectas" if ((m < 0) or (n < 0))
    @fil, @col = m, n
    @mat = Array.new(@fil) {Array.new(@col)}
  end
  
  def to_s
    for i in (0...self.fil)
      print "("
      for j in (0...self.col)
	print " #{self.mat[i][j]}\t"
      end
      puts ")\n"
    end
    puts "\n"
  end
  
  def generar (o)
    if (o==1)
      @mat = Array.new(@fil) {Array.new(@col) {rand(-10..10)}}
    elsif (o==2)
      for i in (0...self.fil)
	for j in (0...self.col)
	  self.mat[i][j]=NumerosRacionales.new(rand(-10..10),rand(1..10))
	end
      end
    end
  end
  
  def llenar (other)
    if other.is_a?(Array)
      for i in (0...self.fil)
	for j in (0...self.col)
	  self.mat[i][j] = other[i][j]
	end
      end
    end
  end
  
  def introducir_datos (o)
    puts "Rellene la matriz..."
    if (o==1)
      for i in (0...self.fil)
	for j in (0...self.col)
	  puts "casilla (#{i},#{j}): "
	  STDOUT.flush
	  dato=gets.chomp
	  self.mat[i][j]= dato.to_i
	end
      end      
    elsif
      for i in (0...self.fil)
	for j in (0...self.col)
	  puts "casilla (#{i},#{j}): "
	  puts "numerador: "
	  STDOUT.flush
	  num=gets.chomp
	  puts "denominador: "
	  STDOUT.flush
	  den=gets.chomp
	  self.mat[i][j]=NumerosRacionales.new(num.to_i,den.to_i)
	end
      end
    end
  end
  
  def coerce (other)
    if (other.is_a?(Matriz_dispersa))
      a=Matriz_densa.new(other.fil,other.col)
      for i in (0...a.fil)
	for j in (0...a.col)
	  a.mat[i][j]=0
	end
      end
      for i in (0...other.pos.size)
	a.mat[other.pos[i][0]][other.pos[i][1]]= other.dato[i]
      end
      return [a,self]
    end
  end
  
  def t #traspuesta de una matriz
    nueva = Matriz_densa.new(self.col,self.fil)
    for i in (0...nueva.fil)
      for j in (0...nueva.col)
	nueva.mat[i][j] = self.mat[j][i]
      end
    end
    nueva
  end
  
  def ==(other)
    raise unless other.is_a?(Matriz)
    if (other.is_a?(Matriz_dispersa))
      other=self.coerce(other)
      other=other[0]
    end
    if (self.fil == other.fil) and (self.col == other.col)
      for i in (0...other.fil)
	for j in (0...other.col)
	  if self.mat[i][j] != other.mat[i][j]
	    return false
	  end
	end
      end
      true
    end #if
  end
  
  def +(other)
    raise unless other.is_a?(Matriz)
    if (other.is_a?(Matriz_dispersa))
      other=self.coerce(other)
      other=other[0]
    end
    if (self.fil == other.fil) and (self.col == other.col)
      nueva = Matriz_densa.new(self.fil,self.col)
      for i in (0...self.fil)
	for j in (0...self.col)
	  nueva.mat[i][j]= self.mat[i][j] + other.mat[i][j]
	end
      end
      nueva
    else
      puts "Error. No se pueden sumar matrices de distintas dimensiones."
    end
  end

  def -(other)
    raise unless other.is_a?(Matriz)
    if (other.is_a?(Matriz_dispersa))
      other=self.coerce(other)
      other=other[0]
    end
    if (self.fil == other.fil) and (self.col == other.col)
      nueva = Matriz_densa.new(self.fil,self.col)
      for i in (0...self.fil)
	for j in (0...self.col)
	  nueva.mat[i][j] = self.mat[i][j] - other.mat[i][j]
	end
      end
      nueva
    else
      puts "Error. No se pueden restar matrices de distintas dimensiones."
    end
  end


  def *(other) #multiplicacion: segun other -> x escalar o x otra matriz
    nueva = Matriz_densa.new(self.fil,self.col)
    if other.is_a?(Numeric)
      if (self.mat[0][0]).is_a?(NumerosRacionales)
	n=NumerosRacionales.new(other,1)
      else
	n=other
      end
      for i in (0...self.fil)
	for j in (0...self.col)
	  nueva.mat[i][j] = n*self.mat[i][j]
	end
      end
    end
    nueva
  end
  
end