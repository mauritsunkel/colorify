#' Hex code colors to rgba format
#'
#' @param hex character (vector), hexcode colors (e.g. #FFFFFF)
#' @param alpha numeric in range (0-1), default: NULL to use full opacity or given opacity (AA) in hex (#RRGGBBAA)
#'
#' @returns colors in rgba format
#' 
#' @export
#'
#' @examples
#' colors <- colorify(5)
#' hex2rgba(colors)
#' hex2rgba(colors, alpha = .5)
#' colors <- gsub('FF$', 75, colors)
#' hex2rgba(colors)
#' hex2rgba(colors, alpha = .5)
hex2rgba <- function(hex, alpha = NULL) {
  stopifnot(
    is.character(hex),
    is.null(alpha) | is.numeric(alpha) && alpha >= 0 && alpha <= 1
  )
  ## set rgb
  hex <- gsub("#", "", hex) # strip #
  r <- as.numeric(paste0("0x", substr(hex, 1, 2))) # extract red
  g <- as.numeric(paste0("0x", substr(hex, 3, 4))) # extract green
  b <- as.numeric(paste0("0x", substr(hex, 5, 6))) # extract blue
  ## set alpha
  if (is.null(alpha)) {
    alpha <- 1
    if (nchar(hex)[1] == 8) alpha <- as.numeric(paste0('0x', substr(hex, 7, 8))) / 255
  }
  return(paste0("rgba(", r, ",", g, ",", b, ",", alpha, ")")) # convert to RGBA format
}
