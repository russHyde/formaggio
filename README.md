# formaggio
Some formatting functions for use with ggplot2

There are a few helper functions that I use frequently with ggplot2. They have been put here for future reference.

To symmetrise a plot about the y-axis without having to precompute the range of the y-variable, use the following

~~~~
my_plot <- ggplot(...) + geom_...(...) + ylim_sym()
~~~~

A comparable method `xlim_sym` exists for imposing x-axis symmetry
