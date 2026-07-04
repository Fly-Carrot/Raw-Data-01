# Inspect supplementary confidence-bias and sensitivity-analysis workbooks.

source("R/00_setup.R")

require_package("readxl")

supp_files <- list(
  S1 = "Supplementary_Data_S1.xlsx",
  S2 = "Supplementary_Data_S2.xlsx",
  S3 = "Supplementary_Data_S3.xlsx",
  S4 = "Supplementary_Data_S4.xlsx"
)

supp_paths <- file.path(supplementary_data_dir, unlist(supp_files))
if (any(!file.exists(supp_paths))) {
  stop("Missing supplementary workbook(s): ", paste(supp_paths[!file.exists(supp_paths)], collapse = ", "))
}

sheet_inventory <- do.call(rbind, lapply(names(supp_files), function(id) {
  path <- file.path(supplementary_data_dir, supp_files[[id]])
  data.frame(
    supplementary_data = id,
    workbook = supp_files[[id]],
    sheet = readxl::excel_sheets(path),
    stringsAsFactors = FALSE
  )
}))

print(sheet_inventory)

# Reviewer-response diagnostics: below-threshold candidate characterization.
s2_main_soundscape <- readxl::read_excel(
  file.path(supplementary_data_dir, supp_files$S2),
  sheet = "S2c_main_soundscape"
)

cat("\nSupplementary Data S2 main soundscape comparison preview:\n")
print(utils::head(s2_main_soundscape, 10))

# Retained-data sensitivity: BLMM sign stability and GAM summaries.
s4_blmm_stability <- readxl::read_excel(
  file.path(supplementary_data_dir, supp_files$S4),
  sheet = "BLMM_sign_stability"
)

s4_gam_summary <- readxl::read_excel(
  file.path(supplementary_data_dir, supp_files$S4),
  sheet = "GAM_summary_05_to_08"
)

cat("\nBLMM sign-stability summary:\n")
print(utils::head(s4_blmm_stability, 20))

cat("\nGAM sensitivity summary:\n")
print(utils::head(s4_gam_summary, 20))
