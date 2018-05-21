###############################################################################
# 2017-12-14
# Functions for use with ggplot2
#'
###############################################################################

#' Returns a function that can be used to get the x- or y-axes from a ggplot
#'
.build_ggplot_coord_range_getter <- function(axis) {
  function(p) {
    ggplot2::layer_scales(p)[[axis]]$range$range
  }
}

.get_ggplot_x_range <- .build_ggplot_coord_range_getter("x")
.get_ggplot_y_range <- .build_ggplot_coord_range_getter("y")

###############################################################################

#' Function that returns the symmetrised range of a vector of numeric values
#'
.get_sym_range <- function(x) {
  c(-1, 1) * max(abs(x))
}

###############################################################################

#' Function that can be used to construct the Stat[X|Y]LimSym classes
#'
#' @importFrom   ggplot2       ggproto   Stat
#'
.sym_lim_class_factory <- function(class_name, x_mutator, y_mutator) {
  ggplot2::ggproto(
    class_name,
    ggplot2::Stat,
    compute_group = function(data, scales) {
      data.frame(
        x = x_mutator(data$x),
        y = y_mutator(data$y)
      )
    },
    required_aes = c("x", "y")
  )
}

###############################################################################

#' Stat-class that defines y-limits to be symmetrical with-respect to the line
#' y=0
#'
StatSymYLim <- .sym_lim_class_factory(
  "StatSymYLim",
  x_mutator = median,
  y_mutator = .get_sym_range
)

#' Stat-class that defines x-limits to be symmetrical with-respect to the line
#' x=0
#'
#'
StatSymXLim <- .sym_lim_class_factory(
  "StatSymXLim",
  x_mutator = .get_sym_range,
  y_mutator = median
)

###############################################################################

#' Function that defines y-limits to be symmetrical with-respect to the line
#' y = 0
#'
#' @param        ...           Arguments to be passed to geom_blank
#'
#' @importFrom   ggplot2       geom_blank
#' @export
#'
ylim_sym <- function(...) {
  ggplot2::geom_blank(..., stat = StatSymYLim)
}

#' Function that defines x-limits to be symmetrical with-respect to the line
#' x = 0
#'
#' @param        ...           Arguments to be passed to geom_blank
#'
#' @importFrom   ggplot2       geom_blank
#' @export
#'
xlim_sym <- function(...) {
  ggplot2::geom_blank(..., stat = StatSymXLim)
}

###############################################################################
