#### Preamble ####
# Purpose: Cleans the raw Toronto healthcare outbreaks dataset obtained in
# "01-download_data.R".
# Author: Benny Rochwerg
# Date: January 23, 2024
# Contact: 4321benny@gmail.com
# Pre-requisites: Run the file "01-download_data.R".

#### Loading Packages ####

library(tidyverse)

#### Cleaning the Dataset ####

outbreak_raw_data <- read_csv("inputs/data/raw_data.csv")

# This code is based on knowledge from Alexander (2023).

outbreak_cleaned_data <-
  outbreak_raw_data |>
  
  # Only including the columns of interest
  select(`_id`, `Outbreak Setting`, `Type of Outbreak`, `Causative Agent-1`) |>
  
  # Renaming the column headers
  rename(`ID` = `_id`,
         `Type of Location` = `Outbreak Setting`,
         `Type of Outbreak` = `Type of Outbreak`,
         `Outbreak First Known Cause` = `Causative Agent-1`) |>
  
  # Renaming the Type of Location entries
  mutate(`Type of Location` = case_match(`Type of Location`,
                                         "LTCH" ~
                                           "Long-Term Care Home",
                                         "Hospital-Acute Care" ~
                                           "Hospital (Acute Care)",
                                         "Retirement Home" ~
                                           "Retirement Home",
                                         "Hospital-Chronic Care" ~
                                           "Hospital (Chronic Care)",
                                         "Hospital-Psychiatric" ~
                                           "Hospital (Psychiatric)",
                                         "Transitional Care" ~
                                           "Transitional Care"))

#### Saving the Cleaned Dataset ####
write_csv(outbreak_cleaned_data, "outputs/data/cleaned_data.csv")