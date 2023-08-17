
# This script simulates the data for the exercise described in the article
# "Teaching Marketing Analytics:
# A Pricing Exercise for Quantitative and Substantive Marketing Skills"
# Authors: (anonymized for peer review)


# Load required libraries
library(tidyverse)

# Define the number of sales territories
n <- 100

# Set a seed to ensure reproducibility
set.seed(3)
df <-
  tibble(
    
  # simulate the independent variables
    price = round(rnorm(n, mean = 300, sd = 40), 2),
    experience = rpois(n, 4),
    engineer = sample(c("Yes", "No"), n, replace = TRUE, prob = c(0.2, 0.8)),
    gender = 1L,
    location = rpois(n, 8) + 3,
    budget_agency = round(rnorm(n, mean = 1000, sd = 300)),
    budget_phone = round(budget_agency * rnorm(n, 0.5, 0.01)),
    budget_social_media = budget_agency - budget_phone
  ) %>%
  
  # Compute the dependent variable `quantity`
  # by defining the true relationship between quantity and independent variables
  mutate(
    quantity = 
      round(
        # true relationship
        1200 - 3 * price + 10 * experience + 3 * location +
          0.015 * budget_phone + 0.015 * budget_social_media +
        # add normally distributed error term
          rnorm(n, mean = 0, sd = 10)
      ),
    .before = 1
  )

# Save the simulated data set in .csv and .xlsx formats
write_csv(df, "data_sales.csv")
writexl::write_xlsx(df, "data_sales.xlsx")
