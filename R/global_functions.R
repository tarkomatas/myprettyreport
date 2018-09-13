vplayout <- function(x, y) {
  grid::viewport(layout.pos.row = x, layout.pos.col = y)
}

set_layout <- function(number_of_rows, number_of_columns,
                       page_heights, page_widths) {
  page_heights <- grid::unit(page_heights, "null")
  page_widths <- grid::unit(page_widths, "null")
  grid::pushViewport(grid::viewport(layout = grid::grid.layout(number_of_rows,
                                                     number_of_columns,
                                                     heights = page_heights,
                                                     widths = page_widths)))
}

add_colored_block <- function(color, vp) {
  grid::grid.rect(vp = vp, gp = grid::gpar(col = "white", lwd = 10,
                                           fill = color))
}

set_logo <- function(logo, horizontal_position,
                     width = NULL, vp = vp) {
  grid::grid.raster(logo, vp = vp, width = width,
                    x = horizontal_position)
}

# Global warnings ---------------------------

check_if_start_report_function_has_been_called <- function(dots) {
  if (length(dots) == 0) {
    stop("start_report() is missing. Always start the process with start_report() function.", call. = FALSE)
  } else {
    dots
  }
}

validate_that_plot_is_a_ggplot_object <- function(plot_to_validate) {
  if (ggplot2::is.ggplot(plot_to_validate) == FALSE) {
    stop("plot is not a ggplot object. Unfortunately the report only works with ggplot objects.", call. = FALSE)
  }
}

# check_for_active_graphical_devices <- function() {
#   if (!is.null(grDevices::dev.list())) {
#     stop("at least 1 active graphical device has been created. Use dev.off() or graphics.off() before calling this function.", call. = FALSE)
#   }
# }

