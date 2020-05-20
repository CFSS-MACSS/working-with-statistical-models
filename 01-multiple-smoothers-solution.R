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
  data = county_data,
  mapping = aes(x = hh_income, y = per_dem_2016)
) +
  # use alpha to increase transparency of individual points
  geom_point(alpha = .1) +
  # manually specify a linear regression line
  geom_smooth(method = "lm") +
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

## create core ggplot() which contains components used for all plots
p <- ggplot(
  data = county_data,
  mapping = aes(x = hh_income, y = per_dem_2016)
) +
  # use alpha to increase transparency of individual points
  geom_point(alpha = .1) +
  # format labels and axes tick marks
  scale_x_continuous(labels = scales::dollar) +
  scale_y_continuous(labels = scales::percent) +
  labs(
    x = "Median household income",
    y = "2016 Democratic presidential vote"
  )

## plot using linear regression model
p_lm <- p +
  geom_smooth(method = "lm") +
  # remove y-axis label to avoid overlap
  labs(y = NULL)

## plot using polynomial for income
p_lm_2 <- p +
  geom_smooth(method = "lm", formula = y ~ poly(x, degree = 2))

## plot using gam
p_gam <- p +
  geom_smooth(method = "gam") +
  # remove y-axis label to avoid overlap
  labs(y = NULL)

## combine together
p_lm +
  p_lm_2 +
  p_gam +
  # align the graphs vertically
  plot_layout(ncol = 1) +
  # add an overall title and subtitle to the combined plot
  plot_annotation(
    title = "2016 U.S. presidential election",
    subtitle = "By county"
  )

# Generate a single graph using ggplot2 to visualize the relationship
# between median household income (`hh_income`) and percent of votes cast for
# the Democratic presidential candidate in 2016 (`per_dem_2016`).
# Draw three separate smoothing lines using the following methods:
## 1. A standard linear regression model
## 2. A linear regression model with a second-order polynomial for income
## 3. A generalized additive model (`method = "gam"`)
# The graph should be a single ggplot() object with properly labeled elements.

## reuse core ggplot object, adding three separate geom_smooth() functions
p +
  geom_smooth(
    method = "lm",
    mapping = aes(color = "OLS", fill = "OLS")
  ) +
  geom_smooth(
    method = "lm",
    formula = y ~ poly(x, degree = 2),
    mapping = aes(color = "Polynomial", fill = "Polynomial")
  ) +
  geom_smooth(
    method = "gam",
    mapping = aes(color = "GAM", fill = "GAM")
  ) +
  # use an appropriate color palette
  scale_color_brewer(
    # qualitative variable
    type = "qual",
    # use the same palette for the fill aesthetic too
    aesthetics = c("color", "fill")
  ) +
  # add meaningful labels
  labs(
    title = "2016 U.S. presidential election",
    subtitle = "By county",
    color = "Models",
    fill = "Models"
  ) +
  # move the legend to the bottom
  theme(legend.position = "bottom")
