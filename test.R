# remove NA's in Transactions, excluding NA's in the online_order column

# complete.cases function returns a logical vector 
# indicating which observations/rows have no missing values
Transactions <- Transactions[complete.cases(Transactions),]


# filter for rows in Transactions where product_first_sold_date is NA
Transactions[is.na(Transactions$product_first_sold_date),]


# create a plot for this question: Are there seasonal trends in transaction dates?
ggplot(Transactions, aes(x = transaction_date)) + 
  geom_histogram(bins = 30) + 
  labs(x = "Transaction Date", y = "Count", title = "Histogram of Transaction Dates") +
  theme(plot.title = element_text(hjust = 0.5))


