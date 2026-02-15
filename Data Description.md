Title:
Data from: Passive Acoustic Monitoring Network Reveals Vegetation Buffering Thresholds in Urban Avian Soundscapes of a Subtropical Megacity

Authors:
Chen Yuhao, Hao Zezhou, Zhang Chengyun, Chen Zihao, Li Le, Zhou Ting, Liu Yang

Target journal:
Journal of Applied Ecology

Description:
This repository contains the data and code used to analyse how urban soundscape composition and vegetation structure jointly influence vocal behaviour of Orthotomus sutorius in Shenzhen, China.

File descriptions:
/data/01_minute_level_vocal_traits.csv
Minute-level vocal traits of Orthotomus sutorius extracted using deep-learning classifiers.
Each row represents one minute of recording.

Variables:
site_code – sampling site identifier
date_full – recording date (YYYY-MM-DD)
period – breeding stages
total_n_calls – number of syllables per minute
mean_interval – mean inter-syllable interval
mean_peakfreq – mean peak frequency of syllables
mean_bandw – mean bandwidth of syllables
mean_centroid – mean centroid frequency of syllables
min_freq – minimum frequency across all syllables
max_freq – maximum frequency across all syllables
minute_label – a label containing site code, full recording date and time

/data/02_minute_level_sound_events.csv
Minute-level sound events time extracted using deep-learning classifiers.
Each row represents one minute of recording.

Variables:
base_time – a label containing site code, full recording date and time, same format as minute_label above
car_driving – total duration of traffic in one minute
frog – total duration of frog sound in one minute
insect – total duration of insect sound in one minute
car_horn – total duration of horn sound in one minute
human_voice – total duration of speech in one minute
human_knocking – total duration of knocking in one minute
rain – total duration of rain in one minute
music – total duration of music in one minute
site – sampling site identifier

/data/03_site_level_vegetation_structure.csv
Site-level vegetation structural attributes derived from terrestrial LiDAR. All metrics are calculated within a fixed 23 m radius circular plot.

Variables:
site_code – sampling site identifier
LAI_0to2 – leaf area index contributed by vegetation with tree height ≤ 2m
LAI_2to5 – leaf area index contributed by vegetation with tree height > 2 m and ≤ 5 m
LAI_5to10 – leaf area index contributed by vegetation with tree height > 5 m and ≤ 10 m
LAI_10to15 – leaf area index contributed by vegetation with tree height > 10 m and ≤ 15 m
LAI_15to20 – leaf area index contributed by vegetation with tree height > 15 m and ≤ 20 m
LAI_over20 – leaf area index contributed by vegetation with tree height > 20 m
height_range – vertical range of vegetation height, calculated as the difference between maximum and minimum tree height (m)
height_diversity – coefficient of variation of tree height (standard deviation divided by mean), representing vertical structural heterogeneity
mean_dbh – mean DBH of all trees within the site (m)
DBH0to5 – proportion of total basal area contributed by trees with DBH between 0 and 5 cm
DBH5to10 – proportion of total basal area contributed by trees with DBH between 5 and 10 cm
DBH10to30 – proportion of total basal area contributed by trees with DBH between 10 and 30 cm
DBH30to50 – proportion of total basal area contributed by trees with DBH between 30 and 50 cm
DBHover50 – proportion of total basal area contributed by trees with DBH greater than 50 cm
mean_crown_ratio – mean crown ratio, calculated as crown diameter divided by total tree height, reflecting crown development and lateral expansion
crown_cover – canopy cover, calculated as the summed projected crown area divided by plot ground area
crown_vol_density – canopy volume density, calculated as the summed crown volume normalized by plot ground area
aggregation – Clark–Evans aggregation index, calculated as the ratio of observed mean nearest-neighbor distance to the expected distance under complete spatial randomness; values < 1 indicate clustering, values > 1 indicate regularity
angle_var – angular uniformity of tree spatial distribution, calculated from the circular variance of tree azimuths relative to the plot center; higher values indicate more even angular distribution
local_clustering – Neighbourhood Crowding Index (NCI) described in the manuscript, calculated as the coefficient of variation of mean distances to the five nearest neighbors, describing fine-scale spatial heterogeneity in tree spacing

/data/04_site_level_landscape_metrics.csv
Site-level landscape configuration and anthropogenic pressure metrics derived from GIS (Guidos Toolbox & MSPA) within a 1-km buffer.

Variables:
PLAND_gs – proportion of landscape occupied by greenspace
PD_gs – patch density of greenspace, representing fragmentation intensity
ED_gs – edge density of greenspace, representing the amount of habitat edge relative to landscape area
MPS_gs – mean patch size of greenspace
ENN_gs – mean Euclidean nearest-neighbour distance among greenspace patches, describing patch isolation
COHESION_gs – patch cohesion index, reflecting connectedness of greenspace
MESH_gs – effective mesh size, representing landscape connectivity and probability that two randomly chosen points fall within the same connected habitat patch
PLAND_core – proportion of landscape classified as core greenspace
PD_core – patch density of core areas
MPS_core – mean patch size of core areas
PLAND_edge – proportion of landscape classified as edge habitat
PD_edge – patch density of edge areas
MPS_edge – mean patch size of edge areas
PLAND_islet – proportion of landscape classified as islet patches
PD_islet – patch density of islet patches
MPS_islet – mean patch size of islet patches
PLNAD_gallery – proportion of landscape classified as gallery elements
PD_gallery – patch density of gallery elements
MPS_gallery – mean patch size of gallery elements

/data/05_site_level_urbanization.csv
Site-level urbanization intensity and ecological condition metrics within a 1-km buffer.

Variables:
ISR – Impervious Surface Ratio, representing the proportion of impervious surfaces (e.g., roads, buildings, paved areas) within the 1 km buffer. Higher values indicate stronger urban development intensity and lower landscape permeability
NDVI – Normailized Difference Vegetation Index, derived from Landsat OLI-8 imagery. NDVI reflects vegetation productivity and canopy greenness. Higher values indicate denser or more photosynthetically active vegetation.
HQ – Habitat Quality index derived from the InVEST Habitat Quality model. This metric integrates land-cover type and anthropogenic threat layers to estimate relative habitat suitability and ecological integrity. Higher values indicate higher habitat quality and lower human disturbance pressure.
ALAN – Artificial Light at Night intensity, derived from Luojia-1 nighttime light imagery. Values represent mean nighttime radiance within the 1 km buffer. Higher values indicate stronger nocturnal anthropogenic disturbance.

/data/06_site_level_distance_to_roads.csv
Site-level proximity to nearest road infrastructure, quantifying potential traffic-related disturbance and noise exposure.

Variables:
site_code – sampling site identifier
Latitude – geographic latitude of the recording site (WGS84)
Longitude – geographic longitude of the recording site (WGS84)
HubName1 – road classification of the nearest primary road
HubDist1 – Euclidean distance from the site to the nearest primary road
HubName2 – road classification of the nearest secondary road
HubDist2 – Euclidean distance from the site to the nearest secondary road
 
/data/07_blmm_analysis_dataset.csv
Site-minute level dataset used for Bayesian Linear Mixed Models. This dataset contains minute-resolution acoustic and soundscape metrics used to quantify immediate vocal responses to real-time soundscape composition. Each row represents a 1-minute recording segment from a given site and date.

Variables:
site_code – sampling site identifier
date_full – full sampling date
period – sampling period classification
minute_hm – recording start time (HHMM format)
minute_label – unique identifier for each minute segment
base_time – full timestamp identifier (site + date + time)
hour – hour of day
minute – minute of hour
time_decimal – decimal time representation (used for smooth diel modeling)
n_segments – number of detected vocal segments
total_n_calls – total number of syllables within the minute
mean_interval – mean interval between consecutive syllables (s)
mean_peakfreq – mean peak frequency (Hz)
mean_bandw – mean bandwidth (Hz)
mean_centroid – mean spectral centroid frequency (Hz)
min_freq – minimum frequency (Hz)
max_freq – maximum frequency (Hz)
car_driving – duration of vehicle driving noise
car_horn – duration of horn events
human_voice – duration of human speech
human_knocking – duration of knocking noise
music – duration of music
rain – duration of rainfall
frog – duration of frog vocalization
insect – duration of insect sound
bird – duration of bird vocal activity
low_freq_strength – relative intensity of low-to-mid frequency events
mid_high_freq_strength – relative intensity of mid-to-high frequency events
low_mid_high_freq_strength – relative intensity of broadband events
constant_strength – relative intensity of constant events
pulse_strength – relative intensity of pulsed events
structural_strength – relative intensity of structured events

/data/08_gam_analysis_dataset.csv
Site-period dataset used for Generalized Additive Models. This dataset contains site-period level vocal metrics aggregated by breeding period and associated habitat structure variables. Each row represents a site × breeding stage combination.

Variables:
mean_calls – mean number of syllables per minute
mean_interval – mean interval between consecutive syllables (s)
mean_peakfreq – mean peak frequency (Hz)
mean_bandw – mean bandwidth (Hz)
mean_centroid – mean spectral centroid frequency (Hz)
min_freq – minimum frequency (Hz)
max_freq – maximum frequency (Hz)
PLAND_gs – proportion of landscape occupied by greenspace
MPS_edge – mean patch size of edge areas
MPS_gallery – mean patch size of gallery elements
dist1 – Euclidean distance from the site to the nearest primary road
dist2 – Euclidean distance from the site to the nearest secondary road
ISR – Impervious Surface Ratio
LAI_understory – leaf area index contributed by vegetation with tree height ≤ 5m
mean_crown_ratio – mean crown ratio mentioned above

/data/Common Tailorbird Sample Audio (Denoised).wav

A sample audio of the focal species (Common Tailorbird).

This file contains a representative field recording of the focal species used in this study. The audio was post-processed using Adobe Audition to reduce background noise for clarity.

Notes:
Raw audio recordings and LiDAR point clouds are not included due to data volume and privacy constraints.
