#### Preamble ####
# Purpose: Cleans the raw Toronto healthcare outbreaks dataset obtained in
# "01-download_data.R".
# Author: Benny Rochwerg
# Date: January 23, 2024
# Contact: 4321benny@gmail.com
# Pre-requisites: Run the file "01-download_data.R".

#### Loading Packages ####

# install.packages("tidyverse")
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
  
  # Renaming the Type of Location entries for clarity
  mutate(`Type of Location` =
           case_match(`Type of Location`,
                      "LTCH" ~ "Long-Term Care Home",
                      "Hospital-Acute Care" ~ "Hospital (Acute Care)",
                      "Retirement Home" ~ "Retirement Home",
                      "Hospital-Chronic Care" ~ "Hospital (Chronic Care)",
                      "Hospital-Psychiatric" ~ "Hospital (Psychiatric)",
                      "Transitional Care" ~ "Transitional Care")) |>
  
  # Renaming some of the Outbreak First Known Cause entries for simplicity
  mutate(`Outbreak First Known Cause` =
           case_match(`Outbreak First Known Cause`,
                      "COVID-19" ~ "COVID-19",
                      "Parainfluenza" ~ "Parainfluenza",
                      "Respiratory syncytial virus" ~
                        "Respiratory syncytial virus",
                      "Metapneumovirus" ~ "Metapneumovirus",
                      "Norovirus" ~ "Norovirus",
                      "Rhinovirus" ~ "Rhinovirus",
                      "Group B Streptococcal disease (neonatal)" ~
                        "Group B Streptococcal disease (neonatal)",
                      "Enterovirus/Rhinovirus" ~ "Enterovirus/Rhinovirus",
                      "Enterovirus" ~ "Enterovirus",
                      "Streptococcus pyogenes" ~ "Streptococcus pyogenes",
                      "Parainfluenza PIV III" ~ "Parainfluenza",
                      "Coronavirus*" ~ "Seasonal coronavirus",
                      "Influenza A (Not subtyped)" ~ "Influenza A",
                      "Influenza A (H3)" ~ "Influenza A",
                      "Influenza A (H1N1)" ~ "Influenza A",
                      "CPE Enterobacter unspecified (NDM)" ~ "CPE",
                      "CPE Unspecified (KPC)" ~ "CPE",
                      "Pending" ~ "Pending/Unknown",
                      "Unable to identify" ~ "Pending/Unknown"))

#### Saving the Cleaned Dataset ####

write_csv(outbreak_cleaned_data, "outputs/data/cleaned_data.csv")