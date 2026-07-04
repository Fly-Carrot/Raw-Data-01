# Minute-level BLMM soundscape models.
#
# This script defines the BLMM structures used to relate short-term vocal
# responses to spectral and temporal sound-event groups. Long model fits are
# only executed when RUN_MODELS=true.

source("R/00_setup.R")

dat <- read_raw_csv("07_blmm_analysis_dataset.csv")
dat$site_code <- factor(dat$site_code)
dat$period <- factor(dat$period)

standardized_vars <- c(spectral_predictors, temporal_predictors, "time_decimal")
dat <- zscore_columns(dat, standardized_vars)

families <- list(
  total_n_calls = "negbinomial",
  mean_interval = "lognormal",
  mean_peakfreq = "gaussian",
  mean_bandw = "lognormal",
  mean_centroid = "gaussian",
  min_freq = "lognormal",
  max_freq = "gaussian"
)

build_formula <- function(response, predictors) {
  as.formula(paste(
    response,
    "~",
    paste(c(predictors, "s(time_decimal)", "(1 | site_code)"), collapse = " + ")
  ))
}

model_grid <- do.call(rbind, lapply(minute_responses, function(response) {
  data.frame(
    response = response,
    model_set = c("spectral", "temporal"),
    formula = c(
      deparse(build_formula(response, spectral_predictors)),
      deparse(build_formula(response, temporal_predictors))
    ),
    family = families[[response]],
    stringsAsFactors = FALSE
  )
}))

print(model_grid)

if (run_models) {
  require_package("brms")

  output_dir <- file.path(repo_root, "outputs", "blmm_models")
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  for (i in seq_len(nrow(model_grid))) {
    response <- model_grid$response[i]
    predictors <- if (model_grid$model_set[i] == "spectral") spectral_predictors else temporal_predictors
    formula_i <- build_formula(response, predictors)
    family_i <- switch(
      model_grid$family[i],
      negbinomial = brms::negbinomial(),
      lognormal = brms::lognormal(),
      gaussian = brms::gaussian()
    )

    fit <- brms::brm(
      formula = formula_i,
      data = dat,
      family = family_i,
      chains = 4,
      iter = 2000,
      warmup = 1000,
      control = list(adapt_delta = 0.99, max_treedepth = 15),
      seed = 2026
    )

    saveRDS(
      fit,
      file.path(output_dir, paste0("blmm_", model_grid$model_set[i], "_", response, ".rds"))
    )
  }
} else {
  cat("BLMM formulas printed only. Set RUN_MODELS=true to refit models.\n")
}
