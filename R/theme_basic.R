# report page themes ---------------------------

define_basic_header <- function(logo, logo_size, title,
                                subtitle, header_color) {
  add_colored_block(header_color, vplayout(2, 1))
  grid::grid.text(title, vp = vplayout(1, 1),
                  gp = grid::gpar(fontsize = 20, fontface = "bold"))
  grid::grid.text(subtitle, vp = vplayout(1, 1), y = 0.23)
  set_logo(logo, 0.10, logo_size, vplayout(1, 1))
}

define_basic_footer <- function(color, footer_text) {
  add_colored_block(color, vplayout(4, 1))
  grid::grid.text(footer_text, vp = vplayout(5, 1), just = "right", x = 0.95)
}

set_basic_report_page_theme <- function(header_color, need_header, need_footer,
                                        footer_color, logo, logo_size,
                                        footer_text, title, subtitle) {
  set_layout(5, 1,
             c(0.10, 0.025, 0.79, 0.025, 0.06),
             c(1))
  if (need_header == TRUE) {
    define_basic_header(logo, logo_size, title,
                        subtitle, header_color)
  }
  if (need_footer == TRUE) {
    define_basic_footer(footer_color, footer_text)
  }
}

# cover page theme ---------------------------

set_basic_cover_theme <- function(header_color, footer_color,
                                  creaton_time, logo, logo_size, title,
                                  subtitle)  {
  set_layout(3, 1,
             c(0.15, 0.8, 0.05),
             c(1))
  add_colored_block(header_color, vplayout(1, 1))
  add_colored_block(footer_color, vplayout(3, 1))
  grid::grid.text(title, vp = vplayout(2, 1), y = 0.7, x = 0.05, just = "left",
                  gp = grid::gpar(fontsize = 28, fontface = "bold"))
  grid::grid.text(subtitle, vp = vplayout(2, 1), y = 0.65, x = 0.05,
                  just = "left", gp = grid::gpar(fontsize = 14))
  grid::grid.text(creaton_time, vp = vplayout(2, 1), y = 0.10,
                  x = 0.95, just = "right")
  set_logo(logo, 0.9, logo_size, vplayout(1, 1))
}
