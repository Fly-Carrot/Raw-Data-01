# R Workflow

These scripts provide a cleaned public workflow using the analysis-ready data in `Raw data/` and the supplementary workbooks in `Supplementary Data/`.

Run from the repository root:

```r
source("R/01_data_checks_and_joins.R")
source("R/02_spatiotemporal_tests.R")
source("R/03_blmm_soundscape_models.R")
source("R/04_gam_habitat_models.R")
source("R/05_supplementary_sensitivity_summaries.R")
```

By default, computationally expensive model refits are not run. To refit BLMM and GAM models, start R with:

```bash
RUN_MODELS=true Rscript R/03_blmm_soundscape_models.R
RUN_MODELS=true Rscript R/04_gam_habitat_models.R
```

The scripts are ordered to match the manuscript:

1. shared setup and helpers;
2. public data checks and analytical-universe verification;
3. spatiotemporal vocal-trait tests;
4. minute-level BLMM soundscape models;
5. site-period GAM habitat models;
6. confidence-bias and retained-data sensitivity summaries.

The workflow starts from public analysis-ready tables. It does not include private machine paths, raw audio archives, raw LiDAR point clouds or local GIS project files.
