clearvars;
load subject_label12
load saliency_value_DataAll0922;
savefilename = 'imageavrdata0923';

%%
fixdata = saliency_value_DataAll{1,1};
salmap_num = size(fixdata,2);
sbj_num = size(saliency_value_DataAll,1);
img_num = size(saliency_value_DataAll,2);

plotdata2mean   = NaN(sbj_num, img_num, salmap_num);
plotdata2median = NaN(sbj_num, img_num, salmap_num);
for kk = 1:sbj_num % subject���ƂɌv�Z
    for idx = 1:img_num % image���Ƃɕ���
        fixdata = saliency_value_DataAll{kk, idx};
        sel = (fixdata(:,7)>0); % counter2 = saccade# (outside�̂��0)
        fixdata_sel = fixdata(sel,:);
        
        % fixdata_sel(:,1:7)���܂߂Ă܂邲��mean����
        % median������
        plotdata2mean(kk,idx,:) = mean(fixdata_sel,1,'omitnan');
        plotdata2median(kk,idx,:) = median(fixdata_sel,1,'omitnan');
    end
end

plotdata2 = plotdata2mean;
save([savefilename 'mean.mat'], 'plotdata2');

plotdata2 = plotdata2median;
save([savefilename 'median.mat'], 'plotdata2');
