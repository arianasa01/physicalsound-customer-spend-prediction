# Data preparation for the PhysicalSound customer spend prediction project.

create_directories = function() {
  dirs = c("data/processed", "outputs/tables", "outputs/figures", "outputs/models")
  for (dir in dirs) {
    if (!dir.exists(dir)) {
      dir.create(dir, recursive = TRUE)
    }
  }
}

get_mode = function(x) {
  values = x[!is.na(x)]
  as.numeric(names(sort(table(values), decreasing = TRUE)[1]))
}

prepare_order_data = function(raw_path = "data/raw/order_july24.csv") {
  data = read.csv(raw_path, header = TRUE)

  missing_values = data.frame(
    Variable = names(data),
    Missing_Values = colSums(is.na(data))
  )
  write.csv(missing_values, "outputs/tables/missing_values.csv", row.names = FALSE)

  data$past_spend[is.na(data$past_spend)] = median(data$past_spend, na.rm = TRUE)
  data$age[is.na(data$age)] = mean(data$age, na.rm = TRUE)
  data$ad_channel[is.na(data$ad_channel)] = get_mode(data$ad_channel)
  data$voucher[is.na(data$voucher)] = get_mode(data$voucher)
  data$time_web[is.na(data$time_web)] = median(data$time_web, na.rm = TRUE)

  data = data[!is.na(data$spend), ]

  data$ad_channel1 = ifelse(data$ad_channel == 1, 1, 0)
  data$ad_channel2 = ifelse(data$ad_channel == 2, 1, 0)
  data$ad_channel3 = ifelse(data$ad_channel == 3, 1, 0)
  data$ad_channel4 = ifelse(data$ad_channel == 4, 1, 0)
  data$ad_channel = NULL

  write.csv(data, "data/processed/cleaned_orders.csv", row.names = FALSE)

  return(data)
}

create_directories()
data = prepare_order_data()

cat("Data preparation complete.\n")
cat("Cleaned rows:", nrow(data), "\n")
cat("Cleaned columns:", ncol(data), "\n")
