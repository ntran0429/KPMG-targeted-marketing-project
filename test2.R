# make a descending order table of the top 10 most frequent job titles in NewCustomerList
t1 <- NewCustomerList  |> 
  group_by(job_title) |>
  summarise(count = n()) |>
  arrange(desc(count)) |>
  head(10)

t2 <- NCL_before_impute2  |> 
  group_by(job_title) |>
  summarise(count = n()) |>
  arrange(desc(count)) |>
  head(10)

# return all the job titles that are in both tables
intersect(t1$job_title, t2$job_title)


# return the opposite of intersect
setdiff(t1$job_title, t2$job_title)




# in CD_before_impute2, get the customers/rows that have missing values in job_title
CD_before_impute2[is.na(CD_before_impute2$job_title),]
# get the index of the customers/rows that have missing values in job_title
which(is.na(CD_before_impute2$job_title))


# in CustomerDemographic, get the customers/rows that have missing values in job_title
CustomerDemographic[is.na(CustomerDemographic$job_title),]
# get the index of the customers/rows that have missing values in job_title
which(is.na(CustomerDemographic$job_title))




# randomly sample 10 job_title values from CustomerDemographic
set.seed(1)
sample(CustomerDemographic$job_title, 10)