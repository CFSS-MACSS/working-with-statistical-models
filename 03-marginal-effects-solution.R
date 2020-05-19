library(tidyverse)
library(broom)
library(socviz)
library(margins)

# load data
data("county_data")
glimpse(county_data)

# Estimate a logistic regression model predicting the county-level winner
# of the 2016 presidential election (`winner`) as a function of
# percentage of female persons (`female`), percentage of white persons (`white`),
# percentage of black persons (`black`), median household income (`hh_income`)
# in thousands of dollars, and census region  (`census_region`).
# 
# To make the graph easier to interpret, measure median household income
# in thousands of dollars (i.e. divide `hh_income` by 1,000).

## modify hh_income so hh_income is in thousands of dollars
## convert winner to a factor column so glm() works properly
county_data <- county_data %>%
  mutate(hh_income_10 = hh_income / 1e03,
         winner = factor(winner))

# estimate logistic regression model using glm()
vote_logit_mod <- glm(
  winner ~ female + black + white + hh_income_10 + census_region,
  family = "binomial",
  data = county_data
)

# Plot the average marginal effect of each variable using the margins package
# to visualize the logistic regression estimates and confidence intervals.
## estimate marginal effects
vote_logit_marg <- margins(vote_logit_mod)

## extract average marginal effects
vote_logit_marg_tbl <- summary(vote_logit_marg) %>%
  as_tibble() %>%
  mutate(
    # remove prefixes from variable labels using socviz::prefix_strip
    factor = prefix_strip(factor, "census_region"),
    # fix variable labels
    factor = recode(
      factor,
      Black = "Percent black",
      Female = "Percent female",
      Hh_income_10 = "Median household income",
      White = "Percent white"
    )
  )
vote_logit_marg_tbl

## plot using ggplot()
ggplot(data = vote_logit_marg_tbl,
       mapping = aes(x = reorder(factor, AME),
                     y = AME,
                     ymin = lower,
                     ymax = upper)) +
  # add line indicating null (0) effect
  geom_hline(yintercept = 0, color = "gray80") +
  # add point range plot to visualize estimate and confidence interval
  geom_pointrange() +
  coord_flip() +
  labs(x = NULL,
       y = "Average marginal effect")
