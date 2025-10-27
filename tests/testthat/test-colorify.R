test_that("colorify(n) returns n hex colors", {
  set.seed(123)  # make sure test itself is stable
  
  cols <- colorify(n = 5)
  
  # length should be 5
  expect_length(cols, 5)
  
  # should be character
  expect_type(cols, "character")
  
  # should not contain NA
  expect_false(any(is.na(cols)))
  
  # each should look like #RRGGBB or #RRGGBBAA
  # pattern explanation:
  #   ^#            starts with '#'
  #   ([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})  either 6 or 8 hex digits
  #   $             end of string
  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols)))
})

test_that("colorify() is deterministic given same seed", {
  cols1 <- colorify(n = 5, seed = 42)
  cols2 <- colorify(n = 5, seed = 42)
  
  expect_identical(cols1, cols2)
})

test_that("colorify() changes with different seeds", {
  cols1 <- colorify(n = 5, seed = 1)
  cols2 <- colorify(n = 5, seed = 999)
  
  # not strict guarantee, but extremely likely: palettes differ
  expect_false(isTRUE(all.equal(cols1, cols2)))
})

test_that("colorify() returns provided colors if n matches", {
  given <- c("#FF0000FF", "#00FF00FF", "#0000FFFF")
  
  cols <- colorify(n = 3, colors = given, seed = 42)
  
  # same length
  expect_length(cols, 3)
  
  # same first/last colors (exact casing may differ, so compare after toupper)
  expect_identical(toupper(cols), toupper(given))
})

test_that("colorify() truncates extra provided colors if n < length(colors)", {
  given <- c("#111111FF", "#222222FF", "#333333FF", "#444444FF")
  
  cols <- colorify(n = 2, colors = given)
  
  expect_length(cols, 2)
  expect_identical(toupper(cols), toupper(given[1:2]))
})

test_that("colorify() extends palette with random colors if n > length(colors)", {
  given <- c("#AA0000FF", "#00AA00FF")
  
  cols <- colorify(n = 5, colors = given, seed = 42)
  
  expect_length(cols, 5)
  
  # first two should match the provided inputs
  expect_identical(toupper(cols[1:2]), toupper(given))
  
  # last three should be valid hexcodes
  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols[3:5])))
})

is_same_color <- function(x, y) {
  # compare RGB ignoring alpha and case
  strip_alpha <- function(z) substr(toupper(z), 1, 7)
  strip_alpha(x) == strip_alpha(y)
}

test_that("colorify() expands to gradient when nn > n", {
  cols <- colorify(
    n = 2,
    colors = c("#FF0000", "#0000FF"),
    nn = 10,
    seed = 42
  )
  
  expect_length(cols, 10)
  
  expect_true(is_same_color(cols[1], "#FF0000"))
  expect_true(is_same_color(cols[10], "#0000FF"))
})

test_that("colorify() respects colors_lock when modifying channels", {
  base_cols <- c("#000000FF", "#000000FF", "#000000FF")
  # lock the first color (TRUE means 'locked', but note inside you invert with '!'; we
  # need to match your contract: you do `colors_lock_i <- ! colors_lock_i`.
  # So: passing TRUE for first means "lock it (don't modify)" -> becomes FALSE after `!`.
  lock <- c(TRUE, FALSE, FALSE)
  
  cols_locked <- colorify(
    n = 3,
    colors = base_cols,
    rv = 50, # add a bunch of red
    colors_lock = lock,
    seed = 42
  )
  
  expect_length(cols_locked, 3)
  
  # helper to pull R channel 0-255
  get_r <- function(hex) grDevices::col2rgb(hex)[1, 1]
  
  r_before <- sapply(base_cols, get_r)
  r_after  <- sapply(cols_locked, get_r)
  
  # first should be unchanged
  expect_identical(r_before[1], r_after[1])
  
  # others should increase
  expect_gt(r_after[2], r_before[2])
  expect_gt(r_after[3], r_before[3])
})

expect_error(
  colorify(n = 5, nn = c(2, 3, 4)), # wrong nn length relative to colors
  "the condition has length > 1"
)

test_that("colorify(n) returns n valid hex colors", {
  cols <- colorify(n = 5, seed = 42)
  
  expect_length(cols, 5)
  expect_type(cols, "character")
  expect_false(any(is.na(cols)))
  
  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols)))
})

test_that("colorify() is deterministic with same seed", {
  cols1 <- colorify(n = 5, seed = 42)
  cols2 <- colorify(n = 5, seed = 42)
  expect_identical(cols1, cols2)
})
