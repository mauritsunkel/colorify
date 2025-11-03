#' coloRify colorRamp between colors mapping to breakpoint values
#'
#' @param colors hexcolor character vector
#' @param colors_map numeric vector matching colors per value
#' @param ... to pass arguments to grDevices::colorRamp
#'
#' @description
#' \code{\link{colorify}} map for gradient coloring using grDevices::colorRamp, inspired by circlize::colorRamp2. 
#' Note that colors_map and colors will be ordered ascendingly by colors_map values. 
#'
#' @returns function with colors and breaks attributes, can be called as function(c(values)) to return hexcolorcodes
#'
#' @seealso Browse vignettes with \code{vignette("Introduction to coloRify")}
#'
#' @keywords internal
#' @noRd
colorify_map <- function(colors, colors_map, ...) {
  if (length(colors) != length(colors_map)) stop("for color mapping: 'colors' and 'colors_map' must be the same length.")
  if (length(colors) < 2 | length(colors_map) < 2) stop("You need at least two colors and two colors_map.")
  
  ## order colors_map and colors ascendingly, respectively
  ord <- order(colors_map)
  colors_map <- colors_map[ord]
  colors <- colors[ord]
  
  ## colorRamp per sequential color pair: map colors to interval [0, 1]
  ramp_list <- lapply(seq_len(length(colors) - 1), function(i) grDevices::colorRamp(c(colors[i], colors[i+1]), ...))
  
  colorify_mapped <- function(values) {
    ## initialize mapped hexcolors
    mapped_colors <- character(length(values))
    ## for each value index, figure out where it belongs:
    for (vi in seq_along(values)) {
      value <- values[vi]
      ## if below/above the first/last breakpoint, clamp to first/last color
      if (value <= colors_map[1]) {
        mapped_colors[vi] <- colors[1]
      } else if (value >= colors_map[length(colors_map)]) {
        mapped_colors[vi] <- colors[length(colors)]
      } else {
        ## find ramp index of value between colors_map
        ri <- findInterval(value, colors_map, left.open = TRUE)
        ## scale value between interval [0, 1] for specific color ramp pair
        scaled <- (value - colors_map[ri]) / (colors_map[ri + 1] - colors_map[ri])
        ## get rgb values of pecific color ramp pair by scaled value
        # message(4, " ", ri)
        rgb_val <- ramp_list[[ri]](scaled)
        ## convert rgb to hexcolor
        mapped_colors[vi] <- grDevices::rgb(rgb_val[1], rgb_val[2], rgb_val[3], maxColorValue = 255)
      }
    }
    return(mapped_colors)
  }
  
  ## attach function attributes
  attr(colorify_mapped, "breaks") <- colors_map
  attr(colorify_mapped, "colors") <- colors
  return(colorify_mapped)
}
