# Data from: Passive Acoustic Monitoring Reveals How Urban Vegetation Creates Acoustic Refuges for Avian Communication in a Subtropical Megacity

This repository provides analysis-ready data tables and workflow pseudocode for the manuscript submitted to *Journal of Applied Ecology*.

The study combines passive acoustic monitoring, classifier-based soundscape decomposition, manually verified focal-species vocal-trait extraction, terrestrial LiDAR vegetation metrics, landscape metrics, Bayesian Linear Mixed Models (BLMMs), and Generalized Additive Models (GAMs) to examine vocal responses of the Common Tailorbird (*Orthotomus sutorius*) in urban greenspaces in Shenzhen, China.

## Repository Scope

The repository contains processed, analysis-ready data rather than the full raw recording archive or LiDAR point clouds. Raw audio recordings and LiDAR point clouds are not included because of data volume and site/privacy constraints. A denoised sample audio file is provided only to illustrate the vocal characteristics of the focal species and was not used for quantitative analysis.

Two analytical universes are represented:

- The full PAM/environmental network contains 21 sites where site-level vegetation, landscape, urbanization, and soundscape summaries are available where applicable.
- The focal vocal-trait analyses use a 20-site subset because one site yielded no effective focal-species vocal material after species-level screening, manual verification, and quality filtering.

## Files

| File | Description |
| --- | --- |
| `01_minute_level_vocal_traits.csv` | Minute-level vocal traits of *O. sutorius* after candidate screening, manual verification, quality filtering, and vocal-trait measurement. |
| `02_minute_level_sound_events.csv` | Minute-level sound-event durations from the sound-event classifier. |
| `03_site_level_vegetation_structure.csv` | Terrestrial LiDAR vegetation-structure metrics calculated at the site level. |
| `04_site_level_landscape_metrics.csv` | Landscape composition and configuration metrics derived from GIS/MSPA processing. |
| `05_site_level_urbanization.csv` | Site-level urbanization and ecological-context variables. |
| `06_site_level_distance_to_roads.csv` | Distances from recording sites to primary and secondary roads. |
| `07_blmm_analysis_dataset.csv` | Site-minute BLMM input dataset combining vocal traits and soundscape predictors. |
| `08_gam_analysis_dataset.csv` | Site-period GAM input dataset combining aggregated vocal traits and habitat predictors. |
| `Common Tailorbird Sample Audio (Denoised).wav` | Illustrative denoised sample audio of the focal species; not used for quantitative analysis. |
| `Data Description.md` | Variable-level data dictionary for the repository files. |
| `analysis_workflow_pseudocode.md` | Non-executable pseudocode describing the analysis workflow and model structure. |

## Data-Use Notes

- `period` denotes sampling-period blocks used for analysis; it should not be interpreted as independently verified breeding-stage status.
- Vocal-trait data are based on candidate focal-species records that entered the validated vocal-trait workflow. They are not an unverified classifier-only endpoint.
- Soundscape predictors are based on classifier-derived event durations aggregated into spectral and temporal functional groups.
- The BLMM analysis uses seven minute-level vocal responses and separates spectral and temporal soundscape predictor sets.
- The GAM analysis uses four site-period vocal responses and habitat predictors selected through the manuscript workflow.

## Citation

Please cite the associated manuscript and this repository when using these data. A formal DOI or release citation can be added after journal-linked archival deposit.
