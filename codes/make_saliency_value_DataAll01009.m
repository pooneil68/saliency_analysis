clearvars;
saveon = 1;
load out_itti1009b;
load FixationSummaryAll1231;

saliency_value_DataAll = [];
tic;
for kk = 1:size(FixationSummaryAll,1)
    for stims=1:length(out_itti)
        fixdata = makeFixdata8_1008(kk, FixationSummaryAll, out_itti, stims);
        saliency_value_DataAll{kk, stims} = fixdata;
    end
end
toc;
if saveon
    savefile = 'saliency_value_DataAll1009';
    save(savefile, 'saliency_value_DataAll')
end

return
