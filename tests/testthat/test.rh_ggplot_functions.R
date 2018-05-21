###############################################################################
# 2017-12-14
# Tests functions for use with ggplot2
#'
###############################################################################

data <- data.frame(
  x = 1:4,
  y = -2:1
)

p <- ggplot(data, aes(x = x, y = y)) + geom_point()

###############################################################################

test_that("get ggplot x and y ranges", {
  xrng <- .get_ggplot_x_range(p)
  yrng <- .get_ggplot_y_range(p)

  with(
    data,
    expect_true(
      xrng[1] <= min(x) && xrng[2] >= max(x) &&
        yrng[1] <= min(y) && yrng[2] >= max(y)
    )
  )
})

###############################################################################

test_that(".get_sym_range", {
  expect_error(
    .get_sym_range(),
    info = ".get_sym_range: empty input"
  )
  expect_error(
    .get_sym_range("Not a numeric"),
    info = ".get_sym_range: non-numeric"
  )
  expect_equal(
    .get_sym_range(c(-1, 1, 2)),
    c(-2, 2),
    info = ".get_sym_range"
  )
})

###############################################################################

test_that("setting symmetrical ranges on a ggplot", {
  xrng <- .get_ggplot_x_range(p + xlim_sym())
  expect_true(
    xrng[1] <= -4 && xrng[2] >= 4,
    info = "x-axis symmetrised about zero contains -max to +max"
  )

  yrng <- .get_ggplot_y_range(p + ylim_sym())
  expect_true(
    yrng[1] <= -2 && yrng[2] >= 2,
    info = "y-axis symmetrised about zero contains -max to +max"
  )
})

###############################################################################
