# Check public analysis-ready data tables and analytical universes.

source("R/00_setup.R")

vocal_minute <- read_raw_csv("01_minute_level_vocal_traits.csv")
sound_events <- read_raw_csv("02_minute_level_sound_events.csv")
vegetation <- read_raw_csv("03_site_level_vegetation_structure.csv")
landscape <- read_raw_csv("04_site_level_landscape_metrics.csv")
urbanization <- read_raw_csv("05_site_level_urbanization.csv")
roads <- read_raw_csv("06_site_level_distance_to_roads.csv")
blmm_data <- read_raw_csv("07_blmm_analysis_dataset.csv")
gam_data <- read_raw_csv("08_gam_analysis_dataset.csv")

table_inventory <- data.frame(
  table = c(
    "minute vocal traits", "minute sound events", "vegetation structure",
    "landscape metrics", "urbanization", "roads", "BLMM input", "GAM input"
  ),
  rows = c(
    nrow(vocal_minute), nrow(sound_events), nrow(vegetation), nrow(landscape),
    nrow(urbanization), nrow(roads), nrow(blmm_data), nrow(gam_data)
  ),
  columns = c(
    ncol(vocal_minute), ncol(sound_events), ncol(vegetation), ncol(landscape),
    ncol(urbanization), ncol(roads), ncol(blmm_data), ncol(gam_data)
  )
)

print(table_inventory)

cat("\nAnalytical universes:\n")
cat("- minute-level vocal observations:", nrow(vocal_minute), "\n")
cat("- focal sites in minute-level data:", length(unique(vocal_minute$site_code)), "\n")
cat("- site-period GAM observations:", nrow(gam_data), "\n")
cat("- focal sites in GAM data:", length(unique(gam_data$site_code)), "\n")
cat("- periods in GAM data:", paste(sort(unique(gam_data$period)), collapse = ", "), "\n")
cat("- sites in full vegetation table:", length(unique(vegetation$site_code)), "\n")

required_blmm <- c(minute_responses, spectral_predictors, temporal_predictors, "site_code", "time_decimal")
required_gam <- c(gam_responses, "period", "LAI_understory", "mean_crown_ratio",
                  "local_clustering", "MPS_edge", "PLAND_gs", "dist1", "dist2")

missing_blmm <- setdiff(required_blmm, names(blmm_data))
missing_gam <- setdiff(required_gam, names(gam_data))

if (length(missing_blmm)) stop("Missing BLMM variables: ", paste(missing_blmm, collapse = ", "))
if (length(missing_gam)) stop("Missing GAM variables: ", paste(missing_gam, collapse = ", "))

cat("\nAll required public BLMM and GAM variables are present.\n")
