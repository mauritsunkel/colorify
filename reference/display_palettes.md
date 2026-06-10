# Display R grDevices palettes

Use
[`colorify`](https://mauritsunkel.github.io/colorify/reference/colorify.md)
to select and modify the palettes. Note that discrete palettes with
maximum n colors will be repeated in plotting.

Any numeric i_palettes over maximum amount of palettes are not
displayed.

Contains all Viridis palettes, including Turbo.

## Usage

``` r
display_palettes(n = 10, i_palettes = 1:1000, border = FALSE)
```

## Arguments

- n:

  integer, amount of colors to display

- i_palettes:

  default: numeric vector as index/range for choosing palettes, or a
  combination of 'rcolorbrewer', 'viridis', 'rainbow' (grDevices
  Palettes) to show specific palettes

- border:

  default: FALSE, if TRUE show color rectangle borders

## Value

named vector with source and name of palettes, 'hcl' for
grDevices::hcl.pals() and 'pal' for grDevices::palette.pals()

## See also

Browse vignettes with `vignette("Introduction to coloRify")`

## Examples

``` r
display_palettes()

#>     Viridis-turbo         grDevices         grDevices         grDevices 
#>           "Turbo"         "Rainbow"            "Heat"         "Terrain" 
#>         grDevices         grDevices               hcl               hcl 
#>            "Topo"              "Cm"        "Pastel 1"          "Dark 2" 
#>               hcl               hcl               hcl               hcl 
#>          "Dark 3"           "Set 2"           "Set 3"            "Warm" 
#>               hcl               hcl               hcl               hcl 
#>            "Cold"        "Harmonic"         "Dynamic"           "Grays" 
#>               hcl               hcl               hcl               hcl 
#>     "Light Grays"         "Blues 2"         "Blues 3"       "Purples 2" 
#>               hcl               hcl               hcl               hcl 
#>       "Purples 3"          "Reds 2"          "Reds 3"        "Greens 2" 
#>               hcl               hcl               hcl               hcl 
#>        "Greens 3"            "Oslo"     "Purple-Blue"      "Red-Purple" 
#>               hcl               hcl               hcl               hcl 
#>        "Red-Blue"   "Purple-Orange"   "Purple-Yellow"     "Blue-Yellow" 
#>               hcl               hcl               hcl               hcl 
#>    "Green-Yellow"      "Red-Yellow"            "Heat"          "Heat 2" 
#>               hcl               hcl               hcl               hcl 
#>         "Terrain"       "Terrain 2"         "Viridis"          "Plasma" 
#>               hcl               hcl               hcl               hcl 
#>         "Inferno"          "Rocket"            "Mako"       "Dark Mint" 
#>               hcl               hcl               hcl               hcl 
#>            "Mint"          "BluGrn"            "Teal"         "TealGrn" 
#>               hcl               hcl               hcl               hcl 
#>           "Emrld"           "BluYl"        "ag_GrnYl"           "Peach" 
#>               hcl               hcl               hcl               hcl 
#>          "PinkYl"            "Burg"          "BurgYl"           "RedOr" 
#>               hcl               hcl               hcl               hcl 
#>           "OrYel"            "Purp"          "PurpOr"          "Sunset" 
#>               hcl               hcl               hcl               hcl 
#>         "Magenta"      "SunsetDark"       "ag_Sunset"          "BrwnYl" 
#>               hcl               hcl               hcl               hcl 
#>          "YlOrRd"          "YlOrBr"            "OrRd"         "Oranges" 
#>               hcl               hcl               hcl               hcl 
#>            "YlGn"          "YlGnBu"            "Reds"            "RdPu" 
#>               hcl               hcl               hcl               hcl 
#>            "PuRd"         "Purples"          "PuBuGn"            "PuBu" 
#>               hcl               hcl               hcl               hcl 
#>          "Greens"            "BuGn"            "GnBu"            "BuPu" 
#>               hcl               hcl               hcl               hcl 
#>           "Blues"         "Lajolla"           "Turku"          "Hawaii" 
#>               hcl               hcl               hcl               hcl 
#>          "Batlow"        "Blue-Red"      "Blue-Red 2"      "Blue-Red 3" 
#>               hcl               hcl               hcl               hcl 
#>       "Red-Green"    "Purple-Green"    "Purple-Brown"     "Green-Brown" 
#>               hcl               hcl               hcl               hcl 
#>   "Blue-Yellow 2"   "Blue-Yellow 3"    "Green-Orange"    "Cyan-Magenta" 
#>               hcl               hcl               hcl               hcl 
#>          "Tropic"            "Broc"            "Cork"             "Vik" 
#>               hcl               hcl               hcl               hcl 
#>          "Berlin"          "Lisbon"          "Tofino"        "ArmyRose" 
#>               hcl               hcl               hcl               hcl 
#>           "Earth"            "Fall"          "Geyser"        "TealRose" 
#>               hcl               hcl               hcl               hcl 
#>           "Temps"            "PuOr"            "RdBu"            "RdGy" 
#>               hcl               hcl               hcl               hcl 
#>            "PiYG"            "PRGn"            "BrBG"          "RdYlBu" 
#>               hcl               hcl               hcl               hcl 
#>          "RdYlGn"        "Spectral"        "Zissou 1"         "Cividis" 
#>               hcl               pal               pal               pal 
#>            "Roma"              "R3"              "R4"         "ggplot2" 
#>               pal               pal               pal               pal 
#>       "Okabe-Ito"          "Accent"          "Dark 2"          "Paired" 
#>               pal               pal               pal               pal 
#>        "Pastel 1"        "Pastel 2"           "Set 1"           "Set 2" 
#>               pal               pal               pal               pal 
#>           "Set 3"      "Tableau 10" "Classic Tableau"   "Polychrome 36" 
#>               pal 
#>        "Alphabet" 
display_palettes(i_palettes = 50:75)

#>          hcl          hcl          hcl          hcl          hcl          hcl 
#>      "BluYl"   "ag_GrnYl"      "Peach"     "PinkYl"       "Burg"     "BurgYl" 
#>          hcl          hcl          hcl          hcl          hcl          hcl 
#>      "RedOr"      "OrYel"       "Purp"     "PurpOr"     "Sunset"    "Magenta" 
#>          hcl          hcl          hcl          hcl          hcl          hcl 
#> "SunsetDark"  "ag_Sunset"     "BrwnYl"     "YlOrRd"     "YlOrBr"       "OrRd" 
#>          hcl          hcl          hcl          hcl          hcl          hcl 
#>    "Oranges"       "YlGn"     "YlGnBu"       "Reds"       "RdPu"       "PuRd" 
#>          hcl          hcl 
#>    "Purples"     "PuBuGn" 

display_palettes(i_palettes = 'RColorBrewer')

#>        hcl        hcl        hcl        hcl        hcl        hcl        hcl 
#>     "BrBG"     "PiYG"     "PRGn"     "PuOr"     "RdBu"     "RdGy"   "RdYlBu" 
#>        hcl        hcl        pal        hcl        pal        hcl        pal 
#>   "RdYlGn" "Spectral"   "Accent"   "Dark 2"   "Paired" "Pastel 1" "Pastel 2" 
#>        pal        hcl        hcl        hcl        hcl        hcl        hcl 
#>    "Set 1"    "Set 2"    "Set 3"    "Blues"     "BuGn"     "BuPu"     "GnBu" 
#>        hcl        hcl        hcl        hcl        hcl        hcl        hcl 
#>   "Greens"    "Grays"  "Oranges"     "OrRd"     "PuBu"   "PuBuGn"     "PuRd" 
#>        hcl        hcl        hcl        hcl        hcl        hcl        hcl 
#>  "Purples"     "RdPu"     "Reds"     "YlGn"   "YlGnBu"   "YlOrBr"   "YlOrRd" 
display_palettes(i_palettes = 'Viridis')

#>           hcl           hcl           hcl           hcl           hcl 
#>     "Viridis"      "Plasma"     "Inferno"     "Cividis"      "Rocket" 
#>           hcl Viridis-turbo 
#>        "Mako"       "Turbo" 
display_palettes(i_palettes = c("rainbow", "viridis"))

#>     grDevices     grDevices     grDevices     grDevices     grDevices 
#>     "Rainbow"        "Heat"     "Terrain"        "Topo"          "Cm" 
#>           hcl           hcl           hcl           hcl           hcl 
#>     "Viridis"      "Plasma"     "Inferno"     "Cividis"      "Rocket" 
#>           hcl Viridis-turbo 
#>        "Mako"       "Turbo" 

display_palettes(i_palettes = c(1,5,10,20,40,100,119))

#> Viridis-turbo     grDevices           hcl           hcl           hcl 
#>       "Turbo"        "Topo"       "Set 2"   "Purples 2"      "Plasma" 
#>           hcl           hcl 
#>         "Vik"    "Zissou 1" 
display_palettes(n = 100, i_palettes = 1:10)

#> Viridis-turbo     grDevices     grDevices     grDevices     grDevices 
#>       "Turbo"     "Rainbow"        "Heat"     "Terrain"        "Topo" 
#>     grDevices           hcl           hcl           hcl           hcl 
#>          "Cm"    "Pastel 1"      "Dark 2"      "Dark 3"       "Set 2" 
display_palettes(n = 10, i_palettes = 1:10, border = TRUE)

#> Viridis-turbo     grDevices     grDevices     grDevices     grDevices 
#>       "Turbo"     "Rainbow"        "Heat"     "Terrain"        "Topo" 
#>     grDevices           hcl           hcl           hcl           hcl 
#>          "Cm"    "Pastel 1"      "Dark 2"      "Dark 3"       "Set 2" 
```
