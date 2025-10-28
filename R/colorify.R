#### DOCS ----

#' coloRify: creation and modification of color/gradient palettes 
#'
#' Either generate theoretically maximally different colors, select an available R grDevices palette and/or modify the colors of the given gradient/palette
#'
#' @param n integer, default: NULL, else amount of colors to get, if palette selected and more colors requested they will be generated
#' @param nn integer (vector), default: n, else amount(s) of colors to output as gradient(s), after completing palette for n colors, if Inf return a callable function(n) generating colors
#' @param colors/colours character (vector), combination of selecting palette(s) by name (options: see display_palettes()), and/or vector of R color names and/or color hexcodes
#' @param colors_lock numeric/boolean, default: NULL, numerical or logical index of colors (not) to be modified, if logical length != colors it will be cut or filled with TRUE/FALSE, prefix with '!' for logical vectors and '-' for numerical vectors to get inverse, see examples. If nn %% length(colors) == 0, i.e. if nn divisive by amount of colors without rest, set repeat given locking pattern
#' @param colors_names character, default: character(0), else return named vector of final colors
#' @param colors_map numeric, default numeric(0), else vector of n values for colors to make gradient map between and return function
#' 
#' @param hf hue factor, default: 1, multiply values by factor, proportional to base value of 1
#' @param sf saturation factor, default: 1, multiply values by factor, proportional to base value of 1
#' @param lf lightness/brightness factor, default: 1, multiply values by factor, proportional to base value of 1
#' @param rf red factor, default: 1, multiply values by factor, proportional to base value of 1
#' @param gf green factor, default: 1, multiply values by factor, proportional to base value of 1
#' @param bf blue factor, default: 1, multiply values by factor, proportional to base value of 1
#' 
#' @param hv hue value, default: 0, add value to values, linear from base value of 0 to a maximum value of 100
#' @param sv saturation value, default: 0, add value to values, linear from base value of 0 to a maximum value of 100
#' @param lv lightness/brightness value, default: 0, add value to values, linear from base value of 0 to a maximum value of 100
#' @param rv red value, default: 0, add value to values, linear from base value of 0 to a maximum value of 100
#' @param gv green value, default: 0, add value to values, linear from base value of 0 to a maximum value of 100
#' @param bv blue value, default: 0, add value to values, linear from base value of 0 to a maximum value of 100
#' 
#' @param hmin hue minimum threshold, default: 0, expected range (0, 100)
#' @param smin saturation minimum threshold, default: 0, expected range (0, 100)
#' @param lmin lightness/brightness minimum threshold, default: 0, expected range (0, 100)
#' @param rmin red minimum threshold, default: 0, expected range (0, 100)
#' @param gmin green minimum threshold, default: 0, expected range (0, 100)
#' @param bmin blue minimum threshold, default: 0, expected range (0, 100)
#' 
#' @param hmax hue maximum threshold, default: 0, expected range (0, 100)
#' @param smax saturation maximum threshold, default: 0, expected range (0, 100)
#' @param lmax lightness/brightness maximum threshold, default: 0, expected range (0, 100)
#' @param rmax red maximum threshold, default: 0, expected range (0, 100)
#' @param gmax green maximum threshold, default: 0, expected range (0, 100)
#' @param bmax blue maximum threshold, default: 0, expected range (0, 100)
#' 
#' @param alpha numeric, sets color alpha values
#' @param seed integer, default: 42, set seed for generation of colors (n > given colors (palettes)) and colors ordering (see order)
#' @param order default: 1, numeric (vector) to adjust colors order, -1: reverse order, 0: seeded random order, >1: shift order, c(-1, >1): reverse then shift order, or numeric vector as many colors to set custom order (if longer, vector shortened to n colors)
#' @param plot default: FALSE, if TRUE or string, plot pie chart of color palette, if 'i' in string then plot image instead of pie,  if 'l' in string plot color index as labels
#' @param export default: FALSE, if TRUE: export = getwd(), if export = "string/", save hexcodes, rgb, and hsl values to export/colorify.csv
#'
#' @returns colorify: vector of color hexcodes
#'
#' @export
#'
#' @description
#' The main colorify function can be used to generate or take colors that can then be modified with the same function call. See the vignette for extended examples. 
#' 
#' Palette names are stripped of whitespace and lowered for name matching. 
#' All RColorBrewer and Viridis palettes are included.
#' All grDevices plotting functions are provided as palettes, simply use: colors = "rainbow", "heat", "terrain", "topo" or "cm".
#' Viridis is recommended for (continuous) color-blind friendly paletets. 
#' Okabe-Ito is recommended for discrete distinct colors (up to 8, generate if more colors are required). 
#' 
#' Addition of values (.v) happens before multiplication with factors (.f). Intuitively, all given values are expected to be within range (0, 100), values will be scaled between (0, 1), as hsv() and rgb2hsv(maxColorValue = 1) require.
#' 
#' Use the ellipsis parameter, '...', to set space and interpolate for grDevices::colorRampPalette()
#' 
#' Note that parameter call order within the function call matters, see examples and vignette. 
#' 
#' @examples
#' ## if parameters identical, change seed to change generation
#' colorify(10, plot = TRUE, seed = 1)
#' colorify(10, plot = TRUE, seed = 42)
#' ## set colors, generate additional up to n
#' colorify(colors = c("red", "white", "blue"), n = 5, plot = TRUE)
#' ## create gradients
#' colorify(colors = c("orange", "red", "white", "blue", "orange"), nn = 100, plot = TRUE)
#' ## paired gradients
#' nn <- c(100, 500, 250)
#' colors <- colorify(colors = colorify(4), nn = nn, plot = T)
#' 
#' ## viridis gradient, lighten and saturate, darken
#' colorify(colors = "viridis", n = 100, plot = TRUE)
#' colorify(colors = "viridis", n = 10, plot = TRUE, l = 1.2, s = 10)
#' colorify(colors = "viridis", n = 10, plot = TRUE, l = .9)
#' TODO doc examples for nn 
#' colorify(colors = colorify(nn = Inf)(10), plot = T) # basically random palette function
#' colorify(colors = colorify(nn = Inf, colors = c('red', 'white'))(10), plot = T)
#' colorify(colors = colorify(nn = Inf, colors = c('red', 'white', 'blue'))(10), plot = T)
#' colorify(colors = colorify(colors = 'viridis', nn = Inf)(50), plot = T)
#' 
#' ## palette selected by name in colors[1], can add colors to selected palette, if n < length, remove colors , if greater generate 
#' colorify(colors = c("Okabe-Ito", "red", "blue", "yellow"), plot = T, n = 10)
#' 
#' ## no adjustments to locked indices 
#' FINAL more examples
#' colorify(colors = "Okabe-Ito", colors_lock = c(F,F,T,T), plot = T, rv = -300)
#' colorify(colors = "Okabe-Ito", colors_lock = c(F,F,T,T), plot = T, rv = 300)
#' 
#' ## colors_lock and inversing
#' colors <- colorify(5)
#' colorify(colors_lock = c(T,T), colors=colors)
#' colorify(colors_lock = ! c(T,F,T), colors=colors)
#' colorify(colors_lock = c(3,4), colors=colors)
#' colorify(colors_lock = - c(3,4), colors=colors)
#' 
#' ## rainbow
#' colorify(colors=grDevices::rainbow(100, s = .5), plot = T)
#' colorify(colors="rainbow", n = 100, sf = .5, plot = T)
#' colorify(colors=grDevices::rainbow(100, v = .5), plot = T)
#' colorify(colors="rainbow", n = 100, lf = .5, plot = T,)
#' colorify(colors=grDevices::rainbow(100, start = .25, end = .75), plot = T)
#' colorify(colors=grDevices::rainbow(100)[25:75], plot = T)
#' 
#' ## order
#' colorify(10, plot = TRUE, order = 1)  # default
#' colorify(10, plot = TRUE, order = 0)  # random
#' colorify(10, plot = TRUE, order = -1) # reverse
#' colorify(10, plot = TRUE, order = -3) # negative shift
#' colorify(10, plot = TRUE, order = 12) # > n
#' 
#' ## call order
#' TODO Note that parameter call order within the function call matters, see examples and vignette: rv = 20 then rf = 1.2 can be different then rf = 1.2 then rv = 20, make examples
#' 
#' ## circlize::colorRamp2  
#' colors_map <- c(-5, 0, 10)
#' colors <- c("red", "white", "blue")
#' if (requireNamespace('circlize')) color_bar <- circlize::colorRamp2(colors_map, colors)(seq(-5, 10, length.out = 100))
#' color_bar <- colorify(colors = colors, colors_map = colors_map, space = "Lab")(seq(-5, 10, length.out = 100)) # circlize::colorRamp2 style
#' image(1:100, 1, as.matrix(1:100), col = color_bar, axes = FALSE, main = "Color Mapping using circlize::colorRamp2")
#' 
#' TODO FINAL rgb, hsl examples (in vignette)
#' TODO FINAL all parameter examples (in)
colorify <- function(
    #### colorify FINAL remove ---- 
    n = NULL, colors = character(0), colours = colors, colors_lock = NULL, colors_names = character(0), colors_map = numeric(0), nn = n,
    hf = 1, sf = 1, lf = 1, rf = 1, gf = 1, bf = 1,
    hv = 0, sv = 0, lv = 0, rv = 0L, gv = 0L, bv = 0L,
    hmin = 0L, smin = 0L, lmin = 0L, rmin = 0L, gmin = 0L, bmin = 0L, 
    hmax = 100L, smax = 100L, lmax = 100L, rmax = 100L, gmax = 100L, bmax = 100L,
    alpha = 1, seed = 42L, order = 1, plot = FALSE, export = FALSE, verbose = TRUE, debug = F, ...) {
  
  colors <- colours
  
  stopifnot(
    is.character(c(colors, colors_names)),
    is.numeric(c(colors_map, hf, sf, lf, rf, gf, bf, hv, sv, lv, rv, gv, bv, alpha, seed, order)),
    is.null(n) | is.numeric(n) | length(n) == 1,
    is.null(nn) | is.numeric(nn),
    is.logical(plot) | is.character(plot),
    is.logical(export),
    is.null(colors_lock) | is.logical(colors_lock) | is.numeric(colors_lock)
  )
  set.seed(round(seed)) # set generation seed
  alpha <- max(0, min(1, alpha)) # set color opacity within range
  nn <- if (is.null(nn)) length(colors) else pmax(0, round(nn)) # set gradient nn within range(s)
  if (nn == Inf & is.null(n)) n <- ifelse(length(colors) > 1, length(colors), 256) # set to return colorRampPalette function
  
  if (debug) print(1)
  
  ## add named palette(s) to colors
  colors <- unname(unlist(sapply(colors, function(color) {
    if (grepl('#', color) | color %in% grDevices::colors()) return(color)
    palette <- palette_name_mapping(color)
    if (nn == Inf & palette != "") n <<- 256 # set to return colorRampPalette function
    if (palette %in% grDevices::palette.pals()) return(grDevices::palette.colors(n = NULL, palette = palette))
    if (is.null(n)) stop("Set n or check color/palette spelling")
    else if (palette %in% grDevices::hcl.pals() & n > 0) grDevices::hcl.colors(n, palette = palette)
    else if (palette == "Turbo") turbo(n) 
    else if (palette == "Rainbow") grDevices::rainbow(n)
    else if (palette == "Heat") grDevices::heat.colors(n)
    else if (palette == "Terrain") grDevices::terrain.colors(n)
    else if (palette == "Topo") grDevices::topo.colors(n)
    else if (palette == "Cm") grDevices::cm.colors(n)
    else color
  })))
  if (debug) print(2)
  n <- ifelse(is.null(n), length(colors), max(0, round(n)))
  if (nn == Inf & length(colors) > n) {
    colors <- colors[1:length(colors)]
  } else if (length(colors) > n) {
    colors <- colors[1:n]
  }

  if (length(colors) < n) {
    if (verbose) message(n - length(colors), " colors generated")
    ## generate random theoretically uniform RGB values and convert to hexcodes
    rgb_matrix <- matrix(runif((n - length(colors)) * 3, min = 0, max = 255), ncol = 3)
    colors <- c(colors, apply(rgb_matrix, 1, function(rgbv) rgb(rgbv[1], rgbv[2], rgbv[3], maxColorValue = 255)))
  }
  if (debug) print(3)
  ## set (paired) gradient colors
  if (length(nn) == 1 & nn[1] > n & ! length(colors_map) > 0 & ! is.infinite(nn)) {
    colors <- grDevices::colorRampPalette(colors, ...)(nn)
  } else if ( ! is.infinite(nn) & length(nn) == length(colors) - 1) {
    colors <- unlist(sapply(seq_len(length(colors) - 1), function(i) grDevices::colorRampPalette(c(colors[i], colors[i+1]), ...)(nn[i])))
  } else if ( ! is.infinite(nn) & length(nn) != 1 && length(nn) != length(colors) - 1) {
    stop('pass single nn or n for each gradient between colors')
  }
  if (debug) print(4)
  if (length(colors) == 0) stop("Input starting color(s), palette name(s), or n colors to generate.")
  
  ## set colors to be modified
  if (is.null(colors_lock)) colors_lock = rep(FALSE, length(colors))
  if (is.infinite(nn)) colors_lock <- integer(0)
  if (is.numeric(colors_lock)) {
    colors_i <- 1:length(colors)
    colors_lock_i <- replace(rep(FALSE, length(colors)), colors_i[colors_lock], TRUE)
  } else { ## if logical
    if (nn[1] > n & nn[1] %% length(colors_lock) == 0) {
      colors_lock_i <- rep(colors_lock, nn[1] / length(colors_lock))
    }
    else if (length(colors_lock) >= length(colors)) {
      colors_lock_i <- colors_lock[1:length(colors)]
    } else {
      colors_lock_bool <- identical(substitute(colors_lock)[[1]], as.symbol("!")) | identical(substitute(colors_lock)[[1]], as.symbol("-"))
      colors_lock_i <- c(colors_lock, rep(colors_lock_bool, length(colors) - length(colors_lock)))
    }
  }
  colors_lock_i <- ! colors_lock_i
  
  ## initialize color space
  rgb_values <- col2rgb(colors) / 255 * 100 # scale values intuitively between 0-100 
  call_mode <- "rgb"
  call_order <- names(as.list(sys.call()))
  call_order <- call_order[nzchar(call_order)]
  ## colorify call order matters: for each call, convert color space when switching modes, then apply value changes
  for (call in call_order) {
    if (call %in% c("rv", "gv", "bv", "rf", "gf", "bf")) {
      if (call_mode == "hsv") {
        call_mode <- "rgb"
        rgb_values <- hsv2rgb(hsv_values["h", ], hsv_values["s", ], hsv_values["v", ], maxColorValue = 100)
      }
      switch(call,
             "rv" = rgb_values[1, ][colors_lock_i] <- pmax(rmin, pmin(rmax, rgb_values[1, ][colors_lock_i] + rv)),
             "gv" = rgb_values[2, ][colors_lock_i] <- pmax(gmin, pmin(gmax, rgb_values[2, ][colors_lock_i] + gv)),
             "bv" = rgb_values[3, ][colors_lock_i] <- pmax(bmin, pmin(bmax, rgb_values[3, ][colors_lock_i] + bv)),
             "rf" = rgb_values[1, ][colors_lock_i] <- pmax(rmin, pmin(rmax, rgb_values[1, ][colors_lock_i] * rf)),
             "gf" = rgb_values[2, ][colors_lock_i] <- pmax(gmin, pmin(gmax, rgb_values[2, ][colors_lock_i] * gf)),
             "bf" = rgb_values[3, ][colors_lock_i] <- pmax(bmin, pmin(bmax, rgb_values[3, ][colors_lock_i] * bf))
      )
    } else if (call %in% c("hv", "sv", "lv", "hf", "sf", "lf")) {
      if (call_mode == "rgb") {
        call_mode <- "hsv"
        hsv_values <- rgb2hsv(rgb_values[1, ], rgb_values[2, ], rgb_values[3, ], maxColorValue = 100) * 100 # scale values intuitively between 0-100
      }
      switch(call,
             "hv" = hsv_values["h", ][colors_lock_i] <- pmax(hmin, pmin(hmax, hsv_values["h", ][colors_lock_i] + hv)),
             "sv" = hsv_values["s", ][colors_lock_i] <- pmax(smin, pmin(smax, hsv_values["s", ][colors_lock_i] + sv)),
             "lv" = hsv_values["v", ][colors_lock_i] <- pmax(lmin, pmin(lmax, hsv_values["v", ][colors_lock_i] + lv)),
             "hf" = hsv_values["h", ][colors_lock_i] <- pmax(hmin, pmin(hmax, hsv_values["h", ][colors_lock_i] * hf)),
             "sf" = hsv_values["s", ][colors_lock_i] <- pmax(smin, pmin(smax, hsv_values["s", ][colors_lock_i] * sf)),
             "lf" = hsv_values["v", ][colors_lock_i] <- pmax(lmin, pmin(lmax, hsv_values["v", ][colors_lock_i] * lf))
      )
    }
  }
 
  ## finally: set hexcolor based on last color space and update rgb and hsv spaces for potential exporting
  if (call_mode == "hsv") {
    colors <- grDevices::hsv(hsv_values["h", ] / 100, hsv_values["s", ] / 100, hsv_values["v", ] / 100, alpha = alpha)
  } else if (call_mode == "rgb") {
    colors <- grDevices::rgb(rgb_values[1, ] / 100, rgb_values[2, ] / 100, rgb_values[3, ] / 100, alpha = alpha)
  }
  rgb_values <- grDevices::col2rgb(colors)
  hsv_values <- grDevices::rgb2hsv(rgb_values[1, ], rgb_values[2, ], rgb_values[3, ], maxColorValue = 255)
  
  ## set names
  if (length(colors_names) == length(colors)) {
    names(colors) <- colors_names
  } else if (length(colors_names) != 0) {
    warning("colors_names given: need same length as amount of requested colors")
  }
  
  ## order colors
  if (length(order) > 2 & length(order) >= n) { # set custom order
    colors <- colors[order[1:n]]
  } else if (order[1] == -1) { # -1: reverse colors
    colors <- rev(colors)
    ## after reversing: shift by order[2] 
    if ( ! is.na(order[2])) colors <- order_by_shift(shift = order[2], colors = colors, n = n)
    } else if (order[1] == 0) { # 0: randomly order colors
      colors <- sample(colors)
  } else { # != -1/0: shift by order
    colors <- order_by_shift(shift = order[1], colors = colors, n = n)
  }
  
  ## plot colors
  if ( ! isFALSE(plot)) {
    pie(rep(1, length(colors)), labels = if (grepl("l|L", plot)) 1:length(colors) else NA, col = colors, border = NA)
    if (grepl("i|I", plot)) image(1:length(colors), 1, as.matrix(1:length(colors)), col = colors, xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n")
    if (grepl("i|I", plot) && grepl("l|L", plot)) text(1:length(colors), rep(1, length(colors)), labels = 1:length(colors), col = "black")
  }
  ## export colors
  if (is.character(export) | isTRUE(export)) {
    df <- setNames(cbind(as.data.frame(colors), t(rgb_values), t(hsv_values)), c("hexcode", "r", "g", "b", "h", "s", "l"))
    ifelse(isTRUE(export), write.csv2(df, file = file.path(getwd(), "colorify.csv")), write.csv2(df, file = file.path(export, "colorify.csv")))
  }
  
  ## return colorRampPalette function 
  if (nn == Inf) return(grDevices::colorRampPalette(colors, ...))
  ## return color map function if colormap values map to colors
  if (length(colors_map) > 0) return(colorify_map(colors = colors, colors_map = colors_map, ...))
  return(colors)
}
