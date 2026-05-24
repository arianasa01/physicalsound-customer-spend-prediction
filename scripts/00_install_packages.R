# Install packages required for this project.
# Run this once if your RStudio session does not already have the packages.

packages = c("corrgram", "lmtest")

for (package in packages) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package)
  }
}
