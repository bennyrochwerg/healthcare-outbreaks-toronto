#### Preamble ####
# Purpose: Generates a simulated version of the Toronto healthcare outbreaks
# dataset from this analysis and uses tests to ensure that the simulated data
# is reasonable and realistic.
# Author: Benny Rochwerg
# Date: January 23, 2024
# Contact: 4321benny@gmail.com
# Pre-requisites: Install the janitor (Firke 2023) and tidyverse
# (Wickham et al. 2019) packages.

#### Loading Packages ####

# install.packages("janitor")
# install.packages("tidyverse")
library(janitor)
library(tidyverse)

#### Data Simulation ####

set.seed(100)

# This code was adapted from Alexander (2023).

simulated_outbreak_data <-
  tibble(
    # Simulating 1000 outbreak data points
    "ID" = 1:1000,
    
    # Choosing a type of location 1000 times at random with replacement
    "Type of Location" = sample(
      x = c("Long-Term Care Home", "Retirement Home", "Hospital (Psychiatric)",
            "Other"),
      size = 1000,
      replace = TRUE),
    
    # Choosing a type of outbreak 1000 times at random with replacement
    "Type of Outbreak" = sample(
      x = c("Respiratory", "Enteric", "Other"),
      size = 1000,
      replace = TRUE),
    
    # Choosing the simulated outbreaks' first known causes 1000 times at random
    # with replacement
    "Outbreak First Known Cause" = sample(
      x = c("COVID-19", "Respiratory syncytial virus", "Norovirus", "Other"),
      size = 1000,
      replace = TRUE)
    )

#### Testing the Simulated Dataset ####

# This code was adapted from Alexander (2023).

# Checking the class of some of the columns

simulated_outbreak_data$`Type of Location` |> class() == "character"

simulated_outbreak_data$`Type of Outbreak` |> class() == "character"

simulated_outbreak_data$`Outbreak First Known Cause` |> class() == "character"

# Checking that the minimum value in the ID column is at least 1
simulated_outbreak_data$ID |> min() >= 1

# Checking that the only three outbreak types present are Respiratory, Enteric,
# and Other
simulated_outbreak_data$`Type of Outbreak` |>
  unique() |>
  sort() == sort(c("Respiratory", "Enteric", "Other"))

# Checking that only three outbreak types are present
simulated_outbreak_data$`Type of Outbreak` |>
  unique() |>
  length() == 3

# Checking that the only four location types present are Long-Term Care Home,
# Retirement Home, Hospital (Psychiatric), and Other
simulated_outbreak_data$`Type of Location` |>
  unique() |>
  sort() == sort(c("Long-Term Care Home", "Retirement Home",
                   "Hospital (Psychiatric)", "Other"))

# Checking that only four location types are present
simulated_outbreak_data$`Type of Location` |>
  unique() |>
  length() == 4

# Checking that the only four first known causes present are COVID-19,
# Respiratory syncytial virus, Norovirus, and Other
simulated_outbreak_data$`Outbreak First Known Cause` |>
  unique() |>
  sort() == sort(c("COVID-19", "Respiratory syncytial virus",
                   "Norovirus", "Other"))

# Checking that only four first known causes are present
simulated_outbreak_data$`Outbreak First Known Cause` |>
  unique() |>
  length() == 4