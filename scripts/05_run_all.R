# Run the full PhysicalSound customer spend prediction workflow.

source("scripts/01_data_preparation.R")
source("scripts/02_exploratory_analysis.R")
source("scripts/03_model_training.R")
source("scripts/04_predict_new_customers.R")

cat("Full PhysicalSound customer spend prediction project completed.\n")
