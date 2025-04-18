#' Random location drawing
#'
#' This function draws random unprojected (lonlat) locations.
#'
#' @param nobs Number of observations
#' @param xmin Minimum longitude
#' @param xmax Maximum longitude
#' @param ymin Minimum latitude
#' @param ymax Maximum latitude
#' @param output_type type of output object. Either \code{"data.table"} (default), \code{"data.frame"}, or \code{"SpatVector"}.
#'
#' @details By default, the function draws a global sample of random locations. You can restrict it to a certain region via specifying \code{xmin}, 
#' \code{xmax}, \code{ymin}, and \code{ymax}. The function draws from a uniform spatial distribution that assumes the planet to be a perfect sphere. The 
#' spherical assumption is common in GIS functions, but deviates from Earth's exact shape.
#'
#' @return Returns a data.table, data.frame, or SpatVector object of unprojected (lonlat) points.
#' 
#' @seealso \link{shortest_paths}.
#'
#' @examples
#' rnd_locations(1000)
#'
#' @export
rnd_locations <- function(nobs, xmin = -180, xmax = 180, ymin = -90, ymax = 90, output_type = c("data.table", "data.frame", "SpatVector")) {
  # Check arguments
  if(!is.numeric(xmin) || length(xmin) != 1 || xmin < -180 || xmin > 180) stop("xmin must be numeric, of length one, and between -180 and 180")
  if(!is.numeric(xmax) || length(xmax) != 1 || xmax < -180 || xmax > 180) stop("xmax must be numeric, of length one, and between -180 and 180")
  if(!is.numeric(ymin) || length(ymin) != 1 || ymin < -90 || ymin > 90) stop("ymin must be numeric, of length one, and between -90 and 90")
  if(!is.numeric(ymax) || length(ymax) != 1 || ymax < -90 || ymax > 90) stop("ymax must be numeric, of length one, and between -90 and 90")
  if(xmin > xmax) stop("xmin must not be larger than xmax")
  if(ymin > ymax) stop("ymin must not be larger than ymax")
  output_type <- match.arg(output_type)
  
  # Convert latitude
  if(ymin == -90) ymin <- 0 else ymin <- conv_lat(ymin)
  if(ymax == 90) ymax <- 1 else ymax <- conv_lat(ymax)
  
  # Generate data
  if(output_type == "data.table") {
    locations <- data.table::data.table(x = stats::runif(nobs, xmin, xmax), y = rnd_lat(stats::runif(nobs, ymin, ymax)))
  } else if(output_type == "data.frame") {
    locations <- data.frame(x = stats::runif(nobs, xmin, xmax), y = rnd_lat(stats::runif(nobs, ymin, ymax)))
  } else {
    locations <- terra::vect(data.frame(lat = rnd_lat(stats::runif(nobs, ymin, ymax)), lon = stats::runif(nobs, xmin, xmax)), crs = "epsg:4326")
  }
  return(locations)
}

conv_lat <- function(y) {
  return((cos((y + 90) * pi / 180) + 1) * 0.5)
}

rnd_lat <- function(rv) {
  return(acos(2 * rv - 1) * (180 / pi) - 90)
}
