clearvars;
load FixationSummaryAll1231;
load out_itti0922;
savefile = 'saliency_value_DataAll0922';

saliency_value_DataAll = [];
tic;
for kk = 1:size(FixationSummaryAll,1)
    for stims=1:length(out_itti)
        fixdata = makeFixdata8_0922(kk, FixationSummaryAll, out_itti, stims);
        saliency_value_DataAll{kk, stims} = fixdata;
    end
end
toc;
save(savefile, 'saliency_value_DataAll')

return
