#import "@preview/theorion:0.6.0": *
#import "@preview/quick-maths:0.2.1": shorthands

#import cosmos.fancy: *

#show: show-theorion

#set text(lang: "es")



#show: shorthands.with(
  ($!<$, $chevron.l$),
  ($!>$, $chevron.r$),
)

= TL;DR

- Def. de e.v. y subespacio
- Sist de generadores
- Suma de subespacios
#line()
- Inclusion
- INterseccion de subepsacios


== Inclusion de usbepsacios


Sean $S$ y $T$ dos subespacios de $KK$ e.v. $V$,
$S subset.eq T$ si para todo $s in S$ se cumple que $S in T$

#property[
  Sea $S = !< s_1,...,s_n !>$ y $T$ subespacios $S subset.eq T <==> s_i in T$ para todo $i = 1...n$
]


#proof[

  $<==)$

  Sea $s$ cualquier elemento de $S$ entonces $exists alpha_1,..., alpha_n | s = alpha_1 s_1 +...+ alpha_n s_n $

  Por hipotesis, $s_i in T =>$ toda combinación lineal de los $s_i$ también está en $T => s = alpha_1 s_1 +...+ alpha_n s_n in T => S subset.eq T$


  $==>)$

  Si $S subset.eq T =>$ qvq $s_i in T$

  asumo $S subset.eq T =>$ todo elemento de $S$ está en $T$ en particular, cada $s_i in T$

]

== Intersección de subespacios

Dado $V$ un $KK-"e.v."$ con $S$ y $T$ subespacios.


Buscamos un subespacio que contenga a los elementos en comun de $S$ y $T$

$S inter T = {v in V: space v in S and v in T}$

#example[$
  S={(x_1,x_2,x_3) in RR^3: x_1+2x_2=0} \

  T={(x_1,x_2,x_3) in RR^3: x_1-x_3} \

  S inter T = {(x_1,x_2,x_3) in RR^3: x_1+2x_2=0, x_1-x_3=0}\

  S: x_1=-2x_2 -> (-2x_2,x_2,x_3) = (-2,1,0) x_2 + (0,0,1)x_3\

  S = !< (-2,1,0),(0,0,1) !>
$

Un elemento generico de $S$ es $a(-2,1,0)+b(0,0,1)$ para cualquier $a,b in RR$

Veamos para que valores de $a,b$ también está en $T$

$S=(-2,a,a,b)$ verifico que esté en $T$:

$-2a-b=0 -> b=-2a$

reemplazo: $ &(-2,1,0) + (-2a)(0,0,1) \

&= (-2a,a,0) + (0,0,-2a) \

&= (-2a,a,-2a) in S inter T \

&= a(-2,1,-2) = !< (-2,1,-2) !> forall a in RR

$

#line()

Veamos usando las ecuaciones:
$
cases(
  x_1+2x_2&=0,
  x_1-x_3&=0 
)
= mat(1,2,0;1,0,-1) mat(x_1;x_2;x_3) = mat(0;0)
$
]

#example(title: "independencia lineal")[
  $
  S = !< (0,0,1),(0,1,1) !> = !< (0,0,1),(0,1,1),(0,2,2) !> \

  = !< (0,0,1),(0,1,0) !> 
  

  $
]

#definition[
  Dado $V$ un $KK$ e.v. UN conjunto ${v_1...v_n}$ es linealmente independiente si
  $alpha_1 v_1 + ... + alpha_2 v_2 + ... + alpha_n v_n = 0^(->) ==> alpha_1 = alpha_2 =...= alpha_n = 0$ con $alpha_i in KK$

  Decimos que un conjkunto es linealmente independiente si no es L.I.

]

#example[
  $
    S= { (1,0,2),(1,-2,-2),(1,-1,0) }
  $

  Y tenemos: $(1,-2,-2) = 2(1,-1,0)+(-1)(1,0,2)$

  Me armo por ejemplo:

  $(-1)(1,0,2)+(-1)(1,-2,-2)+2(1,-1,0)=(0,0,0)$

  $ ==>$ es L.D. pues $alpha_1 v_1+alpha_2 v_2 +alpha_3 v_3 = 0^(->)$

]

#example[
  $T={v_1,v_2,v_3,0}$

  planteo una combinacion lineal:

  $alpha_1 v_1 + alpha_2 v_2+ alpha_3 v_3+ alpha_4 0^(->) = 0^(->)$

  Puedo setear

  $ alpha_1 = alpha_2 = alpha_3 = 0 and alpha_4=0$

  $==>$ siempre es L.D. dado que contiene al vector $0$

  #line()

  planteo:

  $a(1,0,2)+b(1,-2,-2)+c(1,-1,0) = (0,0,0)$

  $mat(1,1,1;0,-2,-1;2,-2,0) mat(a;b;c) = mat(0;0;0)$

  $
  mat(
    1, 1, 1;
    0, -2, -1;
    2, -2, 0
  ) ->_(f_3-2f_1 -> f_3)

  mat(
    1, 1, 1;
    0, -2, -1;
    0, -4, -2
  ) ->_()

  mat(1,1,1;
  0,-2,-1;
  0,0,0)

  $

Esto no solo vale con los vectores como columnas, también como filas.

Y yo puedo decir que cada fila viene de una combinacion lineal

]

#theorem[
  Sean vectores $v_1...v_k in KK^n$

  ${v_1...v_n}$ es L.D. $<==>$ al menos uno de los vectores se peude escribir como combinacion lineal del resto.
]

#proof[
  $==>)$

  ${v_1...v_k}$ es L.D. $=>$ por definición $alpha_1 v_1 + ... + alpha_k v_k = 0$

  donde no todos son nulos a la vez (i.e. existe algún $alpha_i != 0$)

  $ alpha_i v_i = - sum_(j=1\ j!=i)^k alpha_j v_j ==>_(alpha_i != 0) v_i = - sum_(j=1 \ j!= i)^k alpha_j / alpha_i v_j ==> v_i "es combinacion lineal del resto" $

  $<==)$

  $ v_i = sum_(j=1 \ j!=i)^k alpha_j v_j $

  $ 0 = sum_(j=1 \ j!=i)^k alpha_j v_j + (-1) v_i ==> {v_1...v_k} "es L.D." $


  
]


#property("escritura única")[
  Sea $V$ un $KK-"e.v."$ y $!< v_1...v_n !>$ un conjunto L.I.
  Entonces cualquier $w in !< v_1...v_n !>$ se escribe de forma única como combinacion lineal de $v_1...v_n$

  
]

#proof("unicidad")[
  Supongamos que existen dos combinaciones lineales que dan $w$

  Entonces tenemos una combinacion $w= alpha_1 v_1+..+ alpha_n v_n$

  Pero tambien tenemos $w= beta_1 v_1+...+ beta_n v_n$

  Igualamos y agrupamos:

  $alpha_1 v_1 +...+ alpha_n v_n = beta_1 v_1 +...+ beta_n v_n$

  $(alpha_1-beta_1) v_1 + (alpha_2-beta_2) v_2+...+ (alpha_n-beta_n) v_n = 0$

  
  Pero ${v_1...v_n}$ es L.I. $==>$

  $alpha_i-beta_i = 0 -> alpha_i = beta_i space forall 1<=i<=n$

  Entonces osn iguales, absurdo.
]


#definition[
  Sea $V$ un $KK-"e.v."$

  - El conjunto ${v_1...v_n}$ se dice base $V= !< v_1...v_n !>$
  - ${v_1...v_n}$ es L.I.

  (es decir, el conjunto ${v_1...v_n}$ es un sistema de generadores de $V$)
]


  Nota: A la cantidad de elementos de una base lo llamamos dimensión


#example[
  En $RR^2. {(1,0)(0,1)}, {(1,1),(1,0)}$ son base
]

#theorem[

  Sean $B={v_1...v_n} and B^(bowtie) = {w_1..w_r}$ dos bases de un $V, KK-"e.v."$ luego $m=n$.
]

#lemma[
 Dado $V$ un $KK-"e.v."$ si ${v_1..v_n}$ es generador de $V$ y ${w_1...w_s} subset.eq V$ es L.I. $==> r >= s$
]

#proof[
  Si $B$ es un conjunto de generadores de $V$ y $B^bowtie$ un conjunto L.I. por lema $n >= m$
  
  y si $B^bowtie$ es un conjunto de generadores de $V$ y $B$ es un conjunto L.I. por lema, $m>=n$

  $==>$ deducimos que $m=n$ 
  
]

Si tenemos un conjunto de generadores siempre nos podemos contruir una base y si tenemos un conjunto de bases siempre lo podemos extender a un conjunto de generadores


#property[
  Sea $V$ un $KK-"e.v."$ de dimensión $n$ y $S$ un conjunto de generadores de $V$ de $m$ elementos tal 
que $m>n$

Entonces podemos extraer un subconjunto $B$ de $n$ elementos de $S$ que sea una base

$S ={v_1...v_m}$

Si $w_m$ es combinacion lineal de $v_1..v_(m-1)$

$ !< v_1...v_m !> = !< v_1...v_(m-1) !> $
]


#property[
  Sea $V$ un $KK-"e.v."$ de dimension $n$ y $L={v_1...v_r}$ un conjunto L.I. ($r<=n$)

  $ ==> exists w_(r+1),...,w_n in V | B={v_1...v_r w_(r+1)...w_n} $

#example[
  ${(1,1,1,0)(1,0,0,2)} = L$ tomo $v in.not !< v_1...v_n !>$

Podria ponerlos en fila y triangular:

$ mat(1,1,1,0;1,1,0,2) »»» mat(1,1,1,0;0,1,0,0;0,0,-1,2;0,0,0,1) $
]

]
