// NOTE: color theme
#let uOrange = rgb("#DD4814")
#let dBlue = rgb("#5fffff")
#let primary = rgb("#F5F5EA")
#let secondary = rgb("#cccccc")

#let darkTheme(
  par-indent: 1em,
  doc
) = {
  set page(fill: rgb("#0d1117"))
  set text(
    fill: secondary,
    font: "Ubuntu Nerd Font",
    hyphenate: false
  )
  set enum(
    numbering: n => text(fill: primary)[#n.],
    // number-align: start + top,
  )
  show heading: h => {
    show text: t => {
      if h.depth == 1 {
        text(fill: uOrange,size: 1.5em, t)
        // text(fill: uOrange, t)
      } else if h.depth == 2 {
        underline(stroke: uOrange, text(fill: primary, size: 1.2em, t))
        // underline(stroke: uOrange, text(fill: primary, t))
      }
      else {
        text(fill: dBlue, t)
      }
    }

    h
    linebreak()
  }

  set par(
    justify: true,
    first-line-indent: (
      amount: par-indent, all:true
    ),
  )


  // show: doc => doc;
  doc
}

