# Hex code colors to rgba format

Hex code colors to rgba format

## Usage

``` r
hex2rgba(hex, alpha = NULL)
```

## Arguments

- hex:

  character (vector), hexcode colors (e.g. \#FFFFFF)

- alpha:

  numeric in range (0-1), default: NULL to use full opacity or given
  opacity (AA) in hex (#RRGGBBAA)

## Value

colors in rgba format

## Examples

``` r
colors <- colorify(5)
#> 5 colors generated
hex2rgba(colors)
#> [1] "rgba(233,132,116,1)" "rgba(238,187,183,1)" "rgba(72,34,238,1)"  
#> [4] "rgba(211,167,65,1)"  "rgba(163,179,117,1)"
hex2rgba(colors, alpha = .5)
#> [1] "rgba(233,132,116,0.5)" "rgba(238,187,183,0.5)" "rgba(72,34,238,0.5)"  
#> [4] "rgba(211,167,65,0.5)"  "rgba(163,179,117,0.5)"
colors <- gsub('FF$', 75, colors)
hex2rgba(colors)
#> [1] "rgba(233,132,116,0.458823529411765)" "rgba(238,187,183,0.458823529411765)"
#> [3] "rgba(72,34,238,0.458823529411765)"   "rgba(211,167,65,0.458823529411765)" 
#> [5] "rgba(163,179,117,0.458823529411765)"
hex2rgba(colors, alpha = .5)
#> [1] "rgba(233,132,116,0.5)" "rgba(238,187,183,0.5)" "rgba(72,34,238,0.5)"  
#> [4] "rgba(211,167,65,0.5)"  "rgba(163,179,117,0.5)"
```
