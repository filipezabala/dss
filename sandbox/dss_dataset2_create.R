# Build dataset
dss_dataset2 <- data.frame(
  id = c(rep(1,8)),
  time = c('2025-01-01', '2025-01-01', # id=1
           '2025-01-05', '2025-01-05', '2025-01-05',
           '2025-02-01', 
           '2025-02-05', '2025-02-05'),
  transaction = c(
    'CHECK BALANCE', 'REQUEST CREDIT CARD', # 2025-01-01
    'CHECK BALANCE', 'PAY BILL', 'REQUEST CHECKBOOK', #2025-01-05
    'CHECK BALANCE', # 2025-02-01
    'CHECK BALANCE', 'PAY BILL'), # 2025-02-05
  digital_proportion = c(.9, .5, 
                         .9, .3, .1,
                         .9,
                         .9, .3)
)
dss_dataset2

# Creates data/dss_dataset2.rda
usethis::use_data(dss_dataset2)


# Generate the .Rd file (from dss_dataset_doc.R)
devtools::document()
