#### Preamble ####
# Purpose: Runs tests on the cleaned dataset to check the validity
# of the entries.
# Author: Benny Rochwerg
# Date: January 23, 2024
# Contact: 4321benny@gmail.com
# Pre-requisites: Run the files "01-download_data.R" and "02-data_cleaning.R".

#### Loading Packages ####

# install.packages("tidyverse")
library(tidyverse)

#### Testing the Cleaned Dataset ####

# This code was adapted from Alexander (2023).
# Note that only the tests from "00-simulate_data.R" that are applicable to this
# cleaned dataset will be performed.

# Loading the cleaned dataset
outbreak_cleaned_data <- read_csv("outputs/data/cleaned_data.csv")

# Running the tests on the cleaned dataset

# Checking the class of some of the columns

outbreak_cleaned_data$`Type of Location` |> class() == "character"

outbreak_cleaned_data$`Type of Outbreak` |> class() == "character"

outbreak_cleaned_data$`Outbreak First Known Cause` |> class() == "character"

# Checking that the minimum value in the ID column is at least 1
outbreak_cleaned_data$ID |> min() >= 1

# Checking that the only three outbreak types present are Respiratory, Enteric,
# and Other
outbreak_cleaned_data$`Type of Outbreak` |>
  unique() |>
  sort() == sort(c("Respiratory", "Enteric", "Other"))

# Checking that only three outbreak types are present
outbreak_cleaned_data$`Type of Outbreak` |>
  unique() |>
  length() == 3