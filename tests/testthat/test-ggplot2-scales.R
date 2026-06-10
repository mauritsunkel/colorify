test_that("scale_color_colorify() returns a ggplot2 Scale object (continuous)", {
  skip_if_not_installed("ggplot2")
  scale <- scale_color_colorify(colors = "viridis", n = 4)
  expect_true(inherits(scale, "Scale"))
})

test_that("scale_color_colorify() returns a ggplot2 Scale object (discrete)", {
  skip_if_not_installed("ggplot2")
  scale <- scale_color_colorify(discrete = TRUE, colors = c("#FF0000", "#00FF00", "#0000FF"))
  expect_true(inherits(scale, "Scale"))
})

test_that("scale_colour_colorify() is identical alias for scale_color_colorify()", {
  expect_identical(scale_colour_colorify, scale_color_colorify)
})

test_that("scale_fill_colorify() returns a ggplot2 Scale object (continuous)", {
  skip_if_not_installed("ggplot2")
  scale <- scale_fill_colorify(colors = "viridis", n = 4)
  expect_true(inherits(scale, "Scale"))
})

test_that("scale_fill_colorify() returns a ggplot2 Scale object (discrete)", {
  skip_if_not_installed("ggplot2")
  scale <- scale_fill_colorify(discrete = TRUE, colors = c("#FF0000", "#00FF00"))
  expect_true(inherits(scale, "Scale"))
})

test_that("scale_color_colorify() can be added to a ggplot without error", {
  skip_if_not_installed("ggplot2")
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg, colour = mpg)) +
    ggplot2::geom_point() +
    scale_color_colorify(colors = "viridis", n = 4)
  expect_no_error(ggplot2::ggplot_build(p))
})

test_that("scale_fill_colorify() can be added to a ggplot without error", {
  skip_if_not_installed("ggplot2")
  df <- data.frame(cat = c("A", "B", "C"), val = c(1, 2, 3))
  p <- ggplot2::ggplot(df, ggplot2::aes(cat, val, fill = cat)) +
    ggplot2::geom_col() +
    scale_fill_colorify(discrete = TRUE, colors = c("#FF0000", "#00FF00", "#0000FF"))
  expect_no_error(ggplot2::ggplot_build(p))
})
