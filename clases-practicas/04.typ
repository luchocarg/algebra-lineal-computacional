#import "@preview/theorion:0.6.0": *
#import "@preview/quick-maths:0.2.1": shorthands

#import cosmos.fancy: *

#show: show-theorion

#set text(lang: "es")


#let v1vn = "v1vn"
#let dim = "dim"
#let rg = "rg"
#let Nu = "Nu"
#let IM = "Im"
#let sii = $<==>$

#show: shorthands.with(
  ($!<$, $chevron.l$),
  ($!>$, $chevron.r$),
  ($!K$, $KK-"e.v."$),
  ($"v1vn"$, $v_1...v_n$),
  ($v 1$,$v_1$),
  ($v 2$,$v_2$),
  ($v n$,$v_n$)
)

#exercise-box("3")[
  Consideramos el subespacio de $RR^(2 times 2)$

  $ S = {A in RR^(2 times 2) : A = A^T, tr(A)=0} $

  1. Encontrar un conjunto de generadores de $S$

  2. Dado $T = !< mat(1/3,5/6;5/6,-1/3) !>$ determinar si $T subset.eq S$

]

#solution([Ejercicio 1])[
  $
    mat(a,b;c,d) =_(A=A^T) mat(a,b;b,d) =_(tr(A)) mat(a,b;b,-a)
  $

  $
    v = !< mat(1,0;0,-1), mat(1,0;0,-1) !> = !< a mat(1,0;0,-1) + b mat(0,1;0,-1) !>
  $

  #note()[ $ S = {A in RR^(3 times 3): A = A^T} subset.eq RR^(3 times 3) $ ]

]

#solution([Ejercicio 2])[
  Basta ver si el generador de $T$ está o no en $S$. #underline("Es claro que está") 

  #underline("Determinantes:") $det: KK^(n times n) --> KK$

  #example[
    $ det mat(a,b;c,d) = a d - b c $

  ]
  #note[ El determinante es una forma de volumen simulado i.e. no inversible ]
]

#example(["Determinante" $3 times 3$])[
  
]

#theorem()[
  $ A in KK^(n times n)$ es inversible $sii det(A) != 0$
]

#exercise-box([4])[
  Determinar si la matriz

  $
    A = mat(1,3,-1;2,4,-4;-1,-2,1)
  $

  es inversible. En ese caso, encontrar $A^(-1)$
]

#solution("Ejercicio 4")[
  #note-block[Usando Laplace, tal que $mat(+,-,+;-,+,-;+,-,+) <-- (-1)^(i+j)$]

  $
    det(A) &= det mat(1,3,-1;2,4,-4;-1,-2,1) = 

    -4+6+0 = 2 != 0 ==> "es inversible"
  $

  Entonces, tenemos que resolver el sistema:

  $
    mat(1,3,-1,1,0,0;2,4,-4,0,1,0;-1,-2,1,0,0,1; augment: #(-3))& =_(f_2 -> f_2-2 f_1\ f_3 -> f_3+f_1) \
    mat(1,3,-1,1,0,0;0,-2,-2,-2,1,0;0,1,0,1,0,1; augment: #(-3))& =_(f_2 -> f_3 \ -1/2 f_3) \
    mat(1,3,-1,1,0,0;0,1,0,1,0,1;0,1,1,1,-1/2,0; augment: #(-3))& =_(f_1-> f_1 - 3 f_2 \ f_3 -> f_3 - f_2) \
    mat(1,0,1,-2,0,-3;0,1,0,1,0,1;0,0,1,0,-1/2,-1; augment: #(-3))& =_(f_1 -> f_1 + f_3) \
    mat(1,0,0,-2,-1/2,-4;0,1,0,1,0,1;0,0,1,0,-1/2,-1; augment: #(-3))& = (I | A^(-1))\
  
  $
]

#exercise-box("5")[
  Consideremos la base
  $
    cal(B) = {vec(1,3,7),vec(4,0,1),vec(5,-7,0)}
  $

  1. Dado $v in RR^3$ cuyas coordenadas en la base $cal(B)$ son $vec(1,2,-5)$. Hallar las coordenadas de $v$ en la base canónica.

  2. Dado $w =  vec(10,24,13)$, hallar su expresión en la base $cal(B)$.
]

#solution("Ejercicio 5.1")[
  $
    v = 1 vec(1,3,7) + 2 vec(4,0,1) - 5 vec(5,-7,0) = vec(-16,38,9)
  $
]


#solution("Ejercicio 5.2")[
  La matriz de cambio de base es

  $
    C_(cal(B) E) =
    mat(
      1,4,5;
      3,0,-7;
      7,1,0
    ) in RR^(3 times 3)
  $

  #block(fill: luma(230), inset: 8pt)[$(C_(cal(B) E) [w]_E = [w]_cal(B))$]


  Extendemos la matriz:

  
  $
    mat(
      1,4,5,10;
      3,0,-7,24;
      7,1,0,3;
      augment: #(-1)    
    ) = "completar"
  $
]
