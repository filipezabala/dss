#' Digital Skill Score - DSS
#'
#' @description Calculates the Digital Skill Score for a customer with `x` transactions with digital proportion `p`.
#' @param x: Number of transactions.
#' @param p: Digital proportion.
#' @param group_by: Must group_by 'day', 'month' (Default), 'quarter' or 'year'?
#' @returns Digital Skill Score, `dss = log(x+1)*(1-log(p))`.
#' @examples
#' library(dss)
#' 
#' # If x is a vector, must enter p
#' dss(1)
#' dss(1, 0.9)
#' dss(1, 0.9, round_dec = Inf)
#' dss(c(1,3,21,8), c(.9,.3,.1,.5))
#' 
#' # If x is a data frame
#' dss(dss_dataset1, group_by = 'day')
#' dss(dss_dataset1, group_by = 'month')
#' dss(dss_dataset1, group_by = 'month', keep_tables = TRUE)
#' dss(dss_dataset1, group_by = 'year')
#' dss(dss_dataset1, group_by = c('year', 'quarter'))
#' @export
dss <- function(x, p = NULL, group_by = 'month', 
                keep_tables = FALSE, round_dec = 4){
  
  # Simplest DSS function (vector)
  dss0 <- function(x, p){
    u <- log(x+1)
    r <- -log(p)
    s <- u*(1+r)
  }
  
  # If x is a vector
  if(is.vector(x)){
    if(is.null(p)){
      print('Must enter p!')
    } else{
    s <- dss0(x,p)
    return(round(s,round_dec))
    }
  }
  
  # If x is a data frame
  if(is.data.frame(x)){
    dss_itj <- x %>%
      # Creating time-grouping variables
      dplyr::mutate(
        day = format(lubridate::ymd(time), "%Y-%m-%d"),
        month = format(lubridate::ymd(time), "%Y-%m"),
        quarter = paste0(lubridate::year(lubridate::ymd(time)), 
                         "-Q", lubridate::quarter(lubridate::ymd(time))),
        year = lubridate::year(lubridate::ymd(time))
      ) %>% 
      # Grouping by id and group_by
      dplyr::group_by(dplyr::across(dplyr::all_of(c('id',group_by)))) %>% 
      # Counting transactions
      dplyr::count(transaction, digital_proportion) %>% 
      # Calculating DSS
      dplyr::mutate(dss = round(dss0(n,digital_proportion),round_dec)) 
    
    dss_it <- dss_itj %>% 
      summarise(dss = sum(dss)) 
    
    dss_i <- dss_it %>% 
      summarise(dss = max(dss)) 
    
    if(keep_tables){
      return(list(x=x, dss_itj=dss_itj, dss_it=dss_it, dss_i=dss_i))
    } else{
      return(dss_i) 
    }
  }
}
