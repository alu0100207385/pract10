require "./lib/racionales.rb"
require "./lib/matriz.rb"
require "./lib/matriz_densa.rb"

class Matriz_dispersa < Matriz
  attr_reader :fil, :col, :pos, :dato
  
  def initialize (m,n)
    raise TypeError, "Error. Tipo de dimensiones incorrectas" if ((m < 0) or (n < 0))
    super
#     @fil, @col = m, n
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
  
  def mi_random #hago esto, pq rand(-10..10) puede generar el valor cero y esto no nos interesa almacenarlo
    if (rand(10) > 4)
      1
    else
      -1
    end
  end
  
  def generar (o)
    if (@fil*@col) == 1
      elementos = 1
    elsif
      elementos =(rand(60..100)*(@fil*@col))/100 #minimo 60% de ceros
    end
    dim= (@fil*@col)-elementos #num de elementos posibles para introducir valores respetando la dispersion
    @pos = Array.new(dim){[rand(0..(@fil-1)),rand(0..(@col-1))]}
    for i in (0...dim)
      if (o==1) #generamos enteros
	@dato = Array.new(dim){mi_random*rand(1..10)}
      elsif (o==2) #generamos racionales
	@dato = Array.new(dim){NumerosRacionales.new(mi_random*rand(1..10),rand(1..10))}
      end
    end
  end  

  def buscar (i,j) #devuelve una posicion del array que coincide con los indices de los param
    aux=[i,j]
    posicion= -1
    k=0
    while (k < @pos.size) and (posicion==-1)
      if (@pos[k]==aux)
	posicion=k
      end
      k=k+1
    end
    posicion
  end


  def introducir_datos (o)
    if (@fil*@col)==1
      max=0
    elsif
      max= (@fil*@col*60)/100
      max = (@fil*@col)-max
    end
    total= -1
    while (total<0) or (total>max)
      puts "Cuantos datos va a introducir? [0-#{max}]"
      STDOUT.flush
      total=gets.chomp
      total=total.to_i
    end
    if (o==1) #de numeros enteros
      for k in (0...total)
	i,j= -1,-1
	while (i<0) or (i>(@fil-1))
	  puts "introduce la coordenada i: "
	  STDOUT.flush
	  i=(gets.chomp).to_i
	end
	while (j<0) or (j>(@col-1))
	  puts "introduce la coordenada j: "
	  STDOUT.flush
	  j=(gets.chomp).to_i
	end
	@pos << [i.to_i,j.to_i]
	dato=0
	while (dato == 0)
	  puts "introduce el dato (=/=0) de la casilla (#{i},#{j}): "
	  STDOUT.flush
	  dato=(gets.chomp).to_i
	end
	@dato << dato
      end
    elsif #de numeros racionales
      for k in (0...total)
	i,j= -1,-1
	while (i<0) or (i>(@fil-1))
	  puts "introduce la coordenada i: "
	  STDOUT.flush
	  i=(gets.chomp).to_i
	end
	while (j<0) or (j>(@col-1))
	  puts "introduce la coordenada j: "
	  STDOUT.flush
	  j=(gets.chomp).to_i
	end
	@pos << [i.to_i,j.to_i]
	num=0
	while (num == 0)
	  puts "introduce el dato (=/=0) de la casilla (#{i},#{j}): "
	  puts "numerador: "
	  STDOUT.flush
	  num=(gets.chomp).to_i
	end
	puts "denominador: "
	STDOUT.flush
	den=gets.chomp
	@dato << NumerosRacionales.new(num,den.to_i)
      end
    end
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
#     else #no tienen las mismas dimensiones
      false
    end #if
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
  
  def t #traspuesta
    nueva = Matriz_dispersa.new(@col,@fil)
    for i in (0...@pos.size)
      nueva.pos << [@pos[i][1],@pos[i][0]]
      nueva.dato << @dato[i]
    end
    nueva
  end
  
  def +(other)
    raise unless other.is_a?(Matriz) #deben ser matrices, da = si se comparan densas con dispersas
    if (other.is_a?(Matriz_densa))
      other=self.coerce(other)
      other=other[0]
    end
    if (@fil == other.fil) and (@col == other.col)
      nueva= Matriz_dispersa.new(@fil,@col)
      for i in (0...@pos.size)
	k = other.buscar(@pos[i][0],@pos[i][1])
	if (k!= -1) #existe esa pos
	  if (@dato[i]+other.dato[k]) != 0
	    nueva.pos << @pos[i]
	    nueva.dato << (@dato[i]+other.dato[k])
	  end
	else
	  nueva.pos << @pos[i]
	  nueva.dato << @dato[i]
	end
      end #for
      for i in (0...other.pos.size) #almacenamos los que no se hayan sumado de la otra matriz
	k = nueva.buscar(other.pos[i][0],other.pos[i][1])
	if (k==-1)
	  nueva.pos << other.pos[i]
	  nueva.dato << other.dato[i]
	end
      end
    else
      puts "No se pueden sumar, no tienen las mismas dimensiones"
    end #if
    nueva
  end
  
    def -(other)
    raise unless other.is_a?(Matriz) #deben ser matrices, da = si se comparan densas con dispersas
    if (other.is_a?(Matriz_densa))
      other=self.coerce(other)
      other=other[0]
    end
    if (@fil == other.fil) and (@col == other.col)
      nueva= Matriz_dispersa.new(@fil,@col)
      for i in (0...@pos.size)
	k = other.buscar(@pos[i][0],@pos[i][1])
	if (k!= -1) #existe esa pos
	  if (@dato[i]-other.dato[k]) != 0
	    nueva.pos << @pos[i]
	    nueva.dato << (@dato[i]-other.dato[k])
	  end
	else
	  nueva.pos << @pos[i]
	  nueva.dato << @dato[i]
	end
      end #for
      for i in (0...other.pos.size) #almacenamos los que no se hayan sumado de la otra matriz
	k = nueva.buscar(other.pos[i][0],other.pos[i][1])
	if (k==-1)
	  nueva.pos << other.pos[i]
	  nueva.dato << -other.dato[i]
	end
      end
    else
      puts "No se pueden restar, no tienen las mismas dimensiones"
    end #if
    nueva
  end
  
  def *(other)
    if other.is_a?(Numeric)
      nueva=self
      for i in (0...@dato.size)
	nueva.dato[i] = other*nueva.dato[i]
      end
      nueva
    end
  end
  
  def max
    r = -999999
    aux=dato
    aux<< 0
    for i in (0...@dato.size)
      if (aux[i].to_f>r)
	r=aux[i]
      end
    end
    r
  end

  def min
    r = 999999
    aux=dato
    aux<< 0
    for i in (0...@dato.size) 
      if (aux[i].to_f<r)
	r=aux[i]
      end
    end
    r
  end
  
end