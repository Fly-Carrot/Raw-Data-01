# Site-period GAM habitat models.
#
# The formulas follow the manuscript workflow and use the public
# site-period analysis table. Long model fits are only executed when
# RUN_MODELS=true.

source("R/00_setup.R")

dat <- read_raw_csv("08_gam_analysis_dataset.csv")
dat$period <- factor(dat$period)
dat$site_code <- factor(dat$site_code)

numeric_predictors <- c(
  "height_range", "dist1", "dist2", "LAI_understory", "local_clustering",
  "MPS_edge", "ISR", "mean_crown_ratio", "PLAND_gs"
)

dat <- zscore_columns(dat, numeric_predictors)

gam_formulas <- list(
  mean_calls = mean_calls ~ period +
    s(height_range) + s(dist2) + s(LAI_understory) + s(dist1) + s(MPS_edge),
  mean_peakfreq = mean_peakfreq ~ period +
    s(dist2) + s(dist1) + s(LAI_understory) + s(local_clustering) + s(MPS_edge),
  mean_centroid = mean_centroid ~ period +
    s(local_clustering) + s(dist1) + s(ISR) + s(MPS_edge) + s(mean_crown_ratio),
  mean_bandw = mean_bandw ~ period +
    s(dist1) + s(MPS_edge) + s(height_range) + s(dist2) + s(PLAND_gs)
)

gam_families <- list(
  mean_calls = stats::gaussian(),
  mean_peakfreq = stats::gaussian(),
  mean_centroid = stats::gaussian(),
  mean_bandw = Gamma(link = "log")
)

model_grid <- data.frame(
  response = names(gam_formulas),
  formula = vapply(gam_formulas, function(x) paste(deparse(x), collapse = " "), character(1)),
  family = c("Gaussian", "Gaussian", "Gaussian", "Gamma(log)"),
  stringsAsFactors = FALSE
)

print(model_grid)

if (run_models) {
  require_package("mgcv")

  output_dir <- file.path(repo_root, "outputs", "gam_models")
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  fits <- lapply(names(gam_formulas), function(response) {
    mgcv::gam(
      formula = gam_formulas[[response]],
      data = dat,
      family = gam_families[[response]],
      method = "REML",
      select = TRUE
    )
  })
  names(fits) <- names(gam_formulas)

  summary_table <- do.call(rbind, lapply(names(fits), function(response) {
    sm <- summary(fits[[response]])
    smooth <- as.data.frame(sm$s.table)
    smooth$predictor <- rownames(smooth)
    smooth$response <- response
    smooth
  }))

  print(summary_table)
  saveRDS(fits, file.path(output_dir, "gam_model_fits.rds"))
  write.csv(summary_table, file.path(output_dir, "gam_smooth_summary.csv"), row.names = FALSE)
} else {
  cat("GAM formulas printed only. Set RUN_MODELS=true to refit models.\n")
}
