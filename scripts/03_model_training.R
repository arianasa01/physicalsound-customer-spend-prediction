# Multiple linear regression model training and evaluation.

if (!requireNamespace("lmtest", quietly = TRUE)) {
  stop("Package 'lmtest' is required. Run scripts/00_install_packages.R first.")
}

library(lmtest)

data = read.csv("data/processed/cleaned_orders.csv")

full_model = lm(spend ~ ., data = data)

png("outputs/figures/residuals_vs_fitted.png", width = 900, height = 600)
plot(fitted(full_model), resid(full_model), xlab = "Fitted values", ylab = "Residuals", main = "Residuals vs fitted values")
abline(h = 0, col = "red")
dev.off()

set.seed(123)
sample_rows = sample(1:nrow(data), size = 0.7 * nrow(data))
train = data[sample_rows, ]
test = data[-sample_rows, ]

model_train = lm(spend ~ ., data = train)
predictions = predict(model_train, newdata = test)

mse = mean((test$spend - predictions)^2)
rmse = sqrt(mse)
r_squared = summary(full_model)$r.squared
adjusted_r_squared = summary(full_model)$adj.r.squared
dw_result = dwtest(full_model)

metrics = data.frame(
  Metric = c("RMSE", "R_squared", "Adjusted_R_squared", "Durbin_Watson", "Durbin_Watson_p_value"),
  Value = c(rmse, r_squared, adjusted_r_squared, as.numeric(dw_result$statistic), dw_result$p.value)
)
write.csv(metrics, "outputs/tables/model_metrics.csv", row.names = FALSE)

coefficients_table = as.data.frame(summary(full_model)$coefficients)
coefficients_table$Variable = rownames(coefficients_table)
rownames(coefficients_table) = NULL
coefficients_table = coefficients_table[, c("Variable", "Estimate", "Std. Error", "t value", "Pr(>|t|)")]
write.csv(coefficients_table, "outputs/tables/model_coefficients.csv", row.names = FALSE)

saveRDS(model_train, "outputs/models/customer_spend_model.rds")

cat("Model training complete.\n")
cat("RMSE:", round(rmse, 3), "\n")
cat("R-squared:", round(r_squared, 4), "\n")
cat("Adjusted R-squared:", round(adjusted_r_squared, 4), "\n")
cat("Durbin-Watson:", round(as.numeric(dw_result$statistic), 4), "\n")
