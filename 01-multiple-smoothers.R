library(tidyverse)
library(socviz)
library(patchwork)

# load data
data("county_data")
glimpse(county_data)

# Generate a graph using ggplot2 to visualize the relationship between
# median household income (`hh_income`) and percent of votes cast for
# the Democratic presidential candidate in 2016 (`per_dem_2016`).
# Overlay a linear regression best fit line on top of a scatterplot.
ggplot(
  data = ________,
  mapping = aes(x = ________, y = ________)
) +
  # use alpha to increase transparency of individual points
  ________(alpha = .1) +
  # manually specify a linear regression line
  geom_smooth(________) +
  # format labels and axes tick marks
  scale_x_continuous(labels = scales::dollar) +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "2016 U.S. presidential election",
    subtitle = "By county",
    x = "Median household income",
    y = "2016 Democratic presidential vote"
  )

# Generate three separate graphs using ggplot2 to visualize the relationship
# between median household income (`hh_income`) and percent of votes cast for
# the Democratic presidential candidate in 2016 (`per_dem_2016`).
# Each graph should use a different statistical algorithm:
## 1. A standard linear regression model
## 2. A linear regression model with a second-order polynomial for income
## 3. A generalized additive model (`method = "gam"`)
# Combine them together into a single plotting object using patchwork.



# Generate a single graph using ggplot2 to visualize the relationship
# between median household income (`hh_income`) and percent of votes cast for
# the Democratic presidential candidate in 2016 (`per_dem_2016`).
# Draw three separate smoothing lines using the following methods:
## 1. A standard linear regression model
## 2. A linear regression model with a second-order polynomial for income
## 3. A generalized additive model (`method = "gam"`)
# The graph should be a single ggplot() object with properly labeled elements.


