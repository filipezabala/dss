#' Digital Skill Score - DSS
#'
#' @description Calculates the Digital Skill Score for a customer with `x` transactions with digital proportion `p`.
#' @param x: Number of transactions.
#' @param p: Digital proportion.
#' @param group_by: Must group_by 'day', 'month' (Default), 'quarter' or 'year'?
#' @returns Digital Skill Score, `dss = log(x+1)*(1-log(p))`
#' @examples
#' library(dss)
#' 
#' dss(dss_dataset2)
#' @export
dss <- function(x, p = NULL, group_by = 'month'){
  # Simplest DSS function (vector)
  dss0 <- function(x, p){
    if(is.null(p)){
      print('Must enter p!')
    } else{
      u <- log(x+1)
      r <- -log(p)
      s <- u*(1+r)
    }
  }
  if(is.vector(x)){
    s <- dss0(x,p)
    return(s)
  }
  
  # Creating time-grouping variables
  if(is.data.frame(x)){
    x0 <- x %>%
      dplyr::mutate(
        day = format(lubridate::ymd(time), "%Y-%m-%d"),
        month = format(lubridate::ymd(time), "%Y-%m"),
        quarter = paste0(lubridate::year(lubridate::ymd(time)), 
                         "-Q", lubridate::quarter(lubridate::ymd(time))),
        year = lubridate::year(lubridate::ymd(time))
      ) %>% 
      dplyr::group_by(dplyr::across(dplyr::all_of(group_by))) %>% 
      dplyr::count(transaction, digital_proportion) %>% 
      dplyr::mutate(dss = dss0(n,digital_proportion))
    
    return(x0) 
  }
}


# Usage examples:
# dss(21)
# dss(21, .9)
# dss(c(21,3,1,8), c(.9,.3,.1,.5))
# dss(dss_dataset1, group_by = 'day')
# dss(dss_dataset1, group_by = 'month')
# dss(dss_dataset1, group_by = 'year') 
# dss(dss_dataset1, group_by = c('year', 'quarter'))

