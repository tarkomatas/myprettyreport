set_page_number <- function(page_number, plot) {
  if (is.null(page_number)) {
    page_number
  }
  else if (page_number[1] == c("default")) {
    first_page <- 1
    last_page <- length(plot)
    if (myprettyreport.env$add_cover_page_executed == TRUE) {
      first_page <- first_page + 1
      last_page <- last_page + 1
    }
    page_number <- paste0(seq(first_page, last_page), " / ", last_page)
  } else {
    page_number
  }
}

#' Add multiple page
#'
#' This function allows us to create multiple report page automatically
#' from a list which contains ggplot objects. It helps to simplify the code when
#' it is required to create multiple report pages to a single report. This
#' function has same parameters as add_new_page() function except
#' plot and page_number parameters.
#' @param ... Other add_new_page() arguments passed on to methods. Check the
#' documentation of add_new_page() function for more details.
#' @param plot A list of ggplot2 objects to visualize.
#' @param page_number Character string value which defines
#' the page number generator method. The default value "default" means
#' that every page will have a page number in the bottom right corner
#' in a format of paste0(seq(first_page, last_page), " / ", last_page).
#' See the example section for more details. Set the value of this paramter to
#' NULL if you want to just ignore this feature.
#' @examples
#' # minimal example
#' library(ggplot2)
#' sample_plot <- ggplot(data = mtcars, mapping = aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   stat_smooth(method = 'lm')
#' sample_plot2 <- ggplot(mpg, aes(displ, hwy, colour = class)) +
#'   geom_point()
#' plot_list <- list(sample_plot, sample_plot2, ggplot())
#' start_report() %>%
#'   add_multiple_page(
#'     plot = plot_list
#'   ) %>%
#'   end_report()
#'
#' # multiple report page and multiple plot in one page at the same time
#' # Need to create a list which contains sublists:
#' plot_list <- list(
#'   list(sample_plot, sample_plot2),
#'   list(sample_plot2, sample_plot)
#' )
#'
#' start_report() %>%
#'   add_multiple_page(
#'     plot = plot_list,
#'     plot_hpos = c(1, 2),
#'     plot_vpos = c(1, 2),
#'     plot_area_layout = grid::grid.layout(2, 2,
#'                                          width = c(1, 1),
#'                                          heigh = c(1, 1))
#'   ) %>%
#'   end_report()
#' # custom page number
#' plot_list <- list(sample_plot, sample_plot2)
#' custom_page_number <- paste0("page: ", seq(1, length(plot_list)))
#'
#' start_report() %>%
#'   add_multiple_page(
#'     plot = plot_list,
#'     need_footer = TRUE,
#'     page_number = custom_page_number
#'   ) %>%
#'   end_report()
#'
#' # ignore automatic page number function
#' start_report() %>%
#'   add_multiple_page(
#'     plot = plot_list,
#'     need_footer = TRUE,
#'     page_number = NULL
#'   ) %>%
#'   end_report()
#'
#' @export

add_multiple_page <- function(..., plot,
                              page_number = c("default")) {
  page_number <- set_page_number(page_number, plot)
  pb <- utils::txtProgressBar(min = 1, max = length(plot), style = 3)
  for (i in 1:length(plot)) {
    add_new_page(..., plot = plot[[i]], footer_text = page_number[i])
    utils::setTxtProgressBar(pb, i)
  }
  close(pb)
}
