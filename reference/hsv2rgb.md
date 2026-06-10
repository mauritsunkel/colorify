# hsv to rgb color space

Expects hsv color values to be in range (0-100\])

## Usage

``` r
hsv2rgb(h, s, v, maxColorValue = 100)
```

## Arguments

- h:

  numeric, vector of ‘hue’ values

- s:

  numeric, vector of ‘saturation’ values

- v:

  numeric, vector of ‘value’ (lightness) values

- maxColorValue:

  numeric, default: 100, gives the maximum hsv color values range.
  Default corresponds to the typical 0:1 HSV coding as in
  [`rgb2hsv()`](https://rdrr.io/r/grDevices/rgb2hsv.html)

## Value

unnamed dataframe with rgb colors

## Examples

``` r
colors <- colorify(5)
#> 5 colors generated
rgb <- grDevices::col2rgb(colors)
hsv <- grDevices::rgb2hsv(rgb, maxColorValue = 255)
rgb2 <- hsv2rgb(hsv['h',], hsv['s',], hsv['v',], maxColorValue = 255)
```
