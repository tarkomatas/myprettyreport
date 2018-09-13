# report page themes ---------------------------

define_basic_header <- function(logo, logo_size, title,
                                subtitle, header_color) {
  add_colored_block(header_color, vplayout(2, 1))
  grid::grid.text(title, vp = vplayout(1, 1),
                  gp = grid::gpar(fontsize = 22, fontface = "bold"))
  grid::grid.text(subtitle, vp = vplayout(1, 1), y = 0.23)
  set_logo(logo, 0.13, logo_size, vplayout(1, 1))
}

define_basic_footer <- function(color, page_number) {
  add_colored_block(color, vplayout(6, 1))
  grid::grid.text(page_number, vp = vplayout(7, 1))
}

set_basic_report_page_theme <- function(ggplot_object, header_color,
                                        need_header, need_footer,
                                        footer_color, logo,
                                        logo_size, page_number) {
  set_layout(7, 1,
             c(1.5, 0.4, 3, 3, 3, 0.3, 1),
             c(1))
  from <- 1
  to <- 7
  if (need_header == TRUE) {
    define_basic_header(logo, logo_size, myprettyreport.env$report_title,
                        myprettyreport.env$report_subtitle, header_color)
    from <- 3
  }
  if (need_footer == TRUE) {
    define_basic_footer(footer_color, page_number)
    to <- 5
  }
  print(ggplot_object, vp = vplayout(from:to, 1))
}

# cover page theme ---------------------------

set_basic_cover_theme <- function(header_color, footer_color,
                                  creaton_time, logo, logo_size)  {
  set_layout(3, 1,
             c(1.5, 8, 0.5),
             c(1))
  add_colored_block(header_color, vplayout(1, 1))
  add_colored_block(footer_color, vplayout(3, 1))
  grid::grid.text(myprettyreport.env$report_title, vp = vplayout(2, 1), y = 0.7, x = 0.05, just = "left",
                  gp = grid::gpar(fontsize = 28, fontface = "bold"))
  grid::grid.text(myprettyreport.env$report_subtitle, vp = vplayout(2, 1), y = 0.65, x = 0.05,
                  just = "left", gp = grid::gpar(fontsize = 14))
  grid::grid.text(creaton_time, vp = vplayout(2, 1), y = 0.05,
                  x = 0.95, just = "right")
  set_logo(logo, 0.85, logo_size, vplayout(1, 1))
}
