require "./lib/gcd.rb"

class NumerosRacionales
  attr_reader :a, :b
  
  def initialize (a, b)
    raise ZeroDivisionError, "Denominador igual a cero" if (b==0)
    if (a<0) and (b<0) #si los dos son negativos => nos queda positivo
      a,b= -a,-b
    end
    simplifica = gcd(a,b)
    @a,@b = a/simplifica,b/simplifica
  end
  
  def num()
    @a
  end

  def denom()
    @b
  end
  
  def to_s
    if (@a == 0) #numerador = 0, racional = 0. El denominador lo controlamos en el constructor
      "0"
    elsif (@b==1)
      "#{@a}"
    else
      "#{@a}/#{@b}"
    end
  end
  
  def to_f
    tmp=@a.to_f/@b.to_f
    return tmp
  end
  
  
  def simplificar
    simplifica = gcd(@a,@b)
    NumerosRacionales.new(@a/simplifica,@b/simplifica)
  end
  
  def +(other) 					#para sumar dos nums racionales...
    if (other.is_a?(Numeric))
      other=self.coerce(other)
      other=other[0]
    end
    deno = mcm(@b, other.b)			#MCM para hallar el denominador
    num = ((deno/@b) * @a) + ((deno/other.b) * other.a)
    simplifica = gcd(num,deno)			#averiguamos el valor para obtener el racional irreducible
    if ((num < 0) and (deno < 0)) or ((num > 0) and (deno < 0)) #corregimos el signo
      num = num * (-1)
      deno = deno * (-1)
    end
    NumerosRacionales.new(num/simplifica,deno/simplifica)
  end

  def -(other)					#para restar dos nums racionales...
    if (other.is_a?(Numeric))
      other=self.coerce(other)
      other=other[0]
    end
    deno = mcm(@b, other.b)			#MCM para hallar el denominador
    num = ((deno/@b) * @a) - ((deno/other.b) * other.a)
    simplifica = gcd(num,deno)			#averiguamos el valor para obtener el racional irreducible
    if ((num < 0) and (deno < 0)) or ((num > 0) and (deno < 0)) #corregimos el signo
      num = num * (-1)
      deno = deno * (-1)
    end
    NumerosRacionales.new(num/simplifica,deno/simplifica)
  end
  
  def *(other)		#multiplicacion: multiplicamos numerador con numerador y denominador con denominador
    num = @a*other.a
    deno = @b*other.b
    simplifica = gcd(num,deno)			#averiguamos el valor para obtener el racional irreducible
    if ((num < 0) and (deno < 0)) or ((num > 0) and (deno < 0)) #corregimos el signo
      num = num * (-1)
      deno = deno * (-1)
    end
    NumerosRacionales.new(num/simplifica,deno/simplifica)
  end
  
   def /(other) #división: multiplicamos en cruz: numerador de uno x denominador del otro y viceversa
     num = @a*other.b
     deno = @b*other.a
     simplifica = gcd(num,deno)			#averiguamos el valor para obtener el racional irreducible
    if ((num < 0) and (deno < 0)) or ((num > 0) and (deno < 0)) #corregimos el signo
      num = num * (-1)
      deno = deno * (-1)
    end
     NumerosRacionales.new(num/simplifica,deno/simplifica)
   end
   
   def %(other)
     tmp = (self/other).abs
     t = NumerosRacionales.new(1,1)
     tmp= t-tmp
     NumerosRacionales.new(tmp.num, tmp.denom)
   end
   
   def coerce(other)
     if (other.is_a?(Numeric))
       [NumerosRacionales.new(other.to_i,1),self]
     end
   end
   
   def ==(other)
     if (self.to_f == other.to_f)
       true
     else
       false
     end
   end
   
  def <(other)
    if (self.to_f < other.to_f)
      true
    else
      false
    end
  end

  def <=(other)
    if (self.to_f <= other.to_f)
      true
    else
      false
    end
  end  
  
  def >(other)
    if (self.to_f > other.to_f)
      true
    else
      false
    end
  end

  def >=(other)
    if (self.to_f >= other.to_f)
      true
    else
      false
    end
  end
  
   def <=>(other)
     self.to_f <=> other.to_f
   end
  
   def abs
     n, d = @a.abs, @b.abs
     NumerosRacionales.new(n,d)
   end
   
   def reciprocal
     inv = NumerosRacionales.new(1,1)
     tmp = inv/self
     NumerosRacionales.new(tmp.num,tmp.denom)
   end
   
   def -@
       NumerosRacionales.new(-self.num,self.denom)
   end
   
end
