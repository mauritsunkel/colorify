#' Shift colors order
#'
#' @param shift integer to shift colors order by
#' @param colors hexcolors vector
#' @param n length(colors)
#'
#' @returns ordered colors vector
order_by_shift <- function(shift, colors, n) {
  if (shift > 0) {
    shift <- (shift - 1) %% n
    if (shift == 0) return(colors)
    c(colors[(shift + 1):n], colors[1:shift])
  } else { # non-positive shift: rotate left
    shift <- abs(shift) %% n
    if (shift == 0) return(colors)
    left_shift <- n - shift
    c(colors[(left_shift + 1):n], colors[1:left_shift])
  }
}
