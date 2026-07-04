# Spatiotemporal vocal-trait tests.

source("R/00_setup.R")

dat <- read_raw_csv("01_minute_level_vocal_traits.csv")

response_matrix <- dat[, minute_responses, drop = FALSE]
response_matrix <- response_matrix[complete.cases(response_matrix), , drop = FALSE]
test_dat <- dat[as.integer(rownames(response_matrix)), , drop = FALSE]

cat("Rows used for multivariate tests:", nrow(response_matrix), "\n")

if (run_models) {
  require_package("vegan")

  permanova <- vegan::adonis2(
    response_matrix ~ site_code * period,
    data = test_dat,
    method = "euclidean",
    permutations = 999
  )
  print(permanova)
} else {
  cat("PERMANOVA formula, not run unless RUN_MODELS=true:\n")
  cat("vocal_traits ~ site_code * period, method = euclidean, permutations = 999\n")
}

kw_summary <- lapply(minute_responses, function(response) {
  site_test <- kruskal.test(test_dat[[response]] ~ test_dat$site_code)
  period_test <- kruskal.test(test_dat[[response]] ~ test_dat$period)
  data.frame(
    trait = response,
    site_statistic = unname(site_test$statistic),
    site_p_value = site_test$p.value,
    period_statistic = unname(period_test$statistic),
    period_p_value = period_test$p.value
  )
})

kw_summary <- do.call(rbind, kw_summary)
print(kw_summary)
