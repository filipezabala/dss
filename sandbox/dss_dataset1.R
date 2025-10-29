#' DSS Dataset 1
#'
#' Syntetic dataset containing the expected structure to apply on `dss::dss()`.
#'
#' @format A data frame with X rows and Y variables:
#' \describe{
#'   \item{variable1}{Description of variable 1.}
#'   \item{variable2}{Description of variable 2.}
#'   ...
#' }
#' @source The author.
#' @usage 
#' library(dss)
#' data(dss_dataset)
"dss_dataset" # This line associates the documentation with the 'my_data' object

M <- 100
set.seed(42)
dss_dataset <- data.frame(
  id = 1:M,
  n = rnbinom(M, 1, .001),
  p = rbeta(M, 1, 2)
)
dss_dataset


my_vector <- c(10, 20, 30, 40)
save(my_data, my_vector, file = 'dss_dataset.Rda')

devtools::document()