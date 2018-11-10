vplayout <- function(x, y) {
  grid::viewport(layout.pos.row = x, layout.pos.col = y)
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

set_plot_area_layout <- function(plot_area_layout,
                                 need_header, need_footer) {
  if (need_header == TRUE & need_footer == TRUE) {
    vp <- grid::viewport(x = 0.50, y = 0.48, width = 1,
      height = 0.79, layout = plot_area_layout)
  }
  else if (need_header == FALSE & need_footer == FALSE) {
    vp <- grid::viewport(x = 0.5, y = 0.5, width = 1,
      height = 1, layout = plot_area_layout)
  }
  else if (need_header == TRUE & need_footer == FALSE) {
    vp <- grid::viewport(x = 0.5, y = 0.4375, width = 1,
      height = 0.875, layout = plot_area_layout)
  }
  else if (need_header == FALSE & need_footer == TRUE) {
    vp <- grid::viewport(x = 0.5, y = 0.5425, width = 1,
      height = 0.915, layout = plot_area_layout)
  }
  grid::pushViewport(vp)
}

print_plots <- function(ggplot_object, plot_vpos, plot_hpos) {
  if (ggplot2::is.ggplot(ggplot_object)) {
    print(ggplot_object, vp = vplayout(plot_vpos, plot_hpos))
  } else {
    for (i in 1:length(ggplot_object)) {
      print(ggplot_object[[i]], vp = vplayout(plot_vpos[i], plot_hpos[i]))
    }
  }
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

# Global warnings ---------------------------

check_if_start_report_function_has_been_called <- function(dots) {
  if (length(dots) == 0) {
    stop("start_report() is missing. Always start the process with start_report() function.", call. = FALSE)
  } else {
    dots
  }
}
