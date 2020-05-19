library(tidyverse)
library(broom)
library(socviz)

# load data
data("county_data")
glimpse(county_data)

# Estimate a linear regression model predicting 2016 Democratic presidential
# vote share as a function of percentage of female persons (`female`),
# percentage of white persons (`white`), percentage of black persons (`black`),
# and median household income (`hh_income`) in thousands of dollars.
# 
# To make the graph easier to interpret, measure median household income in
# thousands of dollars (i.e. divide `hh_income` by 1,000) and
# multiply `per_dem_2016` by 100 (so it scales between 0-100).

## modify hh_income so hh_income is in thousands of dollars
## and per_dem_2016 is scaled between 0 and 100
county_data <- county_data %>%
  mutate(hh_income_10 = hh_income / 1e03,
         per_dem_2016 = per_dem_2016 * 100)

## estimate ols model using lm()
vote_mod <- lm(________,
               data = county_data)

## extract coefficients using tidy() and include confidence intervals
vote_mod_coef <- tidy(vote_mod, ________)
vote_mod_coef

## generate the coefficient plot



# Use the coefplot package to automatically generate the coefficient plot
library(coefplot)


