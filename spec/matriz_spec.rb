# require "./lib/matriz.rb"
require "./lib/matriz_densa.rb"
require "./lib/matriz_dispersa.rb"


describe Matriz do
  
  before :each do
    @m1 = Matriz_densa.new(2,2)
    @m1.llenar([[1,2],[2,3]])
    @m2 = Matriz_densa.new(2,2)
    @m2.llenar([[-1,1],[2,-5]])
    @m3 = Matriz_densa.new(2,2)
    @m3.llenar([[NumerosRacionales.new(1, 1),NumerosRacionales.new(1, 1)],[NumerosRacionales.new(1, 1),NumerosRacionales.new(1, 1)]])
    @m4 = Matriz_densa.new(2,2)
    @m4.llenar([[NumerosRacionales.new(1, 2),NumerosRacionales.new(3, 5)],[NumerosRacionales.new(11, 40),NumerosRacionales.new(49, 150)]])
    
    @m5 = Matriz_dispersa.new(2,2)
    @m5.llenar([[0,1]],[-1])
    @m6 = Matriz_dispersa.new(2,2)
    @m6.llenar([[1,0]],[5])
    @m7 = Matriz_dispersa.new(2,2)
    @m7.llenar([[1,1]],[NumerosRacionales.new(1, 2)])
    @m8 = Matriz_dispersa.new(2,2)
    @m8.llenar([[0,0]],[NumerosRacionales.new(5, 3)])
  end
  
  describe "# Definicion de argumentos: " do
    it " - Las dimensiones son correctas" do
      lambda {@m9.new(-1,1).should raise_error(TypeError)}
      lambda {@m9.new(1,-1).should raise_error(TypeError)}
      @m1.fil.should eq(2)
      @m1.col.should eq(2)
      @m5.fil.should eq(2)
      @m5.col.should eq(2)
    end
    it "- Contenido de la matriz densa" do
        @m9 = Matriz_densa.new(2,2)
	@m9.llenar([[1,2],[2,3]])
        (@m1==@m9).should eq(true)
    end
    it "- Contenido de la matriz dispersa" do
	@m9 = Matriz_dispersa.new(2,2)
	@m9.llenar([[0,1]],[-1])
	aux= (@m5 == @m9)
        aux.should eq(true)
    end
  end

end
