## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----out.width = "46%", out.height = "30%", fig.show = "hold", fig.align = "center", fig.cap = "Figure 1: Contiguity", echo = FALSE----
knitr::include_graphics("Figure_1a.png")
knitr::include_graphics("Figure_1b.png")


## ----out.width = "46%", fig.show = "hold", fig.align = "center", fig.cap = "Figure 2: Edge Weights", echo = FALSE----
knitr::include_graphics("Figure_2.png")


## ----eval = FALSE-------------------------------------------------------------
#  Rcpp::sourceCpp(code = '
#    #include <RcppArmadillo.h>
#    // [[Rcpp::depends(RcppArmadillo)]]
#    // [[Rcpp::plugins(cpp20)]]
#  
#    // [[Rcpp::export]]
#    Rcpp::NumericVector example_tr_fun(arma::mat &v1, arma::mat &v2, Rcpp::NumericVector &d) {
#      ...
#    }
#  ')

## ----eval = FALSE-------------------------------------------------------------
#  set.seed(3L)
#  input_grid <- terra::rast(crs = "epsg:4326", resolution = 2, vals = sample(c(1L, NA_integer_), 16200L,
#    TRUE, c(0.8, 0.2)))
#  origin_pts <- rnd_locations(3L, output_type = "SpatVector")
#  destination_pts <- rnd_locations(3L, output_type = "SpatVector")
#  
#  shortest_paths(input_grid, origin_pts)
#  
#     origins destinations distances
#       <int>        <int>     <num>
#  1:       1            2  19627694
#  2:       1            3   7290325
#  3:       2            3  14467797
#  
#  shortest_paths(input_grid, origin_pts, destination_pts)
#  
#     origins destinations distances
#       <int>        <int>     <num>
#  1:       1            1  13313293
#  2:       1            2   6158046
#  3:       1            3  15837664
#  4:       2            1   9137621
#  5:       2            2  16130624
#  6:       2            3   4810903
#  7:       3            1  15919393
#  8:       3            2  10787554
#  9:       3            3  19275995

## ----eval = FALSE-------------------------------------------------------------
#  shortest_paths(input_grid, origin_pts, output = "lines")
#  
#   class       : SpatVector
#   geometry    : lines
#   dimensions  : 3, 3  (geometries, attributes)
#   extent      : -179, 179, -63, -1  (xmin, xmax, ymin, ymax)
#   coord. ref. : lon/lat WGS 84 (EPSG:4326)
#   names       : origins destinations connected
#   type        :   <int>        <int> <logical>
#   values      :       1            2      TRUE
#                       1            3      TRUE
#                       2            3      TRUE
#  
#  shortest_paths(input_grid, origin_pts, output = "both")
#  
#   class       : SpatVector
#   geometry    : lines
#   dimensions  : 3, 3  (geometries, attributes)
#   extent      : -179, 179, -63, -1  (xmin, xmax, ymin, ymax)
#   coord. ref. : lon/lat WGS 84 (EPSG:4326)
#   names       : origins destinations distances
#   type        :   <int>        <int>     <num>
#   values      :       1            2 1.963e+07
#                       1            3  7.29e+06
#                       2            3 1.447e+07

## ----eval = FALSE-------------------------------------------------------------
#  shortest_paths(input_grid, origin_pts)
#  
#     origins destinations distances
#       <int>        <int>     <num>
#  1:       1            2  19627694
#  2:       1            3   7290325
#  3:       2            3  14467797
#  
#  shortest_paths(input_grid, origin_pts, bidirectional = TRUE)
#  
#     origins destinations distances
#       <int>        <int>     <num>
#  1:       1            2  19627694
#  2:       1            3   7290325
#  3:       2            3  14467797
#  4:       2            1  19627694
#  5:       3            1   7290325
#  6:       3            2  14467797

## ----eval = FALSE-------------------------------------------------------------
#  shortest_paths(input_grid, origin_pts, destination_pts, pairwise = TRUE)
#  
#     origins destinations distances
#       <int>        <int>     <num>
#  1:       2            2  16130624
#  2:       1            1  13313293
#  3:       3            3  19275995

## ----eval = FALSE-------------------------------------------------------------
#  origin_pts$name <- letters[1:3]
#  shortest_paths(input_grid, origin_pts, origin_names = "name")
#  
#     origins destinations distances
#      <char>       <char>     <num>
#  1:       a            b  19627694
#  2:       a            c   7290325
#  3:       b            c  14467797

## ----eval = FALSE-------------------------------------------------------------
#  shortest_paths(input_grid, origin_pts, output_class = "data.frame")
#  
#    origins destinations distances
#  1       1            2  19627694
#  2       1            3   7290325
#  3       2            3  14467797

## ----eval = FALSE-------------------------------------------------------------
#  barrier <- terra::vect("POLYGON ((-179 -25, 100 -25, 100 -26, -179 -26, -179 -25))", crs = "epsg:4326")
#  shortest_paths(input_grid, origin_pts, update_rst = barrier)
#  
#     origins destinations distances layer
#       <int>        <int>     <num> <int>
#  1:       1            2  19627694     0
#  2:       1            3   7290325     0
#  3:       2            3  14467797     0
#  4:       1            2  19627694     1
#  5:       1            3  13207350     1
#  6:       2            3  15465933     1
#  
#  barriers <- list(barrier, terra::vect("POLYGON ((0 20, 1 20, 1 -20, 0 -20, 0 20))", crs = "epsg:4326"))
#  shortest_paths(input_grid, origin_pts, update_rst = barriers)
#  
#     origins destinations distances layer
#       <int>        <int>     <num> <int>
#  1:       1            2  19627694     0
#  2:       1            3   7290325     0
#  3:       2            3  14467797     0
#  4:       1            2  19627694     1
#  5:       1            3  13207350     1
#  6:       2            3  15465933     1
#  7:       1            2  19813077     2
#  8:       1            3   7290325     2
#  9:       2            3  14467797     2

## ----eval = FALSE-------------------------------------------------------------
#  set.seed(3L)
#  input_grid <- matrix(sample(c(1L, NA_integer_), 16200L, TRUE, c(0.8, 0.2)), nrow = 90)

## ----eval = FALSE-------------------------------------------------------------
#  set.seed(3L)
#  origin_pts <- rnd_locations(3L)
#  
#  shortest_paths(input_grid, origin_pts, spherical = TRUE, radius = 3389500, extent = c(-180, 180, -90, 90))
#  
#     origins destinations distances
#       <int>        <int>     <num>
#  1:       1            2   8229741
#  2:       1            3   5372309
#  3:       2            3   9088755

## ----eval = FALSE-------------------------------------------------------------
#  set.seed(3L)
#  input_grid <- list(even_terrain = input_grid, temperature = matrix(stats::rnorm(16200L, 20, 5), nrow = 90))
#  custom_tr <- function(v1, v2) v1[[1L]] * v2[[1L]] + v1[[2L]] * v2[[2L]]
#  custom_tr <- function(v1, v2) v1[["even_terrain"]] * v2[["even_terrain"]] + v1[["temperature"]] * v2[["temperature"]]
#  
#  shortest_paths(input_grid, origin_pts, spherical = TRUE, radius = 3389500, extent = c(-180, 180, -90, 90), tr_fun = custom_tr)
#  
#     origins destinations distances
#       <int>        <int>     <num>
#  1:       1            2  15973.37
#  2:       1            3  10254.19
#  3:       2            1  15973.37
#  4:       2            3  17432.90
#  5:       3            1  10254.19
#  6:       3            2       Inf

## ----eval = FALSE-------------------------------------------------------------
#  set.seed(3L)
#  input_grid <- matrix(sample(c(1L, NA_integer_), 16200L, TRUE, c(0.8, 0.2)), nrow = 90)
#  
#  barrier_vector <- sample.int(16200L, 10L)
#  shortest_paths(input_grid, origin_pts, spherical = TRUE, radius = 3389500, extent = c(-180, 180, -90, 90), update_rst = barrier_vector)
#  
#     origins destinations distances layer
#       <int>        <int>     <num> <int>
#  1:       1            2   8229741     0
#  2:       1            3   5372309     0
#  3:       2            3   9088755     0
#  4:       1            2   8229741     1
#  5:       1            3   5372309     1
#  6:       2            3   9088755     1
#  
#  barrier_matrix <- matrix(rep.int(1L, 16200L), nrow = 90)
#  barrier_matrix[sample.int(16200L, 10L)] <- NA_integer_
#  shortest_paths(input_grid, origin_pts, spherical = TRUE, radius = 3389500, extent = c(-180, 180, -90, 90), update_rst = barrier_matrix)
#  
#     origins destinations distances layer
#       <int>        <int>     <num> <int>
#  1:       1            2   8229741     0
#  2:       1            3   5372309     0
#  3:       2            3   9088755     0
#  4:       1            2   8229741     1
#  5:       1            3   5372309     1
#  6:       2            3   9088755     1

## ----eval = FALSE-------------------------------------------------------------
#  shortest_paths(input_grid, origin_pts, show_progress = TRUE)
#  
#  Checking arguments
#  Converting spatial inputs
#  Preparing algoritm inputs
#  Starting distances calculation
#  |---|
#  |===|
#  Generating output object
#     origins destinations distances
#       <int>        <int>     <num>
#  1:       1            2  19627694
#  2:       1            3   7290325
#  3:       2            3  14467797

