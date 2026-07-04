# Data and analysis workflow for: Passive Acoustic Monitoring Reveals How Urban Vegetation Supports Acoustic Refuges for Avian Communication in a Subtropical Megacity

This repository provides the public, analysis-ready data tables, supplementary data workbooks and R workflow scripts associated with a manuscript submitted to *Journal of Applied Ecology*.

The study combines passive acoustic monitoring, classifier-based soundscape decomposition, manually verified focal-species vocal-trait extraction, terrestrial LiDAR vegetation metrics, landscape metrics, Bayesian Linear Mixed Models (BLMMs), and Generalized Additive Models (GAMs) to examine vocal responses of the Common Tailorbird (*Orthotomus sutorius*) in urban greenspaces in Shenzhen, China.

## Repository Scope

This repository contains processed, analysis-ready data rather than the full raw recording archive, raw classifier outputs, or LiDAR point clouds. Raw audio recordings and LiDAR point clouds are not included because of data volume and site/privacy constraints. A denoised sample audio file is provided only to illustrate the vocal characteristics of the focal species and was not used for quantitative analysis.

Two analytical universes are represented:

- The full PAM/environmental network contains 21 sites where site-level vegetation, landscape, urbanization and soundscape summaries are available where applicable.
- The focal vocal-trait analyses use a 20-site subset because one site yielded no effective focal-species vocal material after species-level screening, manual verification and quality filtering.

## Repository Layout

```text
Raw data/
  01_minute_level_vocal_traits.csv
  02_minute_level_sound_events.csv
  03_site_level_vegetation_structure.csv
  04_site_level_landscape_metrics.csv
  05_site_level_urbanization.csv
  06_site_level_distance_to_roads.csv
  07_blmm_analysis_dataset.csv
  08_gam_analysis_dataset.csv
  Common Tailorbird Sample Audio (Denoised).wav

Supplementary Data/
  Supplementary_Data_S1.xlsx
  Supplementary_Data_S2.xlsx
  Supplementary_Data_S3.xlsx
  Supplementary_Data_S4.xlsx

R/
  00_setup.R
  01_data_checks_and_joins.R
  02_spatiotemporal_tests.R
  03_blmm_soundscape_models.R
  04_gam_habitat_models.R
  05_supplementary_sensitivity_summaries.R

Data Description.md
analysis_workflow_pseudocode.md
```

## Raw Data Tables

| File | Description |
| --- | --- |
| `Raw data/01_minute_level_vocal_traits.csv` | Minute-level vocal traits of *O. sutorius* after candidate screening, manual verification, quality filtering and vocal-trait measurement. |
| `Raw data/02_minute_level_sound_events.csv` | Minute-level sound-event durations from the sound-event classifier. |
| `Raw data/03_site_level_vegetation_structure.csv` | Terrestrial LiDAR vegetation-structure metrics calculated at the site level. |
| `Raw data/04_site_level_landscape_metrics.csv` | Landscape composition and configuration metrics derived from GIS/MSPA processing. |
| `Raw data/05_site_level_urbanization.csv` | Site-level urbanization and ecological-context variables. |
| `Raw data/06_site_level_distance_to_roads.csv` | Distances from recording sites to primary and secondary roads. |
| `Raw data/07_blmm_analysis_dataset.csv` | Site-minute BLMM input dataset combining vocal traits and soundscape predictors. |
| `Raw data/08_gam_analysis_dataset.csv` | Site-period GAM input dataset combining aggregated vocal traits and habitat predictors. |
| `Raw data/Common Tailorbird Sample Audio (Denoised).wav` | Illustrative denoised sample audio of the focal species; not used for quantitative analysis. |

## Supplementary Data Workbooks

| File | Description |
| --- | --- |
| `Supplementary Data/Supplementary_Data_S1.xlsx` | Spatiotemporal vocal-trait tests, including PERMANOVA/Kruskal-Wallis and related summaries. |
| `Supplementary Data/Supplementary_Data_S2.xlsx` | Candidate-detection and confidence-threshold bias diagnostics. |
| `Supplementary Data/Supplementary_Data_S3.xlsx` | Spatial autocorrelation diagnostics. |
| `Supplementary Data/Supplementary_Data_S4.xlsx` | Retained-data confidence-threshold sensitivity summaries for BLMM and GAM analyses. |

## R Workflow

The `R/` folder provides a cleaned, manuscript-aligned workflow using the public analysis-ready tables in this repository. Scripts are ordered to match the manuscript logic:

1. setup and shared helper functions;
2. data checks and analytical-universe verification;
3. spatiotemporal vocal-trait tests;
4. minute-level BLMM model definitions;
5. site-period GAM model definitions;
6. supplementary sensitivity-table summaries.

Long-running model fits are guarded by `RUN_MODELS=true`. By default, the scripts build inputs, check data structure and print model formulas without refitting computationally expensive models.

## Data-Use Notes

- `period` denotes sampling-period blocks used for analysis; it should not be interpreted as independently verified breeding-stage status.
- Vocal-trait data are based on candidate focal-species records that entered the validated vocal-trait workflow. They are not an unverified classifier-only endpoint.
- Soundscape predictors are based on classifier-derived event durations aggregated into spectral and temporal functional groups.
- The BLMM analysis uses seven minute-level vocal responses and separates spectral and temporal soundscape predictor sets.
- The GAM analysis uses four site-period vocal responses and habitat predictors selected through the manuscript workflow.

## Citation

Please cite the associated manuscript and this repository when using these data. A formal DOI or release citation can be added after journal-linked archival deposit.
