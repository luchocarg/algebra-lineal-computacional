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

= TL;DR

- Inclución de subespacios
- Intersección de subespacios
- Independencia lineal
  - Conj L.I. $<==>$ al menos un es CL del resto
  - Es ? única
- Base conj L.I. que genera el espacio
-

#corollary[
  Todo espacio vectorial de dimensión finita admite una base.
  #example[
    Base $Epsilon = {(1,0)(0,1)}$ ... $(1,2) = 1(1,0)+2(0,1)$
  ]

  A partir de que dado un $!K$ de dimensión $n$ y $B={v_1...v_n}$ una base de $V$ cualquier $W in V$ es escrito de forma unico como combinación lineal de $v_1...v_n$.

  $W= alpha_1 v_1 +...+alpha_n v_n$

  Al vector $(alpha_1...alpha_n)$ lo llamamos coordenadas de $W$ en base $B$

  $ mat(v_1,v_2,...,v_n) mat(alpha_1;alpha_2;...;alpha_n)_B = alpha_1 v_1 +...+ alpha_n v_n $ 

  $ C(B,E) $
]

#definition[
  $
    A in KK^(m times n)  space B in KK^(m times p) C = A.B \

    c_(i j) = f_i (A).c(B) = sum_(k=1)^n a_(i k) b(k j)
  $

  #corollary[En general, por columnas, $C_i (A B) = A C_i (B)$]

  #corollary[Por filas:

  #example[
    $
      mat(
        1,2,3;4,5,6;7,8,9
      )
      mat(
        a,d;b,e;c,f
      )
      =
      mat(
       f_1 (A) mat(a,d;b,e;c,f) ;
       f_2 (A) mat(a,d;b,e;c,f);
       f_3 (A) mat(a,d;b,e;c,f)      )
    $
  ]
  En general que $f_i (A B) = f_i (A).B$
  ]
]

  Espacio columna $C(A) = !<C_1 (A), C_2 (A), C_3 (A),...,C_n (A)!>$

  Espacio fila $F(A) = !<F_1 (A), F_2 (A), F_3 (A),...,F_n (A)!>$

  Rango columna $rg (A) = dim C(A)$ 

  Rango fila $rg (A) = dim F(A)$

#theorem[
  $rg_f (A) = rg_c (A)$

  lo llamamos rango de A: $rg(A)$
]

Subespacios asociados a una matriz de $A in KK^(m times n)$

$Nu(A) = {x in KK^n : A x = 0}$

$IM(A) = {y in KK^m | exists x in KK^n : y = A x} = {A x : x in KK^n} = c(A)$

$A x = x_1 C_1 (A) + y_2 C_2 (A) +...+ x_n C_n (A)$

#example[
  $
    A = mat(1,-1;1,-1;0,0) mat(a;b) = mat(1;1;0) a + mat(-1;-1;0) b

  $

  Buscamos el núcleo:

    
  $A x = 0 sii mat(1;1;0) a + mat(1;-1;0) b= mat(0;0;0) $  
]


#let matA = $mat(1,2,0;0,1,1;1,3,1)$
#let matC = $mat(1,2;0,1;1,3)$
#let matR = $mat(1,0,-2;0,1,1)$

#definition[$A = C R$

  #example[
    Como voy a armar la matriz C? poniendo las L.I. de A recorriendo las columnas
     
  
    $ A = mat(1,2,0;0,1,1;1,3,1) = underbrace(overbrace(mat(1,2;0,1;1,3),C),2 times 3) $

    Y para armar $R$ de tal forma que $R = C. A$

    $underbrace(matA,3 times 3) = underbrace(matC,3 times 2) . underbrace(matR,2 times 3) <- "forma escalonada reducida" $    


    $(0,1,1) = (2,1,3) - 2(1,0,1)$, luego no la agrego.

  ]

    #definition[
      $F(A) = F(R)$

      $!< f_1 (A), f_2 (A), f_3 (A) !> = !< f_1 (R), f_2 (R) !>$
    ] 
]
