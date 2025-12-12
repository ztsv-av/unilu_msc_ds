# BIC

BIC favours smaller models. Favours lag $0$ = series are random walk. Use AIC if a lot of data.

# Granger Causality Test

Tests whether one variable is useful in predicting another. In simple terms, tests whether the coefficients of another variable are not $0$ when predicting a variable. $H_0$: $m_2$ does not granger-cause $m_1$.

# After making stationary

if AUC, PAC show drop from 0 to 1, 1 maybe above, then VAR(1) or VAR(2) might be good.

# Algorithm

1. Check for stationarity.
2. Select model. Check significance levels in `summary()` to select the appropriate number of parameters.
2. Check errors, if there are patterns and also test values if there is correlation.
4. Check different models.

in_sample, i.e. calculate errors
for t_end: 2015 - 2024:
    arima(y[1:t_end])
    forecast(t_end + 1)

1. Correlation is not important when forecasting $n$ variables. Partial corrleation is important. How $m_1$ comoves with $m_2$ knowing $m_1_{t-1}$. For example: $\text{LUXX}_t=c + a_{11}\text{LUXX}_{t-1}+a_{12}\text{DAX}_{t-1}+e_t$. So, if necessary information is already contained in $\text{LUXX}_{t-1}$, then $\text{DAX}_{t-1}$ is redundant for predicting $\text{LUXX}_t$.
2. Very persistent AC function, PAC cuts off at lag 1 $\iff$ non-stationary.


# Multivariate

1. Check stationarity through tests (adhf, kpss)
2. Make them stationary OR check if they co-integrate: if co-integrate, no need to make stationary.

# Why lag 1 point?

1. t is predicted by t-1. To improve:
    - use t in supporting variables if possible.
    - use separate model to predict current value of supporting variable, use this to predict current value of main variable:
    - $\text{RGDP}_t = c + \theta_{11}\text{RGDP}_{t-1}+\theta_{12}\text{IP}_{t}+\epsilon_t$