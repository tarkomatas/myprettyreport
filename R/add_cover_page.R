#' Cover page
#'
#' This function generates the cover page of the report. It is fully optional
#' to use it so just leave this function out of the code if you do not need
#' cover page.
#' @param ... Other arguments passed on to methods.
#' It is only for technical usage.
#' @param header_color Character string which specifies the color of the header.
#' Only HEX color codes are accepted (e.g. #ffffff). Default value is "#f44242".
#' @param footer_color Character string which specifies the color of the footer.
#' Only HEX color codes are accepted (e.g. #ffffff). Default value is "#3d3c3c".
#' @param creaton_time Character string value which is implemented for
#' displaying creation time of the report but it can be used for other purpose.
#' Default value is Sys.Date().
#' @param logo Name of the logo file which has been already loaded into R.
#' I recommend to use image_read function from package magick
#' to load images into R. Default value is NA which means that nothing
#' will appear in place of the logo.
#' @param logo_size Numeric value which specifies the size of the logo.
#' Default value is NULL which means that the original size of the logo
#' file will be used.
#' @param theme Character string which specifies the theme of the report.
#' Possible values are "basic" and "flashy". Try both
#' themes and check the differences.
#' @param extra_layout_params User defined grid functions can be
#' passed in the PDF report to modify the layout region.
#' It has to be defined as a dummy function, see the example section
#' for more details.
#' @param title Character string which allows to set up user defined title
#' to a cover page. The default value is the previously defined
#' start_report() title parameter.
#' @param subtitle Character string which allows to set up user defined subtitle
#' to a cover page. The default value is the previously defined
#' start_report() subtitle parameter.
#' @examples
#' # minimal example
#' # it generates PDF file with only a cover page.
#' start_report() %>%
#'   add_cover_page() %>%
#'   end_report()
#'
#' # change the theme of the report from default.
#' start_report() %>%
#'   add_cover_page(theme = "flashy") %>%
#'   end_report()
#'
#' # add a logo to a report
#' # 1. load the logo file.
#' library(magick)
#' sample_logo <- magick::image_read("http://myhappydata.com/img/1.png")
#' # 2. add the loaded file to a report.
#' start_report() %>%
#'   add_cover_page(logo = sample_logo) %>%
#'   end_report()
#'
#' # change the default colors to custom ones.
#' start_report() %>%
#'   add_cover_page(
#'     header_color = "#6DCFF6",
#'     footer_color = "#D8D3CB"
#'   ) %>%
#'   end_report()
#'
#' # pass extra grid paramters into the report
#' cp_e_params = function() {
#'    grid::grid.rect(gp = grid::gpar(fill = "grey"),
#'                    vp = grid::viewport(layout.pos.row = 2,
#'                                        layout.pos.col = 1),
#'                    width = 0.8, height = 0.2)
#'    grid::grid.text("example text",
#'                    vp = grid::viewport(layout.pos.row = 2,
#'                                        layout.pos.col = 1))
#' }
#'
#' start_report() %>%
#'   add_cover_page(
#'     extra_layout_params = cp_e_params
#'   ) %>%
#'   end_report()
#' @export

add_cover_page <- function(..., header_color = "#f44242",
                           footer_color = "#3d3c3c", creaton_time = Sys.Date(),
                           logo = NA, logo_size = NULL,
                           theme = c("basic", "flashy"),
                           extra_layout_params = function(){},
                           title = myprettyreport.env$report_title,
                           subtitle = myprettyreport.env$report_subtitle) {
  check_if_start_report_function_has_been_called(list(...))
  theme <- match.arg(theme)
  grid::grid.newpage()
  if (theme == "basic") {
    set_basic_cover_theme(header_color, footer_color, creaton_time,
                          logo, logo_size, title, subtitle)
  } else if (theme == "flashy") {
    set_flashy_cover_theme(header_color, footer_color, creaton_time,
                           logo, logo_size, title, subtitle)
  }
  extra_layout_params()
  myprettyreport.env$add_cover_page_executed <- TRUE
}
