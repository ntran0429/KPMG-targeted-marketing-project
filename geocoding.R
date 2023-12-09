library(httr)  # For making HTTP requests
library(jsonlite)  # For working with JSON data
library(purrr)  # For map function

get_lat_long <- function(postcodes) {
  base_url <- "https://geocode.maps.co/search"
  
  # Initialize an empty list to store results
  results <- list()
  
  for (postcode in postcodes) {
    # Create the API URL
    api_url <- modify_url(base_url, query = list(postalcode = postcode, country = "AU"))
    # print(api_url)
    
    # Make the API request
    response <- GET(api_url)
    # print(response)
    
    # Check if the request was successful (status code 200)
    if (status_code(response) == 200) {
      # Parse the JSON response
      result <- fromJSON(content(response, "text"), flatten = TRUE)
      
      # Append the result to the list
      results[[postcode]] <- result
    } else {
      warning(paste("Failed to fetch data for postcode", postcode))
    }
    
    # Introduce a delay between requests (1 second)
    Sys.sleep(1)
  }
  
  return(results)
}


postcodes <- unique(CD_CA_rfm$postcode)
results <- get_lat_long(postcodes)


# Print the results
# print(results)





# use Google Map API to get the rest
library(ggmap)

google_api_key <- Sys.getenv("google_api_key")
register_google(key = google_api_key)

postcodes <- c("4815", "4869", "3441", "4421", "4750", "3918", 
               "3821", "4806", "4401", "3623", "3279", "4562")

# Function to get lat and lon using ggmap
get_lat_lon_ggmap <- function(postcode, api_key) {
  geo_data <- geocode(paste(postcode, ", Australia", sep = ""))
  return(geo_data)
}

# Get coordinates for each postcode
results_ggmap <- lapply(postcodes, get_lat_lon_ggmap, api_key = api_key)

# Extract lat and lon from results
coordinates_df_ggmap <- data.frame(
  postcode = postcodes,
  lat = sapply(results_ggmap, function(x) x$lat),
  lon = sapply(results_ggmap, function(x) x$lon)
)

# Print the resulting data frame
print(coordinates_df_ggmap)

















