# coloRify scale color bindings for ggplot2

for rest and default coloRify parameters see
[`colorify`](https://mauritsunkel.github.io/colorify/reference/colorify.md)

## Usage

``` r
scale_color_colorify(
  ...,
  aesthetics = "color",
  discrete = FALSE,
  nn = Inf,
  n = 2,
  colors = character(0),
  colors_lock = NULL,
  hf = 1,
  sf = 1,
  lf = 1,
  rf = 1,
  gf = 1,
  bf = 1,
  hv = 0,
  sv = 0,
  lv = 0,
  rv = 0,
  gv = 0,
  bv = 0,
  hmin = 0,
  smin = 0,
  lmin = 0,
  rmin = 0,
  gmin = 0,
  bmin = 0,
  hmax = 100,
  smax = 100,
  lmax = 100,
  rmax = 100,
  gmax = 100,
  bmax = 100,
  alpha = 1,
  seed = 42,
  order = 1,
  verbose = TRUE
)

scale_colour_colorify(
  ...,
  aesthetics = "color",
  discrete = FALSE,
  nn = Inf,
  n = 2,
  colors = character(0),
  colors_lock = NULL,
  hf = 1,
  sf = 1,
  lf = 1,
  rf = 1,
  gf = 1,
  bf = 1,
  hv = 0,
  sv = 0,
  lv = 0,
  rv = 0,
  gv = 0,
  bv = 0,
  hmin = 0,
  smin = 0,
  lmin = 0,
  rmin = 0,
  gmin = 0,
  bmin = 0,
  hmax = 100,
  smax = 100,
  lmax = 100,
  rmax = 100,
  gmax = 100,
  bmax = 100,
  alpha = 1,
  seed = 42,
  order = 1,
  verbose = TRUE
)
```

## Arguments

- ...:

  additional parameters passed to
  [`colorify`](https://mauritsunkel.github.io/colorify/reference/colorify.md),
  [`discrete_scale`](https://ggplot2.tidyverse.org/reference/discrete_scale.html)
  and/or
  [`scale_color_gradientn`](https://ggplot2.tidyverse.org/reference/scale_gradient.html)

- aesthetics:

  string, default: 'color', see
  [`discrete_scale`](https://ggplot2.tidyverse.org/reference/discrete_scale.html)
  and
  [`scale_color_gradientn`](https://ggplot2.tidyverse.org/reference/scale_gradient.html)
  for more aesthetics

- discrete:

  boolean, default = FALSE (calls
  [`scale_color_gradientn`](https://ggplot2.tidyverse.org/reference/scale_gradient.html)),
  else TRUE (calls
  [`discrete_scale`](https://ggplot2.tidyverse.org/reference/discrete_scale.html))

- nn:

  integer, default: Inf, length of gradients, if Inf then set to 256

- n:

  integer, default: 2, amount of colors(/gradients) to return, only
  works if not discrete

- colors:

  character (vector), combination of selecting palette(s) by name
  (options: see display_palettes()), and/or vector of R color names
  and/or color hexcodes

- colors_lock:

  numeric/boolean, default: NULL, numerical or logical index of colors
  (not) to be modified, if logical length != colors it will be cut or
  filled with TRUE/FALSE, prefix with '!' for logical vectors and '-'
  for numerical vectors to get inverse, see examples. If nn %%
  length(colors) == 0, i.e. if nn divisive by amount of colors without
  rest, set repeat given locking pattern

- hf:

  hue factor, default: 1, multiply values by factor, proportional to
  base value of 1

- sf:

  saturation factor, default: 1, multiply values by factor, proportional
  to base value of 1

- lf:

  lightness/brightness factor, default: 1, multiply values by factor,
  proportional to base value of 1

- rf:

  red factor, default: 1, multiply values by factor, proportional to
  base value of 1

- gf:

  green factor, default: 1, multiply values by factor, proportional to
  base value of 1

- bf:

  blue factor, default: 1, multiply values by factor, proportional to
  base value of 1

- hv:

  hue value, default: 0, add value to values, linear from base value of
  0 to a maximum value of 100

- sv:

  saturation value, default: 0, add value to values, linear from base
  value of 0 to a maximum value of 100

- lv:

  lightness/brightness value, default: 0, add value to values, linear
  from base value of 0 to a maximum value of 100

- rv:

  red value, default: 0, add value to values, linear from base value of
  0 to a maximum value of 100

- gv:

  green value, default: 0, add value to values, linear from base value
  of 0 to a maximum value of 100

- bv:

  blue value, default: 0, add value to values, linear from base value of
  0 to a maximum value of 100

- hmin:

  hue minimum threshold, default: 0, expected range (0, 100)

- smin:

  saturation minimum threshold, default: 0, expected range (0, 100)

- lmin:

  lightness/brightness minimum threshold, default: 0, expected range (0,
  100)

- rmin:

  red minimum threshold, default: 0, expected range (0, 100)

- gmin:

  green minimum threshold, default: 0, expected range (0, 100)

- bmin:

  blue minimum threshold, default: 0, expected range (0, 100)

- hmax:

  hue maximum threshold, default: 0, expected range (0, 100)

- smax:

  saturation maximum threshold, default: 0, expected range (0, 100)

- lmax:

  lightness/brightness maximum threshold, default: 0, expected range (0,
  100)

- rmax:

  red maximum threshold, default: 0, expected range (0, 100)

- gmax:

  green maximum threshold, default: 0, expected range (0, 100)

- bmax:

  blue maximum threshold, default: 0, expected range (0, 100)

- alpha:

  numeric, sets color alpha values

- seed:

  integer, default: 42, set seed for generation of colors (n \> given
  colors (palettes)) and colors ordering (see order)

- order:

  default: 1, numeric (vector) to adjust colors order, -1: reverse
  order, 0: seeded random order, \>1: shift order, c(-1, \>1): reverse
  then shift order, or numeric vector as many colors to set custom order
  (if longer, vector shortened to n colors)

- verbose:

  default: TRUE, mentions if and how many colors are generated

## Value

sets colors in ggplot2 plotted object, see examples

## See also

`vignette("Introduction to coloRify")`

## Examples

``` r
## viridis ggplot2 examples Colorified 

## non-discrete
if (requireNamespace("ggplot2", quietly = TRUE)) {
  dsub <- subset(ggplot2::diamonds, x > 5 & x < 6 & y > 5 & y < 6)
  dsub$diff <- with(dsub, sqrt(abs(x - y)) * sign(x - y))

  d <- ggplot2::ggplot(dsub, ggplot2::aes(x, y, colour = diff)) + ggplot2::geom_point()
    d + scale_color_colorify(n = 4, colors = 'viridis') + ggplot2::theme_bw()


## discrete

  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg))
  p + ggplot2::geom_point(size = 4, ggplot2::aes(colour = factor(cyl))) +
    ggplot2::theme_bw() + scale_color_colorify(discrete = TRUE, colors = c('red', 'blue', 'yellow'))
}
```
