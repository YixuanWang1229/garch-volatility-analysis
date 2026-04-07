# GARCH Volatility Modelling (DIS Stock)

## Overview
This project analyzes the volatility of Walt Disney (DIS) stock using GARCH-type models in R.

The goal is to capture time-varying risk and compare different volatility models.

## Data
- Source: Yahoo Finance
- Period: Sep 2019 – Aug 2025
- Frequency: Daily returns

## Methodology
1. Compute log returns
2. Perform descriptive statistics (mean, variance, skewness, kurtosis)
3. Estimate three models:
   - sGARCH(1,1)
   - eGARCH(1,1)
   - GJR-GARCH(1,1)
4. Compare models using AIC

## Tools
- R
- quantmod
- rugarch
- moments

## Key Findings
- Volatility is time-varying and clustered
- eGARCH provides better model fit (lower AIC)
- Financial returns exhibit fat tails and non-normality

## How to Run
1. Install required packages:
   ```r
   install.packages(c("quantmod", "rugarch", "moments"))
