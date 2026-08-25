#import "@preview/ergo:0.2.0": *
#import "@preview/physica:0.9.8": *
#import "@preview/equate:0.3.3": equate

#import "colors.typ": *
#import "macros.typ": *

#let plantilla-alc(titulo: "",dark: false, doc) = {

  let selected-theme = if dark {
    ergo-colors.dracula-dc-dark
  } else {
    ergo-colors.dracula-dc
  }
  show: ergo-init.with(
    colors: selected-theme,
    styles: ergo-styles.sidebar1
  )

  set page(
    width: 18cm,
    height: 21.7cm,
    margin: 1em
  )
  
  set document(title: titulo)
  set text(font: "New Computer Modern", size: 11pt)
  set heading(numbering: "1.1.")
  
  show math.equation: equate.with(
    breakable: true, 
    sub-numbering: true, 
    number-mode: "line"
  )

  doc
}

//-----Preset Solution Environments-----//
#let teorema     = ergo-solution.with(
  [Teorema],
  "theorem",
  true
)

#let lema       = ergo-solution.with(
  [Lema],
  "lemma",
  true
)

#let corolario   = ergo-solution.with(
  [Corolario],
  "corollary",
  true
)

#let proposicion = ergo-solution.with(
  [Proposición],
  "proposition",
  true
)

#let problema     = ergo-solution.with(
  [Problema],
  "problem",
  false
)

#let ejercicio    = ergo-solution.with(
  [Ejercicio],
  "exercise",
  true
)






//-----Preset Statement Environments-----//
#let nota                  = ergo-statement.with(
  [Nota],
  "note"
)

#let definicion            = ergo-statement.with(
  [Definición],
  "definition"
)

#let observacion                = ergo-statement.with(
  [Observación],
  "remark"
)

#let notacion              = ergo-statement.with(
  [Notación],
  "notation"
)

#let ejemplo               = ergo-statement.with(
  [Ejemplo],
  "example"
)

#let concepto               = ergo-statement.with(
  [Concepto],
  "concept"
)

#let algoritmo             = ergo-statement.with(
  [Algoritmo],
  "algorithm"
)

