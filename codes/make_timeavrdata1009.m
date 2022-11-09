clearvars;
load subject_label12
load saliency_value_DataAll1009;
savefilename = 'timeavrdata1009';

%%
fixdata = saliency_value_DataAll{1,1};
salmap_num = size(fixdata,2);

plotdata2mean   = NaN(size(sc.demographics,1),salmap_num);
for kk = 1:size(sc.demographics,1) % subject���ƂɌv�Z

    fixdata_all = [];
    for idx = 1:size(saliency_value_DataAll,2) % 56
        fixdata = saliency_value_DataAll{kk, idx};
        sel = (fixdata(:,7)>0); % counter2 = saccade# (outside�̂��0)
        fixdata_all = [fixdata_all; fixdata(sel,:)];
    end
    % fixdata_all(:,1:7)���܂߂Ă܂邲��mean����
    % median������
    plotdata2mean(kk,:) = mean(fixdata_all,1,'omitnan');
end

meansaliency = plotdata2mean;
save([savefilename 'mean.mat'], 'meansaliency');
