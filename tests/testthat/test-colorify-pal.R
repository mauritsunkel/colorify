test_that("colorify_pal() returns a function", {
  fn <- colorify_pal()
  expect_true(is.function(fn))
})

test_that("colorify_pal() function returns n valid hex colors", {
  fn <- colorify_pal(colors = c("#FF0000", "#0000FF"))
  cols <- fn(5)

  expect_length(cols, 5)
  hex_pattern <- "^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$"
  expect_true(all(grepl(hex_pattern, cols)))
})

test_that("colorify_pal() output is deterministic with same seed", {
  fn <- colorify_pal(seed = 7)
  expect_identical(fn(8), fn(8))
})

test_that("colorify_pal() respects color modification parameters", {
  fn_bright <- colorify_pal(colors = c("#FF0000", "#0000FF"))
  fn_dark   <- colorify_pal(colors = c("#FF0000", "#0000FF"), lf = 0.5)

  get_brightness <- function(hex) {
    rgb_mat <- grDevices::col2rgb(hex)
    grDevices::rgb2hsv(rgb_mat[1], rgb_mat[2], rgb_mat[3], maxColorValue = 255)["v", 1]
  }

  bright_vals <- sapply(fn_bright(4), get_brightness)
  dark_vals   <- sapply(fn_dark(4),   get_brightness)

  expect_true(all(dark_vals <= bright_vals))
})

test_that("colorify_pal() is compatible with ggplot2 discrete_scale interface", {
  skip_if_not_installed("ggplot2")
  fn <- colorify_pal(colors = c("#FF0000", "#00FF00", "#0000FF"))
  cols <- fn(3)
  expect_length(cols, 3)
})
