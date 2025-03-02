#' Display R grDevices palettes
#'
#' @param n integer, amount of colors to display
#' @param i_palettes default: numeric vector as index/range for choosing palettes, or a combination of 'rcolorbrewer', 'viridis', 'rainbow' (grDevices Palettes) to show specific palettes
#' @param border default: FALSE, if TRUE show color rectangle borders
#'
#' @export
#'
#' @return named vector with source and name of palettes, 'hcl' for grDevices::hcl.pals() and 'pal' for grDevices::palette.pals()
#'
#' @description
#' Use colorify() to select and modify the palettes, see its documentation.
#' Note that discrete palettes with maximum n colors will be repeated in plotting.
#'
#' Any numeric i_palettes over maximum amount of palettes are not displayed.
#'
#' Contains all Viridis palettes, including Turbo.
#'
#' @examples
#' display_palettes()
#' display_palettes(i_palettes = 50:75)
#'
#' display_palettes(i_palettes = 'RColorBrewer')
#' display_palettes(i_palettes = 'Viridis')
#' display_palettes(i_palettes = c("rainbow", "viridis"))
#'
#' display_palettes(i_palettes = c(1,5,10,20,40,100,119)
#' display_palettes(n = 100, i_palettes = 1:10)
#' display_palettes(n = 10, i_palettes = 1:10, border = TRUE)
display_palettes <- function(n = 10, i_palettes = 1:1000, border = FALSE) {
  stopifnot(
    is.numeric(n),
    is.numeric(i_palettes) | is.character(i_palettes),
    is.logical(border)
  )
  
  ## get base R grDevices palettes
  viridis_palette_names <- c("Viridis", "Plasma", "Inferno", "Cividis", "Rocket", "Mako", "Turbo")
  grDevices_palettes <- c("Rainbow", "Heat", "Terrain", "Topo", "Cm")
  hcl_palettes <- grDevices::hcl.pals()
  base_palettes <- grDevices::palette.pals()
  turbo_palette <- setNames("Turbo", "Viridis-turbo")
  grd_palettes <- setNames(grDevices_palettes, rep("grDevices", length(grDevices_palettes)))
  hcl_palettes <- setNames(hcl_palettes, rep("hcl", length(hcl_palettes)))
  base_palettes <- setNames(base_palettes, rep("pal", length(base_palettes)))
  all_palettes <- c(turbo_palette, grd_palettes, hcl_palettes, base_palettes)
  
  if (is.character(i_palettes)) {
    i_palettes <- unlist(sapply(i_palettes, function(pal) {
      if (tolower(pal) == 'rcolorbrewer') {
        brewer_palettes <- c(
          "BrBG", "PiYG", "PRGn", "PuOr", "RdBu", "RdGy", "RdYlBu", "RdYlGn", "Spectral",
          "Accent", "Dark 2", "Paired", "Pastel 1", "Pastel 2", "Set 1", "Set 2", "Set 3",
          "Blues", "BuGn", "BuPu", "GnBu", "Greens", "Grays", "Oranges", "OrRd",
          "PuBu", "PuBuGn", "PuRd", "Purples", "RdPu", "Reds", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"
        )
        match(brewer_palettes, all_palettes)
      } else if (tolower(pal) %in% tolower(viridis_palette_names)) {
        match(viridis_palette_names, all_palettes)
      } else if (tolower(pal) %in% tolower(grd_palettes)) {
        match(grd_palettes, all_palettes)
      } else {
        message("pass i_palettes = 'rcolorbrewer', 'viridis'(-palettes), see grDevices Palettes or numeric index/range e.g. = 1:30")
      }
    }))
    
  }
  ## set index between 1 and maximum amount of palettes
  i_palettes <- i_palettes[i_palettes > 0 & i_palettes <= length(all_palettes)]
  ## select palettes by index
  all_palettes <- all_palettes[i_palettes]
  
  ## save and set par plot margins
  old_par <- par(no.readonly = TRUE)
  par(mar = c(0, 0, 0, 0))
  
  ## initialize empty plot
  plot(NULL, xlim = c(-3, n), ylim = c(0, length(all_palettes)), xaxt = "n", yaxt = "n", xlab = "", ylab = "", bty = "n", main = "")
  
  for (i in seq_along(all_palettes)) {
    ## get grDevices colors by palette name
    if (names(all_palettes[i]) == "hcl") {
      colors <- grDevices::hcl.colors(n, palette = all_palettes[i])
    } else if (names(all_palettes[i]) == "pal") {
      colors <- grDevices::palette.colors(palette = all_palettes[i])
    } else if (all_palettes[i] == "Turbo") {
      colors <- turbo(n)
    } else if (all_palettes[i] == "Rainbow") {
      colors <- grDevices::rainbow(n)
    } else if (all_palettes[i] == "Heat") {
      colors <- grDevices::heat.colors(n)
    } else if (all_palettes[i] == "Terrain") {
      colors <- grDevices::terrain.colors(n)
    } else if (all_palettes[i] == "Topo") {
      colors <- grDevices::topo.colors(n)
    } else if (all_palettes[i] == "Cm") {
      colors <- grDevices::cm.colors(n)
    }
    
    ## draw rectangular palettes
    y_bottom <- i - 1
    y_top <- i - 0.1
    rect(xleft = 0:(n - 1), ybottom = y_bottom, xright = 1:n, ytop = y_top, col = colors, border = ifelse(border, TRUE, NA))
    
    ## center text in palette, no falling off side of plot
    text_x <- n / 2
    text_y <- (y_bottom + y_top) / 2
    text(x = text_x, y = text_y, labels = all_palettes[i], col = "black", cex = 0.9, font = 2)
  }
  
  ## reset plot margins to default
  par(old_par)
  
  return(all_palettes)
}

#' Palette original name mapping
#'
#' @param palette string: name of palette, will be lower()ed and stripped of whitespace
#'
#' @return original palette name
#'
#' @description
#' All ColorBrewer palettes overlap with grDevices palettes
#' Viridis palettes, except "Magma", overlap with grDevices palettes
#'
#' @examples
#' palette_name_mapping("dark2") # "Dark 2"
palette_name_mapping <- function(palette) {
  palette_mapping <- list(
    ## custom palettes
    "turbo" = "Turbo", "rainbow" = "Rainbow", "heat" = "Heat",
    "terrain" = "Terrain", "topo" = "Topo", "cm" = "Cm",
    ## all RColorBrewer palettes
    ## grDevices::palette.pals()
    "r3" = "R3", "r 3" = "R3", "r4" = "R4", "r 4" = "R4", "ggplot2" = "ggplot2", "okabe-ito" = "Okabe-Ito",
    "accent" = "Accent", "dark2" = "Dark 2", "dark 2" = "Dark 2", "paired" = "Paired",
    "pastel1" = "Pastel 1", "pastel 1" = "Pastel 1", "pastel2" = "Pastel 2", "pastel 2" = "Pastel 2",
    "set1" = "Set 1", "set 1" = "Set 1", "set2" = "Set 2", "set 2" = "Set 2", "set3" = "Set 3", "set 3" = "Set 3",
    "tableau10" = "Tableau 10", "tableau 10" = "Tableau 10",
    "classictableau" = "Classic Tableau", "classic tableau" = "Classic Tableau",
    "polychrome36" = "Polychrome 36", "polychrome 36" = "Polychrome 36",
    "alphabet" = "Alphabet",
    ## grDevices::hcl.pals()
    "dark3" = "Dark 3", "dark 3" = "Dark 3",
    "warm" = "Warm", "cold" = "Cold", "harmonic" = "Harmonic", "dynamic" = "Dynamic",
    "grays" = "Grays", "greys", "Grays", "lightgrays" = "Light Grays", "light grays" = "Light Grays",
    "blues2" = "Blues 2", "blues 2" = "Blues 2", "blues3" = "Blues 3", "blues 3" = "Blues 3",
    "purples2" = "Purples 2", "purples 2" = "Purples 2", "purples3" = "Purples 3", "purples 3" = "Purples 3",
    "reds2" = "Reds 2", "reds 2" = "Reds 2", "reds3" = "Reds 3", "reds 3" = "Reds 3",
    "greens2" = "Greens 2", "greens 2" = "Greens 2", "greens3" = "Greens 3", "greens 3" = "Greens 3",
    "oslo" = "Oslo", "purple-blue" = "Purple-Blue", "red-purple" = "Red-Purple",
    "red-blue" = "Red-Blue", "purple-orange" = "Purple-Orange", "purple-yellow" = "Purple-Yellow",
    "blue-yellow" = "Blue-Yellow", "green-yellow" = "Green-Yellow", "red-yellow" = "Red-Yellow",
    "heat" = "Heat", "heat2" = "Heat 2", "heat 2" = "Heat 2",
    "terrain" = "Terrain", "terrain2" = "Terrain 2", "terrain 2" = "Terrain 2",
    "viridis" = "Viridis", "plasma" = "Plasma", "inferno" = "Inferno", "rocket" = "Rocket", "mako" = "Mako",
    "darkmint" = "Dark Mint", "dark mint" = "Dark Mint", "mint" = "Mint",
    "blugrn" = "BluGrn", "teal" = "Teal", "tealgrn" = "TealGrn", "emrld" = "Emrld",
    "bluyl" = "BluYl", "ag_grnyl" = "ag_GrnYl", "peach" = "Peach", "pinkyl" = "PinkYl",
    "burg" = "Burg", "burgyl" = "BurgYl", "redor" = "RedOr", "oryel" = "OrYel",
    "purp" = "Purp", "purpor" = "PurpOr", "sunset" = "Sunset", "magenta" = "Magenta",
    "sunsetdark" = "SunsetDark", "ag_sunset" = "ag_Sunset", "brwnyl" = "BrwnYl",
    "ylorrd" = "YlOrRd", "ylorbr" = "YlOrBr", "oranges" = "Oranges", "reds" = "Reds",
    "rdpu" = "RdPu", "purd" = "PuRd", "purples" = "Purples", "pubugn" = "PuBuGn",
    "pubu" = "PuBu", "greens" = "Greens", "bugn" = "BuGn", "gnbu" = "GnBu", "bupu" = "BuPu",
    "blues" = "Blues",
    "lajolla" = "Lajolla", "turku" = "Turku", "hawaii" = "Hawaii", "batlow" = "Batlow",
    "blue-red" = "Blue-Red", "blue-red2" = "Blue-Red 2", "blue-red 2" = "Blue-Red 2",
    "blue-red3" = "Blue-Red 3", "blue-red 3" = "Blue-Red 3",
    "red-green" = "Red-Green", "purple-green" = "Purple-Green", "purple-brown" = "Purple-Brown",
    "green-brown" = "Green-Brown", "blue-yellow2" = "Blue-Yellow 2", "blue-yellow 2" = "Blue-Yellow 2",
    "blue-yellow3" = "Blue-Yellow 3", "blue-yellow 3" = "Blue-Yellow 3",
    "green-orange" = "Green-Orange", "cyan-magenta" = "Cyan-Magenta", "tropic" = "Tropic",
    "broc" = "Broc", "cork" = "Cork", "vik" = "Vik", "berlin" = "Berlin", "lisbon" = "Lisbon",
    "tofino" = "Tofino", "armyrose" = "ArmyRose", "earth" = "Earth", "fall" = "Fall",
    "geyser" = "Geyser", "tealrose" = "TealRose", "temps" = "Temps",
    "puor" = "PuOr", "rdbu" = "RdBu", "rdgy" = "RdGy", "piyg" = "PiYG",
    "prgn" = "PRGn", "brbg" = "BrBG", "rdylbu" = "RdYlBu", "rdylgn" = "RdYlGn", "spectral" = "Spectral",
    "zissou1" = "Zissou 1", "zissou 1" = "Zissou 1",
    "cividis" = "Cividis", "roma" = "Roma",
    ## viridis variations (except viridisa = Magma)
    "viridisb" = "Inferno", "viridisc" = "Plasma", "viridisd" = "Viridis", 'viridise' = 'Cividis', "viridisf" = "Rocket", "viridisg" = "Mako", 'viridish' = "Turbo"
  )
  original_palette <- palette_mapping[[tolower(gsub(" ", "", palette))]]
  ifelse(is.null(original_palette), return(""), return(original_palette))
}
