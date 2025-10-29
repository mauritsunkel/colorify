#' Colorifunctionalize palettes 
#' 
#' @description A wrapper function around \code{\link{coloRify}} to
#'  turn it into a palette function compatible with
#'  \code{\link[ggplot2]{discrete_scale}} and \code{\link[ggplot2]{scale_fill_gradientn}}.
#' 
#' @return colorify_pal: callable function(n) for generating colors
#' 
#' @export
#' 
#' @seealso Browse vignettes with \code{vignette("Introduction to coloRify")}
#' 
#' @rdname colorify
#'
#' @examples
#' ## named base R/hexcode
#' colorifunction <- colorify_pal(colors = c('red', '#FFFFFF', 'blue'))
#' colorify(colors = colorifunction(10), plot = TRUE)
#' ## empty for random
#' colorifunction <- colorify_pal()
#' colorify(colors = colorifunction(10), plot = TRUE)
#' ## named colors and palette(s)
#' colorifunction <- colorify_pal(colors = c('green', 'viridis', 'rainbow', 'yellow'), plot = T)
#' colorify(colors = colorifunction(100), plot = TRUE)
colorify_pal <- function(
    colors = character(0), colors_lock = NULL,
    hf = 1, sf = 1, lf = 1, rf = 1, gf = 1, bf = 1,
    hv = 0, sv = 0, lv = 0, rv = 0L, gv = 0L, bv = 0L,
    hmin = 0L, smin = 0L, lmin = 0L, rmin = 0L, gmin = 0L, bmin = 0L,
    hmax = 100L, smax = 100L, lmax = 100L, rmax = 100L, gmax = 100L, bmax = 100L,
    alpha = 1, seed = 42L, order = 1, verbose = TRUE, ...) {
  function(n) colorify(
    nn = Inf, colors = colors, colors_lock = colors_lock,
    hf = hf, sf = sf, lf = lf, rf = rf, gf = gf, bf = bf,
    hv = hv, sv = sv, lv = lv, rv = rv, gv = gv, bv = bv,
    hmin = hmin, smin = smin, lmin = lmin, rmin = rmin, gmin = gmin, bmin = bmin,
    hmax = hmax, smax = smax, lmax = lmax, rmax = rmax, gmax = gmax, bmax = bmax,
    alpha = alpha, seed = seed, order = order, verbose = verbose, ...)(n)
}