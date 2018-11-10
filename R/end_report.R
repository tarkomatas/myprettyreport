print_end_message <- function() {
  message("Report making process finished.")
}

#' End report
#'
#' This function is not requires any values to specify.
#' It is only implemented for generating the final output file and cleaning up
#' after the report making process ends. Important to note that this only
#' works if at least the start_report() function has been executed already.
#' @param ... Other arguments passed on to methods.
#' It is only for technical usage.
#' @examples
#' # minimal example
#' # it generates a PDF file which does not contains anything
#' start_report() %>%
#'   end_report()
#' @export

end_report <- function(...) {
  check_if_start_report_function_has_been_called(list(...))
  grDevices::dev.off()
  print_end_message()
  rm(list = c("report_title", "report_subtitle", "filename",
              "add_cover_page_executed"),
     envir = myprettyreport.env)
}
