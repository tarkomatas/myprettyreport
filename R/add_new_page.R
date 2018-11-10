#' New page
#'
#' This function adds a new page to the report
#' where the visual element(s) can be placed.
#' @param ... Other arguments passed on to methods.
#' It is only for technical usage.
#' @param plot A ggplot2 object to visualize. Default value is ggplot2() which
#' creates a skeleton ggplot2 object.
#' @param need_header Logical. if TRUE header is needed.
#' @param need_footer Logical. if TRUE footer is needed.
#' @param header_color Character string which specifies the color of the header.
#' Only HEX color codes are accepted (e.g. #ffffff). Default value is "#3d3c3c".
#' @param footer_color Character string which specifies the color of the footer.
#' Only HEX color codes are accepted (e.g. #ffffff). Default value is "#f4f4f4".
#' @param logo Name of the logo file which has been already loaded into R.
#' I recommend to use magick::image_read function to load images into R.
#' Default value is NA which means that nothing
#' will appear in place of the logo.
#' @param logo_size Numeric value which specifies the size of the logo.
#' Default value is NULL which means that the original size of the logo
#' file will be used.
#' @param footer_text Character string value which is implemented mainly for
#' displaying the current page number of the report
#' but it can be used for other purpose.
#' Default value is "".
#' @param theme Character string which specifies the theme of the report.
#' Possible values are "basic" and "flashy". Try both
#' themes and check the differences.
#' @param plot_area_layout Custom layout can be defined with the grid::grid.layout()
#' function. Check the example section for more details.
#' @param plot_vpos Numerical value which specifies the vertical position of the plot.
#' It only works if plot_area_layout parameter is also specified.
#' @param plot_hpos Numerical value which specifies the horizontal position of
#' the plot. It only works if plot_area_layout parameter is also specified.
#' @param extra_layout_params User defined grid functions can be
#' passed in the PDF report to modify the header or the footer region.
#' It has to be defined as a dummy function, see the example section
#' for more details.
#' @param extra_plot_params User defined grid functions can be
#' passed in the PDF report to modify the plot region.
#' It has to be defined as a dummy function, see the example section
#' for more details.
#' @param title Character string which allows to set up user defined title
#' to a single report page. The default value is the previously defined
#' start_report() title parameter.
#' @param subtitle Character string which allows to set up user defined subtitle
#' to a single report page. The default value is the previously defined
#' start_report() subtitle parameter.
#' @examples
#' # minimal example
#' # it generates a PDF file which contains a skeleton ggplot object.
#' start_report() %>%
#'   add_new_page() %>%
#'   end_report()
#'
#' # add a ggplot2 object to a report
#' library(ggplot2)
#' sample_plot <- ggplot(data = mtcars, mapping = aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   stat_smooth(method = 'lm')
#' start_report() %>%
#'   add_new_page(plot = sample_plot) %>%
#'   end_report()
#'
#' # add multiple pages manually to a report
#' sample_plot2 <- ggplot(mpg, aes(displ, hwy, colour = class)) +
#'   geom_point()
#' start_report() %>%
#'   add_new_page(plot = sample_plot) %>%
#'   add_new_page(plot = sample_plot2) %>%
#'   end_report()
#'
#' # add multiple plot to a single report page
#' # in this case plot_area_layout and horizontal
#' # and vertical postion of the plot also have to be defined.
#' start_report() %>%
#'   add_new_page(
#'       plot = list(sample_plot, sample_plot2),
#'       plot_hpos = c(1, 2),
#'       plot_vpos = c(1, 2),
#'       plot_area_layout = grid::grid.layout(2, 2,
#'                                            width = c(1, 1),
#'                                            heigh = c(1, 1))
#'   ) %>%
#'   end_report()
#'
#' # alternatively other libraries can be used
#' # for plotting multiple ggplot objects to a single report page. The result
#' # will be the same.
#' library(patchwork)
#'
#' multiple_plot_one_page <- sample_plot + patchwork::plot_spacer() +
#'                           patchwork::plot_spacer() + sample_plot2 +
#'                           patchwork::plot_layout(ncol = 2, nrow = 2)
#'
#' start_report() %>%
#'   add_new_page(
#'     plot = multiple_plot_one_page
#'   ) %>%
#'   end_report()
#' # add extra grid parameters to a report
#' rp_e_plot_params = function() {
#'    grid::grid.text("example text")
#' }
#' start_report() %>%
#'   add_new_page(
#'     plot = sample_plot,
#'     extra_plot_params = rp_e_plot_params
#'   ) %>%
#'   end_report()
#' @export

add_new_page <- function(..., plot = ggplot2::ggplot(), need_header = FALSE,
                         need_footer = FALSE, header_color = "#3d3c3c",
                         footer_color = "#f4f4f4", logo = NA, logo_size = NULL,
                         footer_text = "", theme = c("basic", "flashy"),
                         plot_area_layout = NULL, plot_vpos = 1,
                         plot_hpos = 1, extra_layout_params = function(){},
                         extra_plot_params = function(){},
                         title = myprettyreport.env$report_title,
                         subtitle = myprettyreport.env$report_subtitle) {
  check_if_start_report_function_has_been_called(list(...))
  theme <- match.arg(theme)
  grid::grid.newpage()
  if (theme == "basic") {
    set_basic_report_page_theme(header_color, need_header,
                                need_footer, footer_color, logo,
                                logo_size, footer_text, title, subtitle)
  } else if (theme == "flashy") {
    set_flashy_report_page_theme(header_color, need_header,
                                 need_footer, footer_color, logo,
                                 logo_size, footer_text, title, subtitle)
  }
  extra_layout_params()
  set_plot_area_layout(plot_area_layout, need_header, need_footer)
  print_plots(plot, plot_vpos, plot_hpos)
  extra_plot_params()
}
