#import "../config/setup.typ": *

#show: doc => plantilla-alc(titulo: "Guía 1",dark: true, doc)


= Práctica 1: Resolución de sistemas de ecuaciones lineales.

#ejercicio(preheader: [*Ejercicio 7.*], is-proof:false)[
  Hallar un sistema de generadores para $S inter T$ y para $S + T$ como subespacios de $V$, y determinar si la suma es directa en cada uno de los siguientes casos:

  #ejercicio(preheader: [*a.*],is-proof:false)[
    $V=RR^3$, $S={(x,y,z): 3x-2y+z=0}$ y $T={(x,y,z): x+z=0}$
  ][
    
  ]

  #ejercicio(preheader: [*b.*], is-proof:false)[
    $V=RR^3$, $S={(x,y,z): 3x-2y+z=0, x-y=0}$ y $T=chevron.l (1,1,0), (5,7,3) chevron.r$
  ][]

  #ejercicio(preheader: [*c.*], is-proof:false)[
    $V=RR^3$, $S=chevron.l (1,1,3), (1,3,5), (6,12,24) chevron.r$, $T=chevron.l (1,1,0), (3,2,1) chevron.r$
  ][]

  #ejercicio(preheader: [*d.*], is-proof:false)[
    $V=RR^(3 times 3)$, $S={(x_(i j)) / x_(i j)=x_(j i) forall i,j}$, $T={(x_(i j)) / x_11+x_12+x_13=0}$
  ][]

  #ejercicio(preheader: [*e.*], is-proof:false)[
    $V=CC^3$, $S=chevron.l (i,1,3-i), (4,1-i,0) chevron.r$, $T={x in CC^3 : (1-i)x_1 - 4x_2 + x_3 = 0}$
  ][]
][]

#ejercicio(preheader: [*Ejercicio 8.*], is-proof:false)[
  Determinar todos los $k in RR$ para los cuales:

  #ejercicio(preheader: [*a.*],is-proof:false)[
    $chevron.l (-2, 1, 6), (3, 0, -8) chevron.r = chevron.l (1, k, 2k), (-1, -1, k^2), (1, 1, k) chevron.r$
  ][]

  #ejercicio(preheader: [*b.*], is-proof:false)[
    $S inter T = chevron.l (0,1,1) chevron.r$ siendo $S={x in RR^3 : x_1+x_2-x_3=0}$ y $T=chevron.l (1,k,2), (-1,2,k) chevron.r$
  ][]
][]

#ejercicio(preheader: [*Ejercicio 9.*], is-proof:false)[
  Sean $S$ y $T$ subespacios de un $K$-espacio vectorial $V$. Probar que $S union T$ es un subespacio de $V$ si y solo si $S subset.eq T$ o $T subset.eq S$.
][]

#ejercicio(preheader: [*Ejercicio 11.*], is-proof:false)[
  Extraer una base de $S$ de cada uno de los siguientes sistemas de generadores y hallar la dimensión de $S$. Extender la base de $S$ a una base del espacio vectorial correspondiente.

  #ejercicio(preheader: [*a.*],is-proof:false)[
    $S = chevron.l (1,1,2), (1,3,5), (1,1,4), (5,1,1) chevron.r subset RR^3$, $K=RR$
  ][]

  #ejercicio(preheader: [*b.*], is-proof:false)[
    $S = chevron.l mat(1, 1; 1, 1), mat(0, i; 1, 1), mat(0, i; 0, 0), mat(1, 1; 0, 0) chevron.r subset CC^(2 times 2)$, $K=CC$
  ][]
][]

#ejercicio(preheader: [*Ejercicio 12.*], is-proof:false)[
  Sean $v_1,...,v_k in RR^n$. Probar que ${v_1,...,v_k}$ es linealmente independiente sobre $RR$ si y solo si ${v_1,...,v_k}$ es linealmente independiente sobre $CC$.
][]

#ejercicio(preheader: [*Ejercicio 13.*], is-proof:false)[
  Sean $m, r in NN$.

  #ejercicio(preheader: [*a.*], is-proof:false)[
    Probar que si $A in K^(m times n)$ satisface que $A x=0 forall x in K^n$, entonces $A=0$. Deducir que si $A, B in K^(m times n)$ satisfacen que $A x = B x forall x in K^n$, entonces $A=B$.
  ][]

  #ejercicio(preheader: [*b.*], is-proof:false)[
    Probar que si $A in K^(m times n)$, $B in K^(n times r)$ con $B=(b_(i j))$ y, para $1 <= j <= r$, $B_j = mat(b_(1 j); dots.v; b_(n j))$ la columna $j$-ésima de $B$, entonces $A B = (A B_1 | dots.c | A B_r)$ (es decir, $A B_j$ la columna $j$-ésima de $A B$).
  ][]
][]

#ejercicio(preheader: [*Ejercicio 14.*], is-proof:false)[
  Sean las siguientes matrices de $3 times 3$:
  $ A = mat(1, 3, 0; 0, 1, 2; 1, 0, 1) quad B = mat(1, 1, 1; 3, 0, 1; 2, 0, 2) quad C = mat(c_11, c_12, c_13; c_21, c_22, c_23; c_31, c_32, c_33) $
  Y consideremos el producto $A B = C$ en bloques:
  $ mat(A_11, A_12; A_21, A_22) mat(B_11, B_12; B_21, B_22) = mat(C_11, C_12; C_21, C_22) $
  Para cada una de las particiones en bloques mencionadas a continuación, indicar si es realizable el producto $C = A B$ en bloques. En caso de ser realizable, calcular cada bloque $C_(i j)$ indicando sus dimensiones.

  #ejercicio(preheader: [*a.*], is-proof:false)[
    $A_11 = [a_11]$, $A_12 = [a_12, a_13]$, $A_21 = mat(a_21; a_31)$, $A_22 = mat(a_22, a_23; a_32, a_33)$ \ \
    $B_11 = [b_11]$, $B_12 = [b_12, b_13]$, $B_21 = mat(b_21; b_31)$, $B_22 = mat(b_22, b_23; b_32, b_33)$
  ][]

  #ejercicio(preheader: [*b.*], is-proof:false)[
    $A_11 = [a_11, a_12]$, $A_12 = [a_13]$, $A_21 = mat(a_21, a_22; a_31, a_32)$, $A_22 = mat(a_23; a_33)$ \ \
    $B_11 = [b_11]$, $B_12 = [b_12, b_13]$, $B_21 = mat(b_21; b_31)$, $B_22 = mat(b_22, b_23; b_32, b_33)$
  ][]

  #ejercicio(preheader: [*c.*], is-proof:false)[
    $A_11 = mat(a_11; a_21)$, $A_12 = mat(a_12, a_13; a_22, a_23)$, $A_21 = [a_31]$, $A_22 = [a_32, a_33]$ \ \
    $B_11 = [b_11]$, $B_12 = [b_12, b_13]$, $B_21 = mat(b_21; b_31)$, $B_22 = mat(b_22, b_23; b_32, b_33)$
  ][]
][]

#ejercicio(preheader: [*Ejercicio 15.*], is-proof:false)[
  Dadas las bases de $RR^3$, $B={(1,1,0), (0,1,1), (1,0,1)}$ y $B'={(-1,1,1), (2,0,1), (1,-1,3)}$:

  #ejercicio(preheader: [*a.*],is-proof:false)[
    Calcular $[(1,1,0)]_B$ y $[(1,1,0)]_B'$
  ][]

  #ejercicio(preheader: [*b.*], is-proof:false)[
    Calcular la matriz de cambio de base $C(B,B')$
  ][]

  #ejercicio(preheader: [*c.*], is-proof:false)[
    Comprobar que $C(B,B')[(1,1,0)]_B = [(1,1,0)]_B'$
  ][]
][]

#ejercicio(preheader: [*Ejercicio 20.*], is-proof:false)[
  Sean $A, B, C, D in K^(n times n)$ y $M in K^(2n times 2n)$ la matriz de bloques $ M = mat(A, B; C, D) $ Probar que si $A$ es inversible, entonces:

  #ejercicio(preheader: [*a.*],is-proof:false)[
    $M = mat(A, 0; C, I) mat(I, A^(-1) B; 0, D - C A^(-1) B)$
  ][]

  #ejercicio(preheader: [*b.*], is-proof:false)[
    $det(M) = det(A D - A C A^(-1) B)$. Concluir que si $A C = C A$, $det(M) = det(A D - C B)$.
  ][]
][]
