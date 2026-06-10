test_that("colorify(n) returns n hex colors", {
  cols <- colorify(n = 5)

  expect_length(cols, 5)
  expect_type(cols, "character")
  expect_false(any(is.na(cols)))

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
  expect_false(isTRUE(all.equal(cols1, cols2)))
})

test_that("colorify() returns provided colors when n matches", {
  given <- c("#FF0000FF", "#00FF00FF", "#0000FFFF")
  cols <- colorify(n = 3, colors = given, seed = 42)

  expect_length(cols, 3)
  expect_identical(toupper(cols), toupper(given))
})

test_that("colorify() truncates colors when n < length(colors)", {
  given <- c("#111111FF", "#222222FF", "#333333FF", "#444444FF")
  cols <- colorify(n = 2, colors = given)

  expect_length(cols, 2)
  expect_identical(toupper(cols), toupper(given[1:2]))
})

test_that("colorify() extends palette with random colors when n > length(colors)", {
  given <- c("#AA0000FF", "#00AA00FF")
  cols <- colorify(n = 5, colors = given, seed = 42)

  expect_length(cols, 5)
  expect_identical(toupper(cols[1:2]), toupper(given))

  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols[3:5])))
})

test_that("colorify() expands to gradient when nn > n", {
  cols <- colorify(n = 2, colors = c("#FF0000", "#0000FF"), nn = 10, seed = 42)

  expect_length(cols, 10)
  expect_equal(substr(toupper(cols[1]), 1, 7), "#FF0000")
  expect_equal(substr(toupper(cols[10]), 1, 7), "#0000FF")
})

test_that("colorify() respects logical colors_lock when modifying channels", {
  base_cols <- c("#000000FF", "#000000FF", "#000000FF")
  lock <- c(TRUE, FALSE, FALSE)

  cols <- colorify(n = 3, colors = base_cols, rv = 50, colors_lock = lock, seed = 42)

  expect_length(cols, 3)

  get_r <- function(hex) grDevices::col2rgb(hex)[1, 1]
  r_before <- sapply(base_cols, get_r)
  r_after  <- sapply(cols, get_r)

  expect_identical(r_before[[1]], r_after[[1]])
  expect_gt(r_after[[2]], r_before[[2]])
  expect_gt(r_after[[3]], r_before[[3]])
})

test_that("colorify() respects numeric colors_lock when modifying channels", {
  base_cols <- c("#000000", "#000000", "#000000")
  cols <- colorify(n = 3, colors = base_cols, rv = 50, colors_lock = c(1, 3))

  get_r <- function(hex) grDevices::col2rgb(hex)[1, 1]
  r_after <- sapply(cols, get_r)

  expect_equal(r_after[[1]], 0L)
  expect_gt(r_after[[2]], 0L)
  expect_equal(r_after[[3]], 0L)
})

test_that("colorify() nn = Inf returns a colorRampPalette function", {
  fn <- colorify(colors = c("#FF0000", "#0000FF"), nn = Inf)

  expect_true(is.function(fn))

  cols <- fn(10)
  expect_length(cols, 10)
  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols)))
})

test_that("colorify() alpha sets color opacity byte", {
  cols <- colorify(n = 3, colors = c("#FF0000", "#00FF00", "#0000FF"), alpha = 0.5)
  alpha_bytes <- substr(cols, 8, 9)
  expect_true(all(alpha_bytes == "80"))
})

test_that("colorify() order = -1 reverses colors relative to default order", {
  given <- c("#111111", "#222222", "#333333", "#444444", "#555555")
  cols_fwd <- colorify(n = 5, colors = given)
  cols_rev <- colorify(n = 5, colors = given, order = -1)
  expect_identical(cols_rev, rev(cols_fwd))
})

test_that("colorify() order = 0 gives consistent seeded random order", {
  cols1 <- colorify(n = 5, seed = 42, order = 0)
  cols2 <- colorify(n = 5, seed = 42, order = 0)
  expect_identical(cols1, cols2)
})

test_that("colorify() lf < 1 darkens colors", {
  given <- c("#FF0000", "#00FF00", "#0000FF")
  get_brightness <- function(hex) {
    rgb_mat <- grDevices::col2rgb(hex)
    grDevices::rgb2hsv(rgb_mat[1], rgb_mat[2], rgb_mat[3], maxColorValue = 255)["v", 1]
  }

  cols_bright <- colorify(n = 3, colors = given)
  cols_dark   <- colorify(n = 3, colors = given, lf = 0.5)

  bright_vals <- sapply(cols_bright, get_brightness)
  dark_vals   <- sapply(cols_dark, get_brightness)

  expect_true(all(dark_vals <= bright_vals))
})

test_that("colorify() rv > 0 increases red channel", {
  base_cols <- c("#000000", "#000000", "#000000")
  cols <- colorify(n = 3, colors = base_cols, rv = 50)

  get_r <- function(hex) grDevices::col2rgb(hex)[1, 1]
  r_vals <- sapply(cols, get_r)

  expect_true(all(r_vals > 0))
})

test_that("colorify() loads viridis palette by name", {
  cols <- colorify(n = 5, colors = "viridis")

  expect_length(cols, 5)
  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols)))
})

test_that("colorify() loads Okabe-Ito palette by name", {
  cols <- colorify(colors = "Okabe-Ito")

  expect_true(length(cols) > 0)
  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols)))
})

test_that("colorify() loads rainbow palette by name", {
  cols <- colorify(n = 10, colors = "rainbow")

  expect_length(cols, 10)
  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols)))
})

test_that("colorify() colors_map returns a mapping function", {
  fn <- colorify(colors = c("#FF0000", "#FFFFFF", "#0000FF"), colors_map = c(-5, 0, 10))

  expect_true(is.function(fn))
  result <- fn(c(-5, 0, 10))
  expect_length(result, 3)
})

test_that("colorify() colors_names sets names when length matches", {
  nms <- c("red", "green", "blue")
  cols <- colorify(n = 3, colors = c("#FF0000", "#00FF00", "#0000FF"), colors_names = nms)
  expect_named(cols, nms)
})

test_that("colorify() errors when no colors or n provided", {
  expect_error(colorify(), "Input starting color")
})
