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
    return(c(colors[(shift + 1):n], colors[1:shift]))
  } else { # shift <= 0
    shift <- abs(shift) %% n
    if (shift == 0) return(colors)
    left_shift <- n - shift
    return(c(colors[(left_shift + 1):n], colors[1:left_shift]))
  }
}