## hex2rgba() ------------------------------------------------------------------

test_that("hex2rgba() converts 6-char hex to rgba with full opacity", {
  expect_equal(hex2rgba("#FF0000"), "rgba(255,0,0,1)")
  expect_equal(hex2rgba("#00FF00"), "rgba(0,255,0,1)")
  expect_equal(hex2rgba("#0000FF"), "rgba(0,0,255,1)")
})

test_that("hex2rgba() extracts alpha from 8-char hex", {
  expected_alpha <- as.numeric(paste0("0x", "80")) / 255
  expect_equal(hex2rgba("#FF000080"), paste0("rgba(255,0,0,", expected_alpha, ")"))
})

test_that("hex2rgba() overrides alpha when alpha argument provided", {
  expect_equal(hex2rgba("#FF000080", alpha = 0.5), "rgba(255,0,0,0.5)")
  expect_equal(hex2rgba("#FF0000", alpha = 0.0), "rgba(255,0,0,0)")
  expect_equal(hex2rgba("#FF0000", alpha = 1.0), "rgba(255,0,0,1)")
})

test_that("hex2rgba() handles vector input", {
  result <- hex2rgba(c("#FF0000", "#00FF00", "#0000FF"))
  expect_length(result, 3)
  expect_equal(result[1], "rgba(255,0,0,1)")
  expect_equal(result[2], "rgba(0,255,0,1)")
  expect_equal(result[3], "rgba(0,0,255,1)")
})

test_that("hex2rgba() errors on non-character input", {
  expect_error(hex2rgba(123))
})

test_that("hex2rgba() errors when alpha is out of range", {
  expect_error(hex2rgba("#FF0000", alpha = 1.5))
  expect_error(hex2rgba("#FF0000", alpha = -0.1))
})

## hsv2rgb() -------------------------------------------------------------------

test_that("hsv2rgb() converts pure red (h=0, s=100, v=100) correctly", {
  result <- hsv2rgb(0, 100, 100)
  expect_equal(result["r", 1], 100, tolerance = 1e-6)
  expect_equal(result["g", 1], 0,   tolerance = 1e-6)
  expect_equal(result["b", 1], 0,   tolerance = 1e-6)
})

test_that("hsv2rgb() converts pure green (h~33.3, s=100, v=100) correctly", {
  result <- hsv2rgb(100 / 3, 100, 100)
  expect_lt(result["r", 1], 1)
  expect_gt(result["g", 1], 99)
  expect_lt(result["b", 1], 1)
})

test_that("hsv2rgb() converts pure blue (h~66.7, s=100, v=100) correctly", {
  result <- hsv2rgb(200 / 3, 100, 100)
  expect_lt(result["r", 1], 1)
  expect_lt(result["g", 1], 1)
  expect_gt(result["b", 1], 99)
})

test_that("hsv2rgb() returns matrix with r, g, b row names", {
  result <- hsv2rgb(0, 100, 100)
  expect_true(is.matrix(result))
  expect_equal(rownames(result), c("r", "g", "b"))
})

test_that("hsv2rgb() scales output by maxColorValue", {
  result_100 <- hsv2rgb(0, 100, 100, maxColorValue = 100)
  result_255 <- hsv2rgb(0, 100, 100, maxColorValue = 255)
  expect_equal(result_255["r", 1] / result_100["r", 1], 255 / 100, tolerance = 1e-6)
})

test_that("hsv2rgb() returns black when v = 0", {
  result <- hsv2rgb(0, 100, 0)
  expect_equal(result["r", 1], 0, tolerance = 1e-6)
  expect_equal(result["g", 1], 0, tolerance = 1e-6)
  expect_equal(result["b", 1], 0, tolerance = 1e-6)
})

test_that("hsv2rgb() returns white when s = 0 and v = 100", {
  result <- hsv2rgb(0, 0, 100)
  expect_equal(result["r", 1], 100, tolerance = 1e-6)
  expect_equal(result["g", 1], 100, tolerance = 1e-6)
  expect_equal(result["b", 1], 100, tolerance = 1e-6)
})

test_that("hsv2rgb() handles vector input", {
  result <- hsv2rgb(c(0, 100 / 3, 200 / 3), c(100, 100, 100), c(100, 100, 100))
  expect_equal(ncol(result), 3)
})
