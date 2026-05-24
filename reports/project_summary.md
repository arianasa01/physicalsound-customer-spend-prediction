# Project Summary: PhysicalSound Customer Spend Prediction

PhysicalSound is a fictional e-commerce company that sells physical music media. The business wanted to understand what customer features were related to higher spending and whether future customer spending could be predicted.

The project used July 2024 order data with 2,000 sampled records. Missing predictor values were handled through simple imputation, while rows with missing target spending were removed. The advertisement channel variable was converted into dummy variables so that it could be used in a regression model.

The exploratory analysis showed that age, time spent on the website and previous spending had clearer relationships with spending than voucher use or advertisement channel. A multiple linear regression model was then trained and evaluated using a train/test split.

The original coursework analysis found that the model explained a large share of the variation in spending and produced an RMSE of around £3.47 on the test set. The model was then used to predict spending for 20 new customers.

The project demonstrates data cleaning, exploratory analysis, regression modelling, model evaluation and practical business interpretation in R.
