% s0913b.m
clearvars;
load subject_label12

saveon = 1;
matfolder = '../saliency_schizophrenia3/DataAll';

FixationSummaryAll = [];
tic;
for kk = 1:length(sc.matfile)
    matfile = sc.matfile{kk};
    load(sprintf('%s/%s.mat', matfolder, matfile))
    for stims=1:length(DataAll)
        FixationSummary = makeFixationSummary(DataAll, stims);
        FixationSummaryAll{kk, stims}.FixationSummary = FixationSummary;
        FixationSummaryAll{kk, stims}.valOffset = DataAll{stims}.valOffset;
    end
    disp(kk)
end
toc;
if saveon
    savefile = 'FixationSummaryAll1231';
    save(savefile, 'FixationSummaryAll')
end
return
