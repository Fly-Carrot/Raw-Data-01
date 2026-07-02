# Analysis Workflow Pseudocode

This document provides non-executable pseudocode for the analysis workflow used to produce the repository data tables and manuscript results. It is intended to document the logic of the workflow without exposing local paths, raw audio archives, or LiDAR point-cloud files.

## 1. Define Analytical Scope

```text
Define full PAM network:
    sites_full = 21 recording sites

Define focal vocal-trait subset:
    sites_focal = sites with validated Common Tailorbird vocal material
    exclude sites with zero effective focal-species vocal material after:
        species-level screening
        manual verification
        quality filtering

Result:
    minute-level focal dataset = 2,776 observations from 20 sites
    site-period focal dataset = 59 site-period observations from the same 20-site subset
```

## 2. Build Minute-Level Vocal-Trait Dataset

```text
Input:
    syllable-level validated focal-species vocal measurements

For each validated vocal segment:
    retain site_code
    retain date_full
    retain sampling-period block
    retain recording time
    retain syllable-level vocal traits

For each site_code x date_full x minute:
    n_segments = number of validated vocal segments in the minute
    total_n_calls = sum of syllables in the minute
    mean_interval = weighted mean inter-syllable interval, weighted by syllable count
    mean_peakfreq = weighted mean peak frequency, weighted by syllable count
    mean_bandw = weighted mean bandwidth, weighted by syllable count
    mean_centroid = weighted mean centroid frequency, weighted by syllable count
    min_freq = minimum syllable frequency in the minute
    max_freq = maximum syllable frequency in the minute
    minute_label = site_code + date + minute

Output:
    01_minute_level_vocal_traits.csv
```

## 3. Test Spatiotemporal Vocal-Trait Structure

```text
Input:
    01_minute_level_vocal_traits.csv

Response matrix:
    total_n_calls
    mean_interval
    mean_peakfreq
    mean_bandw
    mean_centroid
    min_freq
    max_freq

Check normality and variance assumptions for individual traits.

Because assumptions are not consistently satisfied:
    use PERMANOVA on the multivariate vocal-trait matrix
    model = vocal_traits ~ site_code * period
    distance = Euclidean
    permutations = 999

For individual vocal traits:
    use non-parametric univariate tests to compare site and period effects
```

## 4. Aggregate Vocal Traits to Site-Period Scale

```text
Input:
    01_minute_level_vocal_traits.csv

For each site_code x period:
    n_minutes = number of focal minutes
    total_calls = sum(total_n_calls)
    mean_calls = mean(total_n_calls)
    mean_interval = mean(mean_interval)
    mean_peakfreq = mean(mean_peakfreq)
    mean_bandw = mean(mean_bandw)
    mean_centroid = mean(mean_centroid)
    min_freq = minimum(min_freq)
    max_freq = maximum(max_freq)

Output:
    vocal site-period table used in 08_gam_analysis_dataset.csv
```

## 5. Build Site-Level Habitat and Urban-Context Predictors

```text
Input:
    terrestrial LiDAR vegetation metrics
    landscape metrics derived from GIS/MSPA
    remote-sensing urban-context variables
    road-distance variables

Vegetation structure:
    calculate LAI strata
    LAI_understory = LAI_0to2 + LAI_2to5
    calculate height_range, mean_crown_ratio, local_clustering and related structure metrics

Landscape configuration:
    derive greenspace composition and MSPA metrics
    retain predictors such as PLAND_gs, MPS_edge and MPS_gallery for model screening

Urban context and roads:
    retain ISR and distances to primary and secondary roads

Screen candidate predictors:
    inspect pairwise correlations
    use VIF diagnostics
    use ecological interpretability and response-specific Random Forest importance
    retain response-specific predictor sets for GAMs

Outputs:
    03_site_level_vegetation_structure.csv
    04_site_level_landscape_metrics.csv
    05_site_level_urbanization.csv
    06_site_level_distance_to_roads.csv
```

## 6. Build Soundscape Predictor Dataset

```text
Input:
    classifier-derived sound-event durations for each minute

Sound-event classes:
    traffic
    frog
    insect
    horn
    bird
    speech
    knocking
    rain
    music

For each minute:
    aggregate event durations by base_time
    remove exact duplicate minute-event rows

Define spectral groups:
    low_to_mid_frequency = traffic + speech + music
    mid_to_high_frequency = bird + insect
    broadband = frog + knocking + horn + rain

Define temporal groups:
    constant = traffic + insect + rain
    pulsed = frog + horn + knocking
    structured = bird + music + speech

For each minute:
    low_freq_strength = sum(low_to_mid_frequency durations) / (60 seconds x number of events in group)
    mid_high_freq_strength = sum(mid_to_high_frequency durations) / (60 seconds x number of events in group)
    low_mid_high_freq_strength = sum(broadband durations) / (60 seconds x number of events in group)
    constant_strength = sum(constant durations) / (60 seconds x number of events in group)
    pulse_strength = sum(pulsed durations) / (60 seconds x number of events in group)
    structural_strength = sum(structured durations) / (60 seconds x number of events in group)

Output:
    02_minute_level_sound_events.csv
```

## 7. Build BLMM Input Dataset

```text
Input:
    01_minute_level_vocal_traits.csv
    02_minute_level_sound_events.csv

For each focal minute:
    join vocal traits to sound-event summaries by minute identifier
    calculate hour, minute and decimal time of day
    standardize continuous soundscape predictors and time_decimal before modelling

Output:
    07_blmm_analysis_dataset.csv
```

## 8. Fit Minute-Level BLMMs

```text
Input:
    07_blmm_analysis_dataset.csv

Responses:
    total_n_calls
    mean_interval
    mean_peakfreq
    mean_bandw
    mean_centroid
    min_freq
    max_freq

Model set A: spectral soundscape predictors
    response ~ low_freq_strength
             + mid_high_freq_strength
             + low_mid_high_freq_strength
             + smooth(time_decimal)
             + random_intercept(site_code)

Model set B: temporal soundscape predictors
    response ~ constant_strength
             + pulse_strength
             + structural_strength
             + smooth(time_decimal)
             + random_intercept(site_code)

Families:
    total_n_calls: negative binomial
    mean_interval: lognormal
    mean_peakfreq: Gaussian
    mean_bandw: lognormal
    mean_centroid: Gaussian
    min_freq: lognormal
    max_freq: Gaussian

Model settings:
    chains = 4
    iterations = 2,000
    warmup = 1,000
    adapt_delta = 0.99
    max_treedepth = 15

Summarize:
    fixed-effect estimates
    credible intervals
    Bayesian R2
    convergence diagnostics
```

## 9. Build GAM Input Dataset

```text
Input:
    site-period vocal summaries
    site-level landscape, vegetation, urban-context and road-distance predictors

For each site_code x period:
    combine aggregated vocal responses with habitat predictors

Output:
    08_gam_analysis_dataset.csv
```

## 10. Fit Site-Period GAMs

```text
Input:
    08_gam_analysis_dataset.csv

Standardize continuous habitat predictors before modelling.
Keep period as a factor.

Model mean_calls:
    mean_calls ~ period
               + s(height_range)
               + s(dist2)
               + s(LAI_understory)
               + s(dist1)
               + s(MPS_edge)
    family = Gaussian

Model mean_peakfreq:
    mean_peakfreq ~ period
                  + s(dist2)
                  + s(dist1)
                  + s(LAI_understory)
                  + s(local_clustering)
                  + s(MPS_edge)
    family = Gaussian

Model mean_centroid:
    mean_centroid ~ period
                  + s(local_clustering)
                  + s(dist1)
                  + s(ISR)
                  + s(MPS_edge)
                  + s(mean_crown_ratio)
    family = Gaussian

Model mean_bandw:
    mean_bandw ~ period
               + s(dist1)
               + s(MPS_edge)
               + s(height_range)
               + s(dist2)
               + s(PLAND_gs)
    family = Gamma with log link

Model settings:
    method = REML
    select = TRUE

Summarize:
    parametric period terms
    smooth-term edf
    smooth-term test statistics
    p-values
    adjusted R2
    deviance explained
```

## 11. Estimate and Visualize Smooth Response Patterns

```text
For each fitted GAM smooth term:
    generate prediction grid across the observed range of the predictor
    hold other numeric predictors at representative central values
    hold period at a reference level for visualization
    predict smooth response and uncertainty
    back-transform standardized predictor values to original units
    plot fitted response curves with observed data

Use fitted curves to identify candidate transition values or turning points where the modeled response changes most strongly along habitat gradients.
```

## 12. Retained-Data Confidence Sensitivity

```text
Primary validated vocal-trait workflow:
    candidate records enter trait extraction at classifier confidence >= 0.5
    retained records are manually verified and quality-filtered before trait extraction

Sensitivity workflow:
    repeat retained-data analyses at stricter thresholds:
        >= 0.6
        >= 0.7
        >= 0.8

For each stricter threshold:
    rebuild minute-level vocal-trait table from retained validated material
    refit the same BLMM structures
    aggregate to site-period scale
    refit the same GAM structures

Compare:
    BLMM effect directions
    credible intervals
    model diagnostics
    GAM smooth-term summaries
    broad shape of habitat-response relationships

Interpretation:
    sensitivity analyses evaluate whether conclusions are stable within the validated retained-data universe
    detections below the entry threshold are not treated as equivalent vocal-trait observations because they did not enter the validated trait-extraction workflow
```

## 13. Public Data Outputs

```text
Public repository outputs:
    01_minute_level_vocal_traits.csv
    02_minute_level_sound_events.csv
    03_site_level_vegetation_structure.csv
    04_site_level_landscape_metrics.csv
    05_site_level_urbanization.csv
    06_site_level_distance_to_roads.csv
    07_blmm_analysis_dataset.csv
    08_gam_analysis_dataset.csv
    Data Description.md
    README.md
    analysis_workflow_pseudocode.md

Excluded from public repository:
    full raw audio archive
    LiDAR point clouds
    local machine paths
    non-anonymized working files
```
