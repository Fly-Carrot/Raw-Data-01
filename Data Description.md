# Data Description

Title: Data and analysis workflow for "Passive Acoustic Monitoring Reveals How Urban Vegetation Supports Acoustic Refuges for Avian Communication in a Subtropical Megacity"

Target journal: *Journal of Applied Ecology*

Authors: Blinded for peer review. Author information can be added after acceptance.

## Overview

This repository contains analysis-ready data used to examine how urban soundscape composition and vegetation structure are associated with vocal behaviour of the Common Tailorbird (*Orthotomus sutorius*) in Shenzhen, China.

The public data package is divided into:

- `Raw data/`: processed analysis-ready CSV tables and one illustrative denoised sample audio file;
- `Supplementary Data/`: Excel workbooks corresponding to supplementary data files cited in the manuscript;
- `R/`: cleaned R workflow scripts aligned with the manuscript analysis sequence.

The full raw audio archive, raw sound-event outputs, raw LiDAR point clouds and local GIS workspaces are not included because of data volume, site/privacy constraints and processing dependencies.

## Raw Data Tables

### `Raw data/01_minute_level_vocal_traits.csv`

Minute-level vocal traits of *O. sutorius*. Candidate focal-species records were first identified using classifier-based screening and then manually verified and quality-filtered before vocal traits were measured from validated vocal material. Each row represents one minute of recording.

Variables:

- `site_code`: sampling site identifier.
- `date_full`: recording date.
- `period`: sampling-period block.
- `minute_hm`: recording start time in HHMM format.
- `n_segments`: number of validated vocal segments in the minute.
- `total_n_calls`: number of syllables per minute.
- `mean_interval`: mean inter-syllable interval.
- `mean_peakfreq`: mean peak frequency of syllables.
- `mean_bandw`: mean bandwidth of syllables.
- `mean_centroid`: mean centroid frequency of syllables.
- `min_freq`: minimum frequency across syllables.
- `max_freq`: maximum frequency across syllables.
- `minute_label`: site-date-minute identifier.

### `Raw data/02_minute_level_sound_events.csv`

Minute-level sound-event durations extracted using deep-learning classifiers. Each row represents one minute of recording.

Variables:

- `base_time`: site-date-minute identifier used for joining with vocal-trait records.
- `car_driving`: duration of traffic sound within the minute.
- `frog`: duration of frog sound within the minute.
- `insect`: duration of insect sound within the minute.
- `car_horn`: duration of horn sound within the minute.
- `bird`: duration of bird sound within the minute.
- `human_voice`: duration of speech within the minute.
- `human_knocking`: duration of knocking sound within the minute.
- `rain`: duration of rain within the minute.
- `music`: duration of music within the minute.
- `site`: sampling site identifier.

### `Raw data/03_site_level_vegetation_structure.csv`

Site-level vegetation structural attributes derived from terrestrial LiDAR. Metrics are calculated within a fixed circular plot around each recorder.

Variables include:

- `site_code`: sampling site identifier.
- `LAI_0to2`, `LAI_2to5`, `LAI_5to10`, `LAI_10to15`, `LAI_15to20`, `LAI_over20`: leaf area index by vertical stratum.
- `height_range`: vertical range of vegetation height.
- `height_diversity`: coefficient of variation of tree height.
- `mean_dbh`: mean tree diameter at breast height.
- `DBH0to5`, `DBH5to10`, `DBH10to30`, `DBH30to50`, `DBHover50`: proportional basal-area contributions by DBH class.
- `mean_crown_ratio`: crown diameter divided by tree height.
- `crown_cover`: summed projected crown area divided by plot ground area.
- `crown_vol_density`: summed crown volume normalized by plot ground area.
- `aggregation`: Clark-Evans aggregation index.
- `angle_var`: angular uniformity of tree spatial distribution.
- `local_clustering`: neighbourhood crowding index used in the manuscript as NCI.

### `Raw data/04_site_level_landscape_metrics.csv`

Site-level landscape composition and configuration metrics derived from GIS/MSPA processing within a 1-km buffer.

Variables include:

- `site_code`: sampling site identifier.
- `PLAND_gs`, `PD_gs`, `ED_gs`, `MPS_gs`, `ENN_gs`, `COHESION_gs`, `MESH_gs`: greenspace composition, fragmentation and connectivity metrics.
- `PLAND_core`, `PD_core`, `MPS_core`: MSPA core metrics.
- `PLAND_edge`, `PD_edge`, `MPS_edge`: MSPA edge metrics.
- `PLAND_islet`, `PD_islet`, `MPS_islet`: MSPA islet metrics.
- `PLAND_gallery`, `PD_gallery`, `MPS_gallery`: merged loop/bridge/branch gallery metrics.

### `Raw data/05_site_level_urbanization.csv`

Site-level urbanization intensity and ecological-context metrics within a 1-km buffer.

Variables:

- `site_code`: sampling site identifier.
- `ISR`: impervious surface ratio.
- `NDVI`: normalized difference vegetation index.
- `HQ`: general InVEST habitat-quality index.
- `ALAN`: artificial light at night intensity.

### `Raw data/06_site_level_distance_to_roads.csv`

Site-level proximity to nearest primary and secondary roads.

Variables:

- `site_code`: sampling site identifier.
- `Latitude`, `Longitude`: geographic coordinates.
- `HubName1`, `HubDist1`: nearest primary-road class and distance.
- `HubName2`, `HubDist2`: nearest secondary-road class and distance.

### `Raw data/07_blmm_analysis_dataset.csv`

Site-minute dataset used for Bayesian Linear Mixed Models. This table combines minute-level vocal traits and soundscape predictors.

Key variables:

- vocal traits: `total_n_calls`, `mean_interval`, `mean_peakfreq`, `mean_bandw`, `mean_centroid`, `min_freq`, `max_freq`;
- sound-event durations: `car_driving`, `car_horn`, `human_voice`, `human_knocking`, `music`, `rain`, `frog`, `insect`, `bird`;
- aggregated spectral predictors: `low_freq_strength`, `mid_high_freq_strength`, `low_mid_high_freq_strength`;
- aggregated temporal predictors: `constant_strength`, `pulse_strength`, `structural_strength`;
- temporal covariates: `hour`, `minute`, `time_decimal`;
- grouping covariates: `site_code`, `period`, `date_full`.

### `Raw data/08_gam_analysis_dataset.csv`

Site-period dataset used for Generalized Additive Models. This table combines aggregated vocal traits and habitat predictors.

Key variables:

- vocal traits: `mean_calls`, `mean_interval`, `mean_peakfreq`, `mean_bandw`, `mean_centroid`, `min_freq`, `max_freq`;
- landscape predictors: `PLAND_gs`, `MPS_edge`, `MPS_gallery`;
- site and period fields: `site_code`, `period`;
- urban and habitat predictors: `ISR`, `LAI_understory`, `mean_crown_ratio`, `local_clustering`, `height_range`, `dist1`, `dist2`.

### `Raw data/Common Tailorbird Sample Audio (Denoised).wav`

Illustrative denoised sample audio of the focal species. This file demonstrates vocal characteristics and was not used for quantitative analysis.

## Supplementary Data Workbooks

### `Supplementary Data/Supplementary_Data_S1.xlsx`

Spatiotemporal vocal-trait tests, including PERMANOVA/Kruskal-Wallis outputs and related summaries.

### `Supplementary Data/Supplementary_Data_S2.xlsx`

Candidate-detection and confidence-threshold bias diagnostics. Workbook sheets include a README, detection-universe summaries, confidence-count summaries and soundscape comparisons between below-threshold and retained candidate detections.

### `Supplementary Data/Supplementary_Data_S3.xlsx`

Spatial autocorrelation diagnostics for selected model residuals or site-level variables.

### `Supplementary Data/Supplementary_Data_S4.xlsx`

Retained-data confidence-threshold sensitivity summaries for the BLMM and GAM analyses. Workbook sheets include BLMM fixed effects, BLMM sign stability, BLMM diagnostics, GAM summaries, GAM smooth changes and the GAM site-period input used for sensitivity checks.

## R Scripts

The `R/` folder contains cleaned, ordered scripts for public reproducibility from the analysis-ready tables. They document the model workflow without requiring local raw audio archives, LiDAR point clouds or private machine paths. Long-running model refits require explicit `RUN_MODELS=true`.
