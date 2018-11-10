# report page themes ---------------------------

define_flashy_header <- function(title, subtitle, header_color,
                                 footer_color) {
  add_colored_block(header_color, vplayout(1, 1:2))
  add_colored_block(footer_color, vplayout(1, 3))
  grid::grid.text(title, vp = vplayout(1, 1:3), just = "left", x = 0.05,
                  y = 0.65, gp = grid::gpar(fontsize = 22, col = "white",
                                            fontface = "bold"))
  grid::grid.text(subtitle, vp = vplayout(1, 1:3), x = 0.05,
                  just = "left", y = 0.35, gp = grid::gpar(col = "white"))
}

define_flashy_footer <- function(footer_text, logo, logo_size,
                                 header_color, footer_color) {
  add_colored_block(header_color, vplayout(3, 1))
  add_colored_block(footer_color, vplayout(3, 2:3))
  set_logo(logo, 0.5, logo_size, vplayout(3, 1))
  grid::grid.text(footer_text, vp = vplayout(3, 2:3),
                  gp = grid::gpar(col = "white"), just = "right", x = 0.95)
}

set_flashy_report_page_theme <- function(header_color, need_header, need_footer,
                                         footer_color, logo, logo_size,
                                         footer_text, title, subtitle) {
  set_layout(3, 3,
             c(0.125, 0.79, 0.085),
             c(0.2, 0.6, 0.2))
  if (need_header == TRUE) {
    define_flashy_header(title, subtitle,
                         header_color, footer_color)
  }
  if (need_footer == TRUE) {
    define_flashy_footer(footer_text, logo, logo_size,
                         header_color, footer_color)
  }
}

# cover page theme ---------------------------

set_flashy_cover_theme <- function(header_color, footer_color,
                                   creaton_time, logo, logo_size,
                                   title, subtitle)  {
  set_layout(11, 5,
             c(0.2, 1, 1, 1, 1, 1, 1, 1, 1, 0.5, 0.2),
             c(0.2, 1, 1, 1, 0.2))
  add_colored_block(header_color, vplayout(2:8, 2))
  add_colored_block(header_color, vplayout(2:6, 3))
  add_colored_block(header_color, vplayout(2:5, 4))
  add_colored_block(footer_color, vplayout(10, 2:4))
  grid::grid.text(title, vp = vplayout(7:8, 3:4),
                  x = 0.05, y = 0.7, just = "left",
                  gp = grid::gpar(fontsize = 32, fontface = "bold"))
  grid::grid.text(subtitle, vp = vplayout(9, 2:4),
                  gp = grid::gpar(fontsize = 14))
  grid::grid.text(creaton_time, vp = vplayout(10, 2:4), just = "center",
                  gp = grid::gpar(fontsize = 12, col = "white"))
  set_logo(logo, 0.5, logo_size, vplayout(6, 4))
}
