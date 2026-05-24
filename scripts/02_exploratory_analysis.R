# Exploratory analysis and diagnostic plots.

if (!requireNamespace("corrgram", quietly = TRUE)) {
  stop("Package 'corrgram' is required. Run scripts/00_install_packages.R first.")
}

library(corrgram)

data = read.csv("data/processed/cleaned_orders.csv")

png("outputs/figures/correlation_matrix.png", width = 1000, height = 650)
corrgram(data, lower.panel = panel.shade, upper.panel = panel.cor)
dev.off()

png("outputs/figures/spend_histogram.png", width = 900, height = 600)
hist(data$spend, main = "Histogram of customer spending", xlab = "Spend (£)", col = "grey80", border = "white")
dev.off()

png("outputs/figures/past_spend_histogram.png", width = 900, height = 600)
hist(data$past_spend, main = "Histogram of past spending", xlab = "Past spend (£)", col = "grey80", border = "white")
dev.off()

png("outputs/figures/spend_vs_past_spend.png", width = 900, height = 600)
plot(data$past_spend, data$spend, xlab = "Past spend (£)", ylab = "Spend (£)", main = "Spend vs past spend")
dev.off()

png("outputs/figures/spend_vs_time_web.png", width = 900, height = 600)
plot(data$time_web, data$spend, xlab = "Time on website (seconds)", ylab = "Spend (£)", main = "Spend vs time on website")
dev.off()

png("outputs/figures/spend_vs_age.png", width = 900, height = 600)
plot(data$age, data$spend, xlab = "Age", ylab = "Spend (£)", main = "Spend vs age")
dev.off()

cat("Exploratory analysis complete.\n")
