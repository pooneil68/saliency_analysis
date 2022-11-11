clearvars;
saveon = 1;

load subject_label12
load saliency_value_DataAll0922;
savefilename = 'plotdata1028b.mat';

%%
fixdata = saliency_value_DataAll{1,1};
salmap_num = size(fixdata,2);

binw1 = 500; % in ms
bins = 0:binw1:8000-binw1;

binw2 = 1;
maxfix = 19;
fixnum = 1:binw2:maxfix;

plotdata2 = NaN(length(fixnum), salmap_num, size(sc.demographics,1));
for kk = 1:size(sc.demographics,1) % by subject

    fixdata_all = [];
    for idx=1:size(saliency_value_DataAll,2)
        fixdata = saliency_value_DataAll{kk, idx};
        sel = (fixdata(:,7)>0); % counter2
        fixdata_all = [fixdata_all; fixdata(sel,:) idx*ones(sum(sel),1)];
    end
    for ii = 1:length(fixnum)
        if ii == length(fixnum) % last column
            sel = (fixdata_all(:,7) >= fixnum(ii));
        else
            sel = (fixdata_all(:,7) >= fixnum(ii) & fixdata_all(:,7) < fixnum(ii+1));
        end
        plotdata2(ii, 1, kk) = fixnum(ii);
        plotdata2(ii, 2, kk) = nanmean(fixdata_all(sel,1)); % saccade onset
        plotdata2(ii, 3, kk) = sum(sel);
        plotdata2(ii, 8:salmap_num, kk) = nanmean(fixdata_all(sel,8:salmap_num),1);
    end
end
if saveon
    save(savefilename, 'plotdata2');
end
