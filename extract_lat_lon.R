library(dplyr)

extract_lat_lon <- function(results) {
  # Initialize an empty data frame to store the extracted data
  coordinates_df <- data.frame(postcode = character(), 
                               lat = numeric(), lon = numeric(), 
                               stringsAsFactors = FALSE)
  
  # Iterate over the list of results
  for (postcode in names(results)) {
    # Extract latitude and longitude from each result
    lat <- as.numeric(results[[postcode]]$lat)
    lon <- as.numeric(results[[postcode]]$lon)
    
    # Check if valid coordinates were obtained
    if (!any(is.na(lat)) && !any(is.na(lon))) {
      # Append the data to the data frame
      coordinates_df <- bind_rows(coordinates_df, 
                                  tibble(postcode = postcode, 
                                         lat = lat, lon = lon))
    } else {
      warning(paste("Invalid coordinates for postcode", postcode))
    }
  }
  
  return(coordinates_df)
}

coordinates_df <- extract_lat_lon(results)
# append coordinates_df to coordinates_df_ggmap
coordinates_df_final <- bind_rows(coordinates_df, coordinates_df_ggmap)


# Print the resulting data frame
print(head(coordinates_df_final))
write.csv(coordinates_df_final, "./coordinates_df_final.csv", row.names = FALSE)



coordinates_df_NCL_final <- extract_lat_lon(results_NCL)
write.csv(coordinates_df_NCL_final, "./coordinates_df_NCL_final.csv", row.names = FALSE)


# get the postcodes in CD_CA_rfm that are not in coordinates_df
# ie. missing lat/lon for these postcodes
setdiff(unique(CD_CA_rfm$postcode), unique(coordinates_df$postcode))

    
    
    
  