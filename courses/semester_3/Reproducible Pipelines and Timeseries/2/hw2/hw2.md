1. train on train data
2. forecast next value
3. train on train data + 1
4. repeat until test set is finished.

```
Y = df_diff[['luxx','cac']]
n = Y.shape[0] 
for i in range(0,n_fcs):                          # loop for 1-step-ahead forecasts on the last 10% of the data
    var_i   = sm.tsa.VAR(Y[0:(n-(n_fcs-i))])      # declare var model object
    mdl_i   = var_i.fit(2)                        # fit var model
    fcs_i   = mdl_i.forecast(y=var_i.y, steps=1); # one-step-ahead forecast
    fcs[i,:] = fcs_i                              # store the forecast
```

1. choose lag by running VAR.select_order. but also can inspect AC, PAC. points outside - lag