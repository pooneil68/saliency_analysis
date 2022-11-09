% runit.m
clearvars;

%% Data preparation
% Load subject data
generate_subject_label12; % Generates dummy subject data
subject_label12; % matfile (DataAll) and demographic data
make_idxM12; % Age-matched resampling (seed fixed)

% Load image data from /images
generate_images; % Generates dummy images
create_saliency_data0901mod; % Generates saliency_data0901.mat

% Calculate saliency map with GBVS_saliency
create_saliency_data0922b; % Generates out_itti0922.mat;

% Load saccade data and calculate saliency values for saccades
generate_FixationSummaryAll; % Generates dummy saccades
make_saliency_value_DataAll0922; % Generates saliency_value_DataAll0922.mat;

%% plot across saccades for all images (Fig.2, Fig.S1)
% preparation of data
make_plot_data1028b; % generates plotdata1028b.mat
plotdata1028a16b; % generates saliencydata1028_16b.mat

% plots
plotdata1028b16Fig; % plot across saccades (for Fig.2)
plotdata1028bFS2; % plot for 1st saccade (for Fig.S1)

% Generates csv files for Rstudio
tidy4R0126b; % Generates plotdata_tidy_20220126b_am

% execute Rstudio
% glm20220126allb.Rmd % All subject
% glm20220126amb.Rmd % age-matched

%% plots and statistics for time-averaged data (Fig.3 and Fig.5)
make_timeavrdata0922; % generates timeavrdata0922.mat
plot_data0922age_matched2; % for Fig.3A and Fig.5BC

% effect size for each image
make_imageavrdata0923; % generates imageavrdata0923.mat
plot_cliff; % for Fig.3B

%% plots across saccades for each image (Fig.1C)
make_plot_data0929img;
plot_saliency_value0929img; % for Fig.1C
plot_data0930image2; % for Fig.1C

%% General liner model for cognitive scores (Fig.6 and Table S1)
generate_emsdata; % Generates dummy cognitive scores
load_emsdata; % for Table S1
glm_cognitive_score; % for Fig.6

%% Fixation map (Fig.7)
create_fixM0924b_am; % for Fig.7A
lmfit_map1008mod_am; % for Fig.7B,C
lmfit_map1223b_am; % for Fig.7B,D

%% Intermediate maps for salience computation (Fig.4)
% data pareparation (takes around 2min)
create_saliency_data1008; % Generates out_itti1008.mat
modify_saliency_data1009; % Generates out_itti1009b.mat
make_saliency_value_DataAll01009; % Generates saliency_value_DataAll1009.mat

% Plots
make_timeavrdata1009; % Generates timeavrdata1009mean.mat
plot_data1009am; % age-matched

%%
disp('done!')
return
