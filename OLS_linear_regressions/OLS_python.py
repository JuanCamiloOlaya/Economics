import pandas as pd
import statsmodels.api as sm
from matplotlib import pyplot as plt
from statsmodels.tools.eval_measures import rmse
from statsmodels.stats.diagnostic import het_white
from statsmodels.stats.stattools import jarque_bera
from statsmodels.stats.diagnostic import linear_reset
from statsmodels.stats.diagnostic import het_breuschpagan
from statsmodels.stats.outliers_influence import variance_inflation_factor


"""This code shows how to run a linear regression in Python and some
statistical tests. These tests are widely used to analyze the
performance of the estimated model. 
The analyzed metrics are homoscedasticity, multicollinearity, normality, 
and model specification.

Additionally, the data in this file is from the library "statsmodels": 
the idea is to find the effect of education on income (simple linear
regression).
"""


# Data
duncan_prestige = sm.datasets.get_rdataset("Duncan", "carData")


# Variables
Y = duncan_prestige.data['income']
X = duncan_prestige.data['education']
X = sm.add_constant(X)


# Estimation
model = sm.OLS(Y,X)
results = model.fit()
residuals = results.resid
fitted_values = results.fittedvalues
print(results.summary())


# Homoscedasticity (White and Breush-Pagan tests)
white_test = het_white(residuals,  results.model.exog)
bp_test = het_breuschpagan(residuals, X)

labels_1 = ['LM Statistic', 'LM-Test p-value', 'F-Statistic', 'F-Test p-value']
print(dict(zip(labels_1, bp_test)))
print(dict(zip(labels_1, white_test)))


# Robust model in case of heteroskedasticity
robust_model = sm.RLM(Y,X)
robust_results = robust_model.fit()
print(robust_results.summary())


# Multicollinearity (VIF - variance inflation factor)
vif_data = pd.DataFrame()
vif_data["feature"] = X.columns

vif_data["VIF"] = [variance_inflation_factor(X.values, i) for i in range(len(X.columns))]
vif_data


# Normality
jb_test = jarque_bera(residuals)

labels_2 = ['JB', 'JBpv', 'skew', 'kurtosis']
print(dict(zip(labels_2, jb_test)))


# Model specification
RESET = linear_reset(results)
RESET


# Plots
plt.scatter(fitted_values, Y)
plt.xlabel('Valores ajustados')
plt.ylabel('Valores')
plt.show()

plt.scatter(fitted_values, residuals)
plt.xlabel('Valores ajustados')
plt.ylabel('Residuales')
plt.show()


# Endogeneity
# https://bfdykstra.github.io/2016/11/17/Endogeneity-and-Instrumental-Variable-Regression.html


# Root-mean-square error (RMSE)
rmse(Y, fitted_values)
