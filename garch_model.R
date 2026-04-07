# ================================
# GARCH Volatility Modelling - DIS
# ================================

# Clean environment
rm(list = ls())
cat("\014")

# Load packages
library(quantmod)
library(rugarch)
library(moments)

# Download data
getSymbols("DIS", src = "yahoo", from = "2019-09-01", to = "2025-08-31")

# Compute returns
prices <- DIS$DIS.Adjusted
returns <- diff(log(prices)) * 100
returns <- na.omit(returns)

# Descriptive statistics
desc_stats <- data.frame(
  Mean = mean(returns),
  Variance = var(returns),
  SD = sd(returns),
  Skewness = skewness(returns),
  Kurtosis = kurtosis(returns)
)
print(desc_stats)

# Split data
T1 <- length(returns["2019-09-01/2022-08-31"])
T2 <- length(returns["2022-09-01/2025-08-31"])

# Model specifications
spec_sGARCH <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1)),
  mean.model = list(armaOrder = c(0,0)),
  distribution.model = "std"
)

spec_eGARCH <- ugarchspec(
  variance.model = list(model = "eGARCH", garchOrder = c(1,1)),
  mean.model = list(armaOrder = c(0,0)),
  distribution.model = "std"
)

spec_gjr <- ugarchspec(
  variance.model = list(model = "gjrGARCH", garchOrder = c(1,1)),
  mean.model = list(armaOrder = c(0,0)),
  distribution.model = "std"
)

# Fit models
fit_sGARCH <- ugarchfit(spec_sGARCH, data = returns, out.sample = T2)
fit_eGARCH <- ugarchfit(spec_eGARCH, data = returns, out.sample = T2)
fit_gjr <- ugarchfit(spec_gjr, data = returns, out.sample = T2)

# Compare models
comparison <- data.frame(
  Model = c("sGARCH", "eGARCH", "GJR-GARCH"),
  AIC = c(infocriteria(fit_sGARCH)[1],
          infocriteria(fit_eGARCH)[1],
          infocriteria(fit_gjr)[1])
)

print(comparison)