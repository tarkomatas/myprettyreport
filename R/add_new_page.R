#' New page
#'
#' This function adds a new page to the report
#' where the visual element(s) can be placed.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @param plot A ggplot2 object to visualize. Default value is ggplot2() which
#' creates a skeleton ggplot2 object.
#' @param need_header Logical. if TRUE header is needed.
#' @param need_footer Logical. if TRUE footer is needed.
#' @param header_color Character string which specifies the color of the header.
#' Only HEX color codes are accepted (e.g. #ffffff). Default value is "#f44242".
#' @param footer_color Character string which specifies the color of the footer.
#' Only HEX color codes are accepted (e.g. #ffffff). Default value is "#3d3c3c".
#' @param logo Name of the logo file which has been already loaded into R.
#' I recommend to use image_read function from package magick
#' to load images into R. Default value is NA which means that nothing
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
#' # add multiple pages to a report
#' sample_plot2 <- ggplot(mpg, aes(displ, hwy, colour = class)) +
#'   geom_point()
#' start_report() %>%
#'   add_new_page(plot = sample_plot) %>%
#'   add_new_page(plot = sample_plot2) %>%
#'   end_report()
#'
#' # add multiple ggplot2 objects to a single page
#' library(patchwork)
#' p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
#' p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
#' multiple_plot_one_page <- p1 + p2 + plot_layout(ncol = 1, heights = c(2, 2))
#' start_report() %>%
#'   add_new_page(plot = multiple_plot_one_page) %>%
#'   end_report()
#' @export

add_new_page <- function(..., plot = ggplot2::ggplot(), need_header = FALSE,
                            need_footer = FALSE, header_color = "#3d3c3c",
                            footer_color = "#f4f4f4", logo = NA,
                            logo_size = NULL, footer_text = "",
                            theme = c("basic", "flashy")) {
  check_if_start_report_function_has_been_called(list(...))
  validate_that_plot_is_a_ggplot_object(plot)
  theme <- match.arg(theme)
  grid::grid.newpage()
  if (theme == "basic") {
    set_basic_report_page_theme(plot, header_color, need_header,
                                need_footer, footer_color, logo,
                                logo_size, footer_text)
  } else if (theme == "flashy") {
    set_flashy_report_page_theme(plot, header_color, need_header,
                                 need_footer, footer_color, logo,
                                 logo_size, footer_text)
  }
}
