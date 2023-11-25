# remove NA's in Transactions, excluding NA's in the online_order column

# complete.cases function returns a logical vector 
# indicating which observations/rows have no missing values
Transactions <- Transactions[complete.cases(Transactions),]


# filter for rows in Transactions where product_first_sold_date is NA
Transactions[is.na(Transactions$product_first_sold_date),]
