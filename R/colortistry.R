#' Colortistry plot from Colorified palettes
#'
#' @param colors_list list of colors generated with \code{\link{colorify}}, see example
#' @param border_color default: NA, for no border, otherwise R grDevices color or hexcolor
#'
#' @return plot Colortistry plot of combined Colorified palettes
#' 
#' @export
#' 
#' @seealso Browse vignettes with \code{vignette("Introduction to coloRify")}
#'
#' @examples
#' colors_list <- list()
#' for (i in seq(100)) {
#'   colors_list[[i]] <- colorify(
#'   n = 100, 
#'   colors = "rainbow", 
#'   colors_lock = rep(c(TRUE,FALSE,FALSE,FALSE,FALSE), 20), 
#'   hf = 25/i, 
#'   lf = i/20)
#'   if (i %% 3) colors_list[[i]] <- colorify(
#'   n = 100, 
#'   colors = "rainbow", 
#'   colors_lock = rep(c(FALSE,FALSE,TRUE,FALSE,FALSE), 20), 
#'   hf = 30/i, 
#'   lf = i/20)
#'   if (i %% 4) colors_list[[i]] <- colorify(
#'   n = 100, 
#'   colors = "rainbow",
#'   colors_lock = rep(c(FALSE,FALSE,FALSE,TRUE,FALSE), 20), 
#'   hf = 50/i, 
#'   lf = i/40)
#'   if (i %% 5) colors_list[[i]] <- colorify(
#'   n = 100, 
#'   colors = "rainbow", 
#'   colors_lock = rep(c(FALSE,TRUE,FALSE,FALSE,FALSE), 20), 
#'   hf = 50/i, 
#'   sf = i/50)
#' }
#' colortistry(colors_list)
#' colortistry(colors_list, border_color = 'black')
colortistry <- function(colors_list, border_color = NA) {
  ## set plot margins
  graphics::par(mar = c(0, 0, 0, 0))
  ## initialize empty colortistry plot
  plot(NULL, xlim = c(0, max(sapply(colors_list, length))), ylim = c(0, length(colors_list)), xaxt = "n", yaxt = "n", xlab = "", ylab = "", bty = "n")
  ## draw rectangle bars for each colors list
  for (i in seq_along(colors_list)) {
    n <- length(colors_list[[i]])
    graphics::rect(
      xleft = 0:(n - 1), 
      ybottom = length(colors_list) - i, 
      xright = 1:n, 
      ytop = length(colors_list) - i + 1, 
      col = colors_list[[i]], 
      border = border_color
    )
  }
}
