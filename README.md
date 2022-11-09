# Saliency analysis
Codes used for analysis conducted in the study: Yoshida et al (2022) "Aberrant visual salience in participants with schizophrenia during free-viewing of natural images", biorXiv. All of the essential figures and statistics in this study were created by runnning these codes.

Because of ethical prohibitions, all data reported in this study cannot be deposited in a public repository. The images used in this study were selected from the International Affective Pictures System (IAPS) (Lang et al., 2008), and the face images from Matsumoto and Ekman (Matsumoto and Ekman, 1988). Since these images are not allowed to be publicly available, the images are not included. For these reasons, dummy data are generated within the codes to show how to run the codes. Instead, you can use these codes to analyze your data.

For further information, contact the lead contact of the study, Masatoshi Yoshida, Ph.D., myoshi@chain.hokudai.ac.jp.

These codes are released under the terms of the MIT license.

# Versions of softwares

* Matlab R2022a
* GBVS toolbox for MATLAB (Harel et al., 2007; http://www.klab.caltech.edu/~harel/share/gbvs.php)
* fdr_bh.m (David Groppe (2022). fdr_bh (https://www.mathworks.com/matlabcentral/fileexchange/27418-fdr_bh), MATLAB Central File Exchange.)
* computeCohen_d.m (Ruggero G. Bettinardi (2022). computeCohen_d(x1, x2, varargin) (https://www.mathworks.com/matlabcentral/fileexchange/62957-computecohen_d-x1-x2-varargin), MATLAB Central File Exchange.)
* R ver 4.2.1
* RStudio 2022.07.1
* R package lme4 (Bates et al., 2015)
* R package LmerTest (Kuznetsova et al., 2017)

# How to run the codes

1) read this file.
2) Unzip the file to make a folder.
3) Prepare GBVS toolbox for matlab and install it in the folder.
4) Put codes written by others in the folder: fdr_bh.m and computeCohen_d.m.
5) Run runit.m, then you will get all analysis and plots for dummy data.
6) For analysis with Rstudio, run glm20220126allb.Rmd and glm20220126amb. This has to be done after running runit.m, which generates data files for R.

If you wish to analyze your data, prepare data files according to the following instructions:
1) Prepare the data files listed below. 
 * subject_label12.csv (Information about subjects)
 * FixationSummaryAll1231.mat (saccade data)
 * emsdata0427d.mat (cognitive scores)
2) Prepare your images in "images" folder. The codes assume JPEG color images with 512*640 pixels.
3) Edit create_saliency_data0901mod.m to add the file names of your images
4) Run runit_yourdata.m, then you will get all analysis and plots.
