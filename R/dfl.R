#' Digital Financial Literacy Score
#'
#' @description Calculates the Digital Financial Literacy Score for a customer with `x` accesses in a product/cluster with digital accesses proportion `p`.
#' @param x: Number of transactions of customer i at time t in cluster j.
#' @param p: Digital proportion at time t in cluster j.
#' @returns Digital Financial Literacy score, `DFL = log(x+1)*(1-log(p))`
#' @examples
#' # library(dfl)
#' # Customer makes x=1 transaction in a product with digital proportion p=1
#' dfl(1,1)
#' # Customer makes x=10 transactions in a product with p=1
#' dfl(10,1)
#' # Customer makes x=1 transaction with p=0.15
#' dfl(1,0.15)
#' # Customer with x=10 and p=0.15
#' dfl(10,0.15)
#' # Customer makes x=c(10,2,57,23) transactions with digital proportions p=c(0.15,0.4,0.7,0.9) at times t=1,2,3,4
#' dfl(c(10,2,57,23),c(0.15,0.4,0.7,0.9))
#' @export
dfl <- function(x,p){
  if(!is.null(length(x))){
    u <- log(x+1)
    r <- -log(p)
    s <- u*(1+r)
    return(max(s))
  }
}