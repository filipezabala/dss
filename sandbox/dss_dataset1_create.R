# Build expanded dataset with 5 IDs and consistent digital proportions
dss_dataset1 <- data.frame(
  id = c(rep(1,10), rep(2,10), rep(3,10), rep(4,10), rep(5,10)),
  time = c(
    # ID 1: "The Digital Explorer" - High digital usage, explores features over time
    '2025-01-01', '2025-01-01',
    '2025-02-05', '2025-02-05', '2025-02-05',
    '2025-03-10', 
    '2025-04-15', 
    '2025-06-20', '2025-06-20',
    '2025-08-25',
    # ID 2: "The Traditional Bill-Payer" - Consistent bill payments, low digital usage
    '2025-01-04', '2025-02-04', '2025-03-04', '2025-04-04', '2025-05-04',
    '2025-06-04', '2025-07-04', '2025-08-04', '2025-09-04', '2025-10-04',
    # ID 3: "The Balance Checker" - Frequent balance checks, high digital usage
    '2025-01-07', '2025-01-14', '2025-02-07', '2025-02-21', '2025-03-07',
    '2025-04-07', '2025-05-07', '2025-07-07', '2025-09-07', '2025-11-07',
    # ID 4: "The Seasonal User" - Mixed activity throughout the year
    '2025-01-10', '2025-01-10', '2025-01-10',
    '2025-03-15', '2025-03-15',
    '2025-06-20', '2025-06-20', '2025-06-20',
    '2025-09-25',
    '2025-12-30',
    # ID 5: "The Digital Novice" - Gradual adoption of digital features
    '2025-01-02', '2025-02-01', '2025-03-03', '2025-04-02', '2025-05-02',
    '2025-06-02', '2025-07-02', '2025-08-02', '2025-09-02', '2025-10-02'
  ),
  transaction = c(
    # ID 1: Explores different features over time
    'CHECK BALANCE', 'REQUEST CREDIT CARD',
    'CHECK BALANCE', 'PAY BILL', 'REQUEST CHECKBOOK',
    'CHECK BALANCE',
    'PAY BILL',
    'CHECK BALANCE', 'REQUEST CREDIT CARD',
    'CHECK BALANCE',
    # ID 2: Consistent bill payments
    'PAY BILL', 'PAY BILL', 'PAY BILL', 'PAY BILL', 'PAY BILL',
    'PAY BILL', 'PAY BILL', 'PAY BILL', 'PAY BILL', 'PAY BILL',
    # ID 3: Primarily balance checks
    'CHECK BALANCE', 'CHECK BALANCE', 'CHECK BALANCE', 'CHECK BALANCE', 'CHECK BALANCE',
    'CHECK BALANCE', 'CHECK BALANCE', 'CHECK BALANCE', 'CHECK BALANCE', 'CHECK BALANCE',
    # ID 4: Mixed transactions throughout the year
    'CHECK BALANCE', 'PAY BILL', 'REQUEST CREDIT CARD',
    'CHECK BALANCE', 'REQUEST CHECKBOOK',
    'CHECK BALANCE', 'PAY BILL', 'REQUEST CREDIT CARD',
    'REQUEST CHECKBOOK',
    'CHECK BALANCE',
    # ID 5: Gradual adoption of different features
    'CHECK BALANCE',
    'CHECK BALANCE',
    'PAY BILL',
    'PAY BILL',
    'CHECK BALANCE',
    'REQUEST CREDIT CARD',
    'PAY BILL',
    'CHECK BALANCE',
    'REQUEST CHECKBOOK',
    'REQUEST CREDIT CARD'
  )
)

# Add digital_proportion based on transaction type
dss_dataset1 <- dss_dataset1 %>%
  mutate(
    digital_proportion = case_when(
      transaction == 'CHECK BALANCE' ~ 0.9,
      transaction == 'REQUEST CREDIT CARD' ~ 0.5,
      transaction == 'REQUEST CHECKBOOK' ~ 0.1,
      transaction == 'PAY BILL' ~ 0.3,
      TRUE ~ 0.5  # default for any unexpected transaction types
    )
  )

dss_dataset1

# Creates data/dss_dataset1.rda
usethis::use_data(dss_dataset1, overwrite = TRUE)


# Generate the .Rd file (from dss_dataset_doc.R)
devtools::document()
devtools::load_all()
