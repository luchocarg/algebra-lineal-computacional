#import "../config/setup.typ": *

#show: doc => plantilla-alc(titulo: "Guía 1",dark: true, doc)

= Guía 1: Reducción y Espacios Vectoriales

// 2 argumentos posicionales: [Enunciado] [Resolución]
#problema[
  Determinar si el siguiente conjunto es linealmente independiente en $RR^3$:
  $ S = { vec(1, 2, 3), vec(0, 1, 4), vec(5, 6, 0) } $
][
  Planteamos la matriz con los vectores como columnas y reducimos por filas:
  $
    mat(1, 0, 5; 2, 1, 6; 3, 4, 0)
    &tilde.equiv mat(1, 0, 5; 0, 1, -4; 0, 4, -15) quad &text(F_2 - 2F_1 -> F_2) \
    & &text(F_3 - 3F_1 -> F_3) \
    &tilde.equiv mat(1, 0, 5; 0, 1, -4; 0, 0, 1) quad &text(F_3 - 4F_2 -> F_3)
  $
  Como el rango es 3, los vectores son linealmente independientes.
]

// 3 argumentos posicionales: [Título] [Enunciado] [Demostración]
#teorema[Unicidad de la Factorización LU][
  Si $A in RR^(n times n)$ es invertible y admite factorización $L U$ sin pivoteo donde $L$ es triangular inferior unitaria, dicha descomposición es única.
][
  Supongamos $A = L_1 U_1 = L_2 U_2$. Entonces $L_2^(-1) L_1 = U_2 U_1^(-1) = I$, de lo cual se deduce $L_1 = L_2$ y $U_1 = U_2$.
]

// Bloque sin demostración: se pasa [] en el último argumento
#lema[Rango y Espacio Nulo][
  Para toda matriz $A in RR^(m times n)$, se cumple que $text(dim)(text(C)(A)) + text(dim)(text(N)(A)) = n$.

  #bookmark([asd])[]

][]


#lema[asd][
  #equation-box[assdasdasdasdasd
  assdasdasdasdasd
  assdasdasdasdasd
  
  
  asdasdasdasdasddsa]

  #bookmark([asd])[]
]
