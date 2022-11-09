clearvars;
load subject_label12
load out_itti0922;
load saliency_value_DataAll0922;

binw2 = 1;
maxfix = 19; % とりあえず固定

fixdata = saliency_value_DataAll{1,1};
salmap_num = size(fixdata,2);
sbj_num = size(saliency_value_DataAll,1);
img_num = size(saliency_value_DataAll,2);

%% imageごと
fixnum = 1:binw2:maxfix;
for idx = [8 38]
    savefilename = sprintf('plotdata%02d.mat', idx);
    plotdata2 = NaN(length(fixnum), salmap_num, sbj_num);
    for kk = 1:sbj_num
        fixdata = saliency_value_DataAll{kk, idx};
        sel = (fixdata(:,7)>0); % counter2
        fixdata_all = [fixdata(sel,:) idx*ones(sum(sel),1)];
        % saccadeの回数で集める  col7は>1degの条件も加えてある
        for ii = 1:length(fixnum)
            if ii == length(fixnum) % lastは全データを入れる
                sel = (fixdata_all(:,7) >= fixnum(ii));
            else
                sel = (fixdata_all(:,7) >= fixnum(ii) & fixdata_all(:,7) < fixnum(ii+1));
            end
            plotdata2(ii, 1, kk) = fixnum(ii);
            plotdata2(ii, 2, kk) = mean(fixdata_all(sel,1),'omitnan'); % fixの時間
            plotdata2(ii, 3, kk) = sum(sel); % データ数
            % 番号ずらさないようにする
            % nanmean(xx,1); にしておかないとデータがひとつのときに向きが変わる
            plotdata2(ii, 8:salmap_num, kk) = mean(fixdata_all(sel,8:salmap_num),1,'omitnan');
        end
    end
    save(savefilename, 'plotdata2');
end

return


