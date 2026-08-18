#import "@preview/theorion:0.6.0": *

#import cosmos.fancy: *

#show: show-theorion

#set text(lang: "es")

#definition[
$A x = b$
donde A es la matriz de coeficientes y b es el vector columna de los términos constantes.

$ underbrace([A | b], "Matriz extendida") $ 
]

#definition[ Matrices elementales son aquellas en $KK^(m times n)$ que cumplen una de las siguientes:

a. $E_i (lambda) "con" lambda != 0 "que es igual a " I_m$

b. $E_(i j) "con" i!=j ", que se obtiene de intercambiar las filas" i "y" j "de" I_m$

c. $E_( i j) (lambda) "con" i!=j ", que es igual a " I_m "salvo en la entrada" (j,i) "donde vale" lambda$
]

#property[Toda matriz invertivle es el producto de matrices elementales.]


#definition[ Dos matrices $A,B in KK^(m times n)$ son #underline("equivalentes") si existe $E in KK^(m times m)$ invertible tal que $A = E B$
Notas relaciones:

  1. Reflexión: $A = I A$
  2. Simetría: $E B ==> B = E^(-1) A$
  3. Transitividad: $A = E B and B = E^(-1) C ==> A = (E E^(-1)) C$
]

#property[Toda matriz es equivalente a una matriz de ceros por debajo de la diagonal principal (o sea, triangular superior)]


#example[

  $ A =
    mat(0,1,3;1,2,0;2,-1,-8) ->_(E_(1 2))
    mat(1,2,0;0,1,3;2,-1,-8) ->_(E_(1 3)(-2))
    mat(1,2,0;0,1,3;0,-5,-8) ->_(E_(3)(1/7)) ^(E_(2 3)(5))
    mat(1,2,0;0,1,-8;0,0,1) = \
    E_3(1/7) E_(2 3)(5) E_(1 3)(-2) E_(1 2) A
  $
]

#example[
  $
    C = mat(1,2,4,3,-1;0,0,0,1,2;-1,-2,-3,-3,3;0,0,-1,1,-2) \ ->_(E_(1 3)(1)) space ->_(E_(2 3))  space ->_(E_(2 4)(1)) space ->_(E_(3 4)(-1)) space ->_(E_(4)(-1/2)) \
    
    mat(1,2,4,3,-1;0,0,1,0,2;0,0,0,1,2;0,0,0,0,-2)
    
  $
  
]

#definition[ Dado $A in KK^m times n$, se define rango($A$) como el número máximo de puntos que puede tener una matriz equivalente a $A$]

#property[ $A in K^(m times n)$, rango($A$) $=< min{m,n}$]

#theorem[Rouché-Frubenius][
  Sea $A x = b$. Este sistema es compataible si y solo si rango($A$) = rango($[A | b]$).

  Si además, rango($A$) = $n$ hay una única solución y si rango($A$) $< n$ hay infinitas soluciones.
  
]

#example[

  $
  cases(
    x-y+z &= 1,
    2x-2y+2z &= k 
  )
  $

  $

  mat(1,-1,1,1;2,-2,2,k;augment: #3) ->_(E_(1 2)(-2))
  mat(1,-1,1,1;0,0,0,k-2;augment: #3)
  $

  Tiene infinitas soluciones si $k=2$

  
]

#example[
Hallar condiciones sobre $a$ y $b$ para que el siguiente sistema sea consistente:


  $
    cases(
      a x+2z&=2,
      5x+2y &=1,
      x-2y+b z &= 3
    )
  $

  $
    mat(a,0,2;5,2,0;1,-2,b) mat(x;y;z) = mat(2;1;3) ->
    mat(a,0,2,2;5,2,0,1;1,-2,b,3;augment: #3) ->_E_(1 3) \
    mat(1,-2,b,3;5,2,0,1;a,0,2,2;augment: #3) ->_(E_(1 3)(-1))^(E_(1 2)(-5)) \
    mat(1,-2,b,3;0,12,-5 b, -14; 0,2 a, 2-a b, 2-3 a; augment: #3) ->_(E_(2 3)(-a/b))
    mat(1,-2,b,3;0,12,-5 b,-14;0,0,2-(a b)/6, 2-2a /3; augment: #3)

$

Si $2-(a b)/6 != 0$ i.e. $a b != 12$ el sistema es compatible determinado


Si $a b = 12,$

$
  mat(1,-2,b,3;0,12,-56,-14;0,0,0,2-2/3 a; augment: #3)
  
$

El sistema es compatible si $a=3$ (y por lo tanto, $b=4$)
]

#example[
  Nota: $z=a+i b, overline(z)= a- i b, |z|^2 = a^2+b^2, z^(-1) = overline(z)/(|z|^2) $

  $
    cases(
      i x+y+z = 5+i,
      x- i y + z = 4-2 i,
      x + y - i z = 3 - 3i
    )
  $

  $
    mat(i,1,1,5+i;1,-i,1,4-2i;1,1,-1,3-3i;augment: #3) \

    ->E_(1 2) ->E_(1 2)(-i) ->E_(1 3)(-1) -> E_3 ((1+i)^(-1)) -> E_2 ((1-i)^(-1))\    

    mat(1,-i,1,4-2i;0,0,1,3-i;0,1,-1,-1;augment: #3)
  $

  Operando:

  $z=3 \ y-z =-1 => y=2 \ x-i y + z = 4-2 i => x=1$
]


#example[
  $
mat(1,2,3;1,2,3;1,2,3) ->E_12(-2)
= mat(
  -1, -2, -3;
  1, 2, 3;
  1, 2, 3
)
  $
]
