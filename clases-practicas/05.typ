#import "../config/setup.typ": *

#show: doc => plantilla-alc(titulo: "Guía 1",dark: false, doc)

#set heading(numbering: "1.a.")

#let tl(f) = $floor.l #f floor.r$
#let inner(f) = $chevron.l #f chevron.r$
#let Nu = "Nu"
#let Rg = "Rg"
#let rg = "rg"

#title([Clase práctica 05])

#definicion[
  $V, W$ $KK$-e.v., $f: V-> W$ es T.L. si

  $
    f(v_1+lambda v_2) = f(v_1) + lambda f(v_2)
  $
]

#ejercicio(is-proof: false)[
  $f equiv 0$ es TL

  1. $V=W_i f= id_V$ es T.L.

  2. $A in KK^(m times n), underbracket(f_A,equiv A): KK^n --> KK^m, X |-> A x$ o T.L.
  
  3. $B subset.eq$ base de $V$, $[ dot ]_B : V --> KK^n$ ($n = dim V$)
][]

#proposicion[
  $f: V-->W$ es T.L. $==>$

  1. $f(0_V) = 0_W$

  2. $f(-v) = -f(v)$
  
][]

Ver que las siguientes aplicaciones no son T.L.

1. $f(x) = x+1$ *$(f(0)=1 != 0)$*

2. $g(x)=x^2$ *$(g(lambda x) = lambda^2 x != lambda g(x) = lambda x^2)$*

3. $h(x) = sin(x)$ *$(h(pi/2) = 1 != 1/2 h(pi) = 0)$*


#teorema(breakable: true)[
  $V, W$ $KK$-e.v., $B={v_1,dots,v_n} subset.eq V$ base de $V$ y ${w_1,dots,w_n}subset.eq W$ una colección de vectores. $==> exists! "T.L. " f:V-->W: f(v_1)=w_i quad forall i=1 dots n$
][
  $
  v in V ==> v = sum_(i=1)^n c. v_1 |-> sum_(i=1)^n c_i w_i = f(v)
  $

  Quiero ver que $v, v' in V. lambda in KK ==> f(v+ lambda v') = f(v) + lambda f(v')$

  $
    v = sum_(k=1)^n c_k v_k, v' &= sum_(i=1)^n c'_i v_i \

    v+lambda v' &= sum_(i=1)^n (c_i + lambda c'_i) v_i |-> sum_(i=1)^n (c_i+lambda c'_i) w_i \
    &= sum_(i=1)^n c_i w_i + lambda sum_(i=1)^n c'_i w_i
  $
]

#proposicion(is-proof:false)[Transformaciones lineales][
  $==> $ vemos que $exists$ T.L. $:f(v_1) = w_1$

  tal que $f_1, f_2$ T.L.: $f_1(v_1) = w_1 and f_2(v_1) = v_1 ==> f_1 = f_2$

  $ f_1=f_2 <==> forall v in V. f_1(v)=f_2(v) $

  $ v in V ==> v= sum_(i=1)^n c'_i v_i $

  $ ==> f_1 (v) = f_1 (sum_(i=1)^n c'_i v_i) = sum_(i=1)^n underbracket(f_1(v_i),w_1) = sum_(i=1)^n c'_i f_2 (v_1) = f_2 (v) $
][]

#ejercicio(is-proof:false)[][
  Hallar $f(2,-1),$ donde $f: RR^2 -> RR^(2 times 2)$ T.L.

  $f(-1,3) = mat(0,2;-2,0), quad f(2,0) = mat(1,-1;0,1)$
][

  $B = {(-1,3),(2,0)} subset.eq V$ es L.I. *_(y además base)_*

  Sea $a,b in RR quad vec(2,-1) =  a vec(-1,3) + b vec(2,0) = vec(2b-a,3a)$

  $
    &--> cases(-a+2b &= 2,
    3a + 0 &= -1)

    equiv mat(-1,2,2;3,0,-1;augment: #(-1)) \

    &--> a= -1/3, b= 5/6 ==> f(2,-1) = 1/3 mat(0,2;-2,0) + 5/6 mat(1,-1;0,1)
  $
]

#definicion[
][
  Dados $V,W$ $KK$-e.v., decimos que son $underline("isomorfos")$ si $exists f: V->W$ T.L. biyectiva *(la inversa también es T.L.)*

  $<==> exists g: W->V "T.L." quad quad f compose g = id_W and g compose f = id_V$
]


#proposicion(breakable: true, is-proof: true)[
  $V,W$ $KK$-e.v. y $f:V->W$ T.L.

  1. $f$ inyectiva y $B subset.eq V$ L.I. $==> f(B) subset.eq W$ es L.I.

  2. $f$ inyectiva y $B subset.eq W$ L.I. $==> f(B) subset.eq V$ es L.I.
  
  3. $f$ es biyectiva y $dim_KK V subset infinity ==> dim_KK W subset infinity$
][

  Quiero ver que $f(B) subset.eq W$ es L.I.  $B = {v_1 dots v_n} subset.eq V$

  $
  f(B) = {f(v_1) dots f(v_n) subset.eq W} \
  <==> \

  0 = sum_(i=1)^n c_1 f(v_i) ==> c_i, dots, c_n = 0 \ 

  =_("f lineal (por hipótesis)") \

  f(sum_(i=1)^n c_i v_i) = 0 ==> sum_(i=1)^n c_i v_i = 0 ==> \
   c_i, dots c_n = 0 ==> \

  f(0)=0
  $

  #observacion()[
    $V$ $KK$-e.v., $[ dot]_B : V--> KK^n, v = sum c_i v_i |-> (c_1,dots,c_n)$, $B = {v_1 dots v_n}$
  ]

  $
    psi: KK^n --> V, (c_1, dots c_n) |-> sum_(i=1)^n c_i v_i
  $

  como $psi$ *acá no entendí nada! proceda*

  $ ==> 3) \

  [dot]_B #block[$arrow.b arrow.t$]_(KK^n) psi quad quad quad V->^F W ==> W tilde.equiv KK^n ==> dim W = n$
]

#definicion[][
  *??? sepa la bola, lo de monomorfismo y epimorfismo*
]

#definicion[
  $
    dim(underbracket(Nu(f),<= V)) = nul(f) quad underline("la nulidad de f") \
    dim(underbracket(Im(f), <= W)) = rg(F) quad underline("el rango de f")
  $

  #teorema[
    del rango (nulidad)
  ][
    $ f: V--> W "T.L." $

    $
    ==>& dim V = nul(f) + rg(f) \
       & dim(Nu(f)) + dim(Im(f)) 
    $
  ][]
]


#ejemplo(breakable: true)[][
  $f: RR^5 --> RR^3. (x_1, x_2, x_3, x_4, x_5) |-> \

  f(x_1,x_2,x_3,x_4,x_5) = cases(x_1+x_2+x_3+x_4+x_5,x_2-x_4+x_5,x_1+x_3+2x_4)$

  Dar bases de $Nu(f)$ de $Im(f)$

  $
    mat(1,1,1,1,1;0,1,0,-1,1;1,0,1,2,0) vec(x_1, dots.v, x_5) = vec(0,0,0) \ ~~> {(x_1, dots x_5) | x_1 = -x_3-2x_4, quad x_2 = x_4-x_5} \ 

    ==> Nu(f) = chevron.l
      vec(-1,0,1,0,0), vec(-2,1,0,1,0), vec(0,-1,0,0,1)
    chevron.r \

    ==> dim Nu(f) = 3 \

    "Pero tenemos " underbracket(dim V, =5) = underbracket(dim Nu(f),=3)
  + dim Im(f) ==> dim Im(f) = 2
  $

  #observacion[
    $ f: V-->W and B= {v_1...v_n} "base del" Nu(f) $

    $ ==>$ la extiendo a una ase de $V$ con ${v_(k+1),dots,v_n}$

    $==> {f(v_(k+1)),dots,f(v_n)} subset.eq W$ es una base de $Im(f)$
  ]

  $
  f(e_1) = vec(1,0,1) != 0 in Im(f)
    = f(e_1) != f(e_2) = vec(1,1,0)
  $

  y tenemos ${f(e_1),f(e_2)} subset.eq Im(f)$ son L.I. y $chevron.l f(e_1), f(e_2) chevron.r$
]

#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#definicion[Matriz de representación][
  $ f: V--> W $

Considero $B = {v_1,dots,v_n} subset.eq V, B'={w_1, dots, w_n} subset.eq W$ bases

#align(center)[#diagram(cell-size: 15mm, $
	V edge(f, ->) edge("d", [dot]_B, ->) & W edge("d",[dot]_B', ->)\ 
	KK^n edge("r", A_f, ->) & KK^m
$)]

$ ==> A_f = mat(dots.v,dots.v;[f(v_1)]_B',[f(v_n)]_B';dots.v,dots.v) = [f]_(B B') $

  *Re ver esto, hasta ahi entendi*

   *...*

  $ ==> [f]_(B B') = C_(B B') $


  $
    C_(B B') = mat(dots.v,dots.v;[(1,0)_B'],[(0,1)]_B';dots.v,dots.v) = mat(1,0;2,-1)
  $

  Vale: $ B_1, B_2, B_3, B_4 subset.eq V "base de" V $

  $
    [f]_(B_3 B_4) = underbracket(C_(B_2 B_4) [f]_(B_1 B_2),[f]_(B_1 B_4)) C_(B_3 B_1)
  $
]

#ejercicio(is-proof:false)[][
  Sean $B,B' subset.eq CC^3$ bases y $f: CC^3 --> CC^3$


  Y sabemos:
  $
    [f]_B = [f]_(B B) = mat(i,0,1+2i;0,0,3;-1,2,i) \

    C_(B' B) = mat(2,3,0;1,0,0;0,1,2i)
  $

a. Hallar $[f]_B' = [f]_(B'B')$

b. F es isomorf.? Si sí, hallar $[f^(-1)]_B$
][

  *a.*

  $ [f]_(B' B') = C_(B B') [f]_(B B) C_(B' B) = (C_(B' B))^(-1)$

  *b.*

  #observacion[
    $f: V->W$ isomorfismo $<==> [f]_(B B') in KK^(n times n)$ inversa
  ]
  $
    [f^(-1)]_(B B) = ???
  $

  #observacion[
    $
      [f]_(B_1 B_2) [g]_(B_3 B_1) = [f compose g]_(B_3 B_2) \ \

      g = f^(-1) ==> [f]_(B_1 B_2) [f^(-1)]_(B_3 B_1) = [id]_(B_3 B_2) = C_(B_3 B_2)
    $
  ]

  $
    [f^(-1)]_(B B) = ([f]_(B B))^(-1) C_(B B) = ([f]_(B B'))^(-1)
  $
]
