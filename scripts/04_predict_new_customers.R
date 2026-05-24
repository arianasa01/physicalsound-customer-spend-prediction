# Predict spending for the 20 new customers.

model_train = readRDS("outputs/models/customer_spend_model.rds")
new_customers = read.csv("data/raw/new_customer24.csv", header = TRUE)

new_customers$ad_channel1 = ifelse(new_customers$ad_channel == 1, 1, 0)
new_customers$ad_channel2 = ifelse(new_customers$ad_channel == 2, 1, 0)
new_customers$ad_channel3 = ifelse(new_customers$ad_channel == 3, 1, 0)
new_customers$ad_channel4 = ifelse(new_customers$ad_channel == 4, 1, 0)
new_customers$ad_channel = NULL

predictions = predict(model_train, newdata = new_customers)
new_customers$predicted_spend = predictions

prediction_table = data.frame(
  order = new_customers$order,
  predicted_spend = round(new_customers$predicted_spend, 2)
)

write.csv(new_customers, "outputs/tables/predicted_new_customers.csv", row.names = FALSE)
write.csv(prediction_table, "outputs/tables/prediction_table_for_report.csv", row.names = FALSE)

cat("Customer prediction complete.\n")
print(prediction_table)
