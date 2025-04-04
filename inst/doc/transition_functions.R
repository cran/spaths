## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----out.width = "46%", out.height = "30%", fig.show = "hold", fig.align = "center", fig.cap = "Figure 1: Contiguity", echo = FALSE----
knitr::include_graphics("Figure_1a.png")
knitr::include_graphics("Figure_1b.png")


## ----eval = FALSE-------------------------------------------------------------
# function(d, v1, v2) d / (6000 * exp(-3.5 * abs((v2 - v1) / d + 0.05)))

## ----eval = FALSE-------------------------------------------------------------
# travel_time <- function(d, v1, v2) {
#   return(
#     d / (
#       ((v1[[2L]] == 0L & v2[[2L]] == 0L) * 6000 * exp((-3.5) * abs((v2[[1L]] - v1[[1L]]) / d + 0.05))) + # Land to land: Tobler's hiking function
#       ((v1[[2L]] == 2L & v2[[2L]] == 2L) * 12000) + # sea to sea: 12 km/h
#       ((v1[[2L]] + v2[[2L]] != 4L & v1[[2L]] > 0L & v2[[2L]] > 0L) * 5000) + # river to river, river to sea, or sea to river: 5 km/h
#       (((v1[[2L]] == 0L & v2[[2L]] > 0L) | (v1[[2L]] > 0L & v2[[2L]] == 0L)) * 1000) # Land to river/ sea or river/ sea to land: 1 km/h
#     )
#   )
# }

