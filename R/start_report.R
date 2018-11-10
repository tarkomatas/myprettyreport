set_width_height <- function(value) {
  if (value == "a4r") {
    width <- 29.7
    height <- 21
  } else if (value == "a4") {
    width <- 21
    height <- 29.7
  }
  return(c(width, height))
}

#' Start report
#'
#' This is the first mandatory function to generate the report.
#' It defines some basic parameters.
#' @param filename Character string giving the name of the output PDF file.
#' @param title Title of the report. Character string which appears both on the
#' cover page and the report page. Default title is "Coolest Report Ever".
#' @param subtitle Subitle of the report. Character string which appears both
#' on the cover page and the report page. Default
#' subtitle is "Easy & flexible way to create good-looking reports.".
#' @param size Character string which specifies the paper size of the output
#' PDF file. Currently implemented values
#' are "a4" and "a4r" (rotated landscape). Default paper size is "a4".
#' @examples
#' # minimal example
#' # it generates a PDF file which does not contains anything
#' start_report() %>%
#'   end_report()
#'
#' # custom filename, title and subtitle on the report page
#' start_report(
#'     filename = "mycustom_output",
#'     title = "My Custom Title",
#'     subtitle = "My Custom Subtitle"
#' ) %>%
#'   add_cover_page() %>%
#'   end_report()
#'
#' # rotated landscape (a4r)
#' start_report(size = "a4r") %>%
#'   add_cover_page() %>%
#'   end_report()
#' @export

start_report <- function(filename = "report_output",
                         title = "Coolest Report Ever",
                         subtitle = "Easy & flexible way to create good-looking reports.",
                         size = c("a4", "a4r")) {
  size <- match.arg(size)
  Cairo::Cairo(type = "pdf", file = filename,
               width = set_width_height(size)[1],
               height = set_width_height(size)[2],
               units = "cm", bg = "transparent")
  assign("filename", filename, envir = myprettyreport.env)
  assign("report_title", title, envir = myprettyreport.env)
  assign("report_subtitle", subtitle, envir = myprettyreport.env)
  assign("add_cover_page_executed", FALSE, envir = myprettyreport.env)
}
