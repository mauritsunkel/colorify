#' hsv to rgb color space
#'
#' @param h numeric, vector of ‘hue’ values
#' @param s numeric, vector of ‘saturation’ values
#' @param v numeric, vector of ‘value’ (lightness) values
#' @param maxColorValue numeric, default: 100, gives the maximum hsv color values range. Default corresponds to the typical 0:1 HSV coding as in `rgb2hsv()`
#'
#' @return unnamed dataframe with rgb colors
#' 
#' @description Expects hsv color values to be in range [0-1]
#' 
#' @export
#' 
#' @examples
#' colors <- colorify(5)
#' rgb <- col2rgb(colors)
#' hsv <- rgb2hsv(rgb, maxColorValue = 255)
#' rgb2 <- hsv2rgb(hsv['h',], hsv['s',], hsv['v',], maxColorValue = 255)
hsv2rgb <- function(h, s, v, maxColorValue = 100) {
  h <- h * 360 # convert hue from [0, 1] to degrees [0, 360]
  c <- v * s # chroma: color intensity
  x <- c * (1 - abs((h / 60) %% 2 - 1)) # position color on rgb spectrum
  ## hue degrees sector index
  i1 <- h >= 0 & h < 60
  i2 <- h >= 60 & h < 120
  i3 <- h >= 120 & h < 180
  i4 <- h >= 180 & h < 240
  i5 <- h >= 240 & h < 300
  i6 <- h >= 300 & h <= 360
  ## Initialize r, g, b as zero vectors of the same length as h
  r <- numeric(length(h))
  g <- numeric(length(h))
  b <- numeric(length(h))
  ## assigns values by index
  r[i1] <- c[i1]; g[i1] <- x[i1]  # red to yellow
  r[i2] <- x[i2]; g[i2] <- c[i2]  # yellow to green
  g[i3] <- c[i3]; b[i3] <- x[i3]  # green to cyan
  g[i4] <- x[i4]; b[i4] <- c[i4]  # cyan to blue
  r[i5] <- x[i5]; b[i5] <- c[i5]  # blue to magenta
  r[i6] <- c[i6]; b[i6] <- x[i6]  # magenta to red
  ## shift values to equate brightest
  m <- v - c # shift brightness by chroma
  r <- r + m
  g <- g + m
  b <- b + m
  return(rbind(r, g, b) * maxColorValue) # scale by maxColorValue
}
