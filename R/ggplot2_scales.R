#' coloRify scale color bindings for ggplot2 
#'
#' @param aesthetics string, default: 'color', see \code{\link[ggplot2]{discrete_scale}} and \code{\link[ggplot2]{scale_color_gradientn}} for more aesthetics
#' @param discrete boolean, default = FALSE (calls \code{\link[ggplot2]{scale_color_gradientn}}), else TRUE (calls \code{\link[ggplot2]{discrete_scale}})
#' @param n integer, default: 2, amount of colors(/gradients) to return, only works if not discrete
#' @param nn integer, default: Inf, length of gradients, if Inf then set to 256 
#' @param ... additional parameters passed to \code{\link{colorify}}, \code{\link[ggplot2]{discrete_scale}} and/or \code{\link[ggplot2]{scale_color_gradientn}}
#'
#' @rdname scale_colorify
#'
#' @return sets colors in ggplot2 plotted object, see examples
#'   
#' @importFrom ggplot2 scale_color_gradientn discrete_scale
#' @export
#' 
#' @description for rest and default coloRify parameters see \code{\link{colorify}}
#'
#' @examples
#' ## viridis ggplot2 examples Colorified 
#' 
#' ## non-discrete
#' dsub <- subset(diamonds, x > 5 & x < 6 & y > 5 & y < 6)
#' dsub$diff <- with(dsub, sqrt(abs(x - y)) * sign(x - y))
#' d <- ggplot(dsub, aes(x, y, colour = diff)) + geom_point()
#'   d + scale_color_colorify(n = 4, colors = 'viridis') + theme_bw()
#' 
#' ## discrete
#' p <- ggplot(mtcars, aes(wt, mpg))
#' p + geom_point(size = 4, aes(colour = factor(cyl))) +
#'   theme_bw() + scale_color_colorify(discrete = TRUE, seed = 1)
scale_color_colorify <- function(
    ..., aesthetics = "color", discrete = FALSE,
    nn = Inf, n = 2, colors = character(0), colors_lock = NULL,
    hf = 1, sf = 1, lf = 1, rf = 1, gf = 1, bf = 1,
    hv = 0, sv = 0, lv = 0, rv = 0, gv = 0, bv = 0,
    hmin = 0, smin = 0, lmin = 0, rmin = 0, gmin = 0, bmin = 0,
    hmax = 100, smax = 100, lmax = 100, rmax = 100, gmax = 100, bmax = 100,
    alpha = 1, seed = 42, order = 1, verbose = TRUE) {
  
  
  if (discrete) {
    discrete_scale(aesthetics, "colorify", colorify_pal(
      colors = colors, colors_lock = colors_lock,
      hf = hf, sf = sf, lf = lf, rf = rf, gf = gf, bf = bf,
      hv = hv, sv = sv, lv = lv, rv = rv, gv = gv, bv = bv,
      hmin = hmin, smin = smin, lmin = lmin, rmin = rmin, gmin = gmin, bmin = bmin,
      hmax = hmax, smax = smax, lmax = lmax, rmax = rmax, gmax = gmax, bmax = bmax,
      alpha = alpha, seed = seed, order = order, verbose = verbose, ...), ...)
  } else {
    scale_color_gradientn(colours = colorify(
      n = n, colors = colors, colors_lock = colors_lock,
      hf = hf, sf = sf, lf = lf, rf = rf, gf = gf, bf = bf,
      hv = hv, sv = sv, lv = lv, rv = rv, gv = gv, bv = bv,
      hmin = hmin, smin = smin, lmin = lmin, rmin = rmin, gmin = gmin, bmin = bmin,
      hmax = hmax, smax = smax, lmax = lmax, rmax = rmax, gmax = gmax, bmax = bmax,
      alpha = alpha, seed = seed, order = order, verbose = verbose, ...
    ), aesthetics = aesthetics, ...)
  }
}
#' @rdname scale_colorify
#' @aliases scale_color_colorify
#' @export
scale_colour_colorify <- scale_color_colorify

#' coloRify scale fill bindings for ggplot2 
#'
#' @param aesthetics string, default: 'fill', see \code{\link[ggplot2]{discrete_scale}} and \code{\link[ggplot2]{scale_fill_gradientn}} for more aesthetics
#' @param discrete boolean, default = FALSE (calls \code{\link[ggplot2]{scale_fill_gradientn}}), else TRUE (calls \code{\link[ggplot2]{discrete_scale}})
#' @param n integer, default: 2, amount of colors(/gradients) to return, only works if not discrete
#' @param nn integer, default: Inf, length of gradients, if Inf then set to 256 
#' @param ... additional parameters passed to \code{\link{colorify}}, \code{\link[ggplot2]{discrete_scale}} and/or \code{\link[ggplot2]{scale_fill_gradientn}}
#'
#' @return sets colors in ggplot2 plotted object, see examples
#' 
#' @export
#' 
#' @description for rest and default coloRify parameters see \code{\link{colorify}}
#'
#' @examples
#' ## viridis ggplot2 examples Colorified
#' 
#' ## non-discrete
#' dat <- data.frame(x = rnorm(10000), y = rnorm(10000))
#' 
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(dat, ggplot2::aes(x = x, y = y)) +
#'     ggplot2::geom_hex() + coord_fixed() +
#'     scale_fill_colorify(colors = 'viridis', n = 4) + theme_bw()
#' }
#' ## discrete
#' df <- data.frame(category = c("A", "B", "C", "D"), value = c(10, 23, 15, 8))
#' 
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(df, ggplot2::aes(x = category, y = value, fill = category)) +
#'     ggplot2::geom_bar(stat = "identity") +
#'     scale_fill_colorify(discrete = TRUE, colors = 'viridis')
#' }
scale_fill_colorify <- function(
    ..., aesthetics = "fill", discrete = FALSE,
    nn = Inf, n = 2, colors = character(0), colors_lock = NULL,
    hf = 1, sf = 1, lf = 1, rf = 1, gf = 1, bf = 1,
    hv = 0, sv = 0, lv = 0, rv = 0, gv = 0, bv = 0,
    hmin = 0, smin = 0, lmin = 0, rmin = 0, gmin = 0, bmin = 0,
    hmax = 100, smax = 100, lmax = 100, rmax = 100, gmax = 100, bmax = 100,
    alpha = 1, seed = 42, order = 1, verbose = TRUE) {
  if (discrete) {
    discrete_scale(aesthetics, "colorify", colorify_pal(
      colors = colors, colors_lock = colors_lock,
      hf = hf, sf = sf, lf = lf, rf = rf, gf = gf, bf = bf,
      hv = hv, sv = sv, lv = lv, rv = rv, gv = gv, bv = bv,
      hmin = hmin, smin = smin, lmin = lmin, rmin = rmin, gmin = gmin, bmin = bmin,
      hmax = hmax, smax = smax, lmax = lmax, rmax = rmax, gmax = gmax, bmax = bmax,
      alpha = alpha, seed = seed, order = order, verbose = verbose, ...), ...)
  } else {
    scale_fill_gradientn(colours = colorify(
      n = n, colors = colors, colors_lock = colors_lock,
      hf = hf, sf = sf, lf = lf, rf = rf, gf = gf, bf = bf,
      hv = hv, sv = sv, lv = lv, rv = rv, gv = gv, bv = bv,
      hmin = hmin, smin = smin, lmin = lmin, rmin = rmin, gmin = gmin, bmin = bmin,
      hmax = hmax, smax = smax, lmax = lmax, rmax = rmax, gmax = gmax, bmax = bmax,
      alpha = alpha, seed = seed, order = order, verbose = verbose, ...
    ), aesthetics = aesthetics, ...)
  }
}