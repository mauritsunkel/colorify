## Smoke tests for plotting functions — validate they run without error.
## Graphics output is redirected to a null PDF device.

test_that("colortistry() renders without error", {
  colors_list <- list(
    colorify(n = 5, colors = "viridis"),
    colorify(n = 5, colors = c("#FF0000", "#0000FF"))
  )
  expect_no_error({
    grDevices::pdf(NULL)
    colortistry(colors_list)
    grDevices::dev.off()
  })
})

test_that("colortistry() accepts border_color argument", {
  colors_list <- list(colorify(n = 3, colors = c("#FF0000", "#00FF00", "#0000FF")))
  expect_no_error({
    grDevices::pdf(NULL)
    colortistry(colors_list, border_color = "black")
    grDevices::dev.off()
  })
})

test_that("display_palettes() renders without error", {
  expect_no_error({
    grDevices::pdf(NULL)
    display_palettes(n = 3, i_palettes = 1:2)
    grDevices::dev.off()
  })
})

test_that("colorify() plot = TRUE renders without error", {
  expect_no_error({
    grDevices::pdf(NULL)
    colorify(n = 5, seed = 42, plot = TRUE)
    grDevices::dev.off()
  })
})

test_that("colorify() plot = 'il' renders image with labels without error", {
  expect_no_error({
    grDevices::pdf(NULL)
    colorify(n = 5, seed = 42, plot = "il")
    grDevices::dev.off()
  })
})
