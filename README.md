prct09
=======

Partiendo de la practica anterior, vamos a mejorarla e incluir dos tipos de matrices: densas y dispersas.

Consideramos matriz dispersa si tiene más de un 60% de ceros, densas como las que hemos usado hasta ahora.

Para construir este tipo de matrices de forma eficiente, ya que la mayoría de su contenido es igual (a cero),
con el fin de:
 - utilizar un mínimo consumo de memoria,
 - mínimo uso del procesador,
 - minimizar el tiempo para acceder a los datos y hacer las operaciones,
 - y localizar los datos
 
hemos decidido utilzar la siguiente estructura provisional, que modificaremos en función de los consejos
y correcciones de los profesores.

####ESTRUCTURA 1

Utilizaremos dos vectores: posicion y datos.
 - poscion: almacenara la posicion (i,j) donde guardaremos un dato distinto de cero.
 - dato: almacenara el dato en la posicion dada.
 
Veamos un ejemplo:
``` 
vector_posicion = [[1,2],[2,2]]
vector_dato = [3,-2]
```
Esto quiere decir que para una matriz NxM, por ejemplo, 3x3, nos quedaria de la forma:
```
 (0 3 0)
 (0 -2 0)
 (0 0 0)
```
Esta estructura es intuintiva y facil de usar.

####ESTRUCTURA 2

La segunda estrategia consiste en ayudarnos de una estructura de tipo hash. Veamos un ejemplo.
Utilizaremos los mismos datos, representandolos de forma diferente.
```
Nuestro hash es: m = {1 => 3, 4 => -2}
```
```
 matriz		posicion
 (0 3 0)	(0 1 2)
 (0 -2 0)	(3 4 5)
 (0 0 0)	(6 7 8)
```
Esto quiere decir que el elemento 1 de la matriz, es decir, posicion (1,2), corresponde al elemento de valor 3.
De la misma forma, el elemento 4 de la matriz, es decir, posicion (2,2), corresponde al elemento de valor -2.

La ventaja de esta estructura frente a la anterior es que ocupa menos memoria, pero hay que usar funciones
adicionales que calculen la relación entre el id en el hash y su indice correspondiente en la matriz.

Grupo (M-15)
============

 - María Belén Armas Torres
 - Aarón Socas Gaspar
