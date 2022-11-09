clearvars;
load subject_label12
hcsz = sc.demographics(:,1); % 1がpatient, 0がcontrol

% age-matched control用hcsz2
load idxM0419
hcidx = idxM(:,1); % とりあえず1をつかってやってみる
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

load FixationSummaryAll1231;
savefilename = 'fixM0924';
img_num = 56;
sbj_num = size(FixationSummaryAll,1);

%% fix map
fixM = zeros(64, 80, img_num, sbj_num);
for kk = 1:size(FixationSummaryAll,1)
    for stims=1:img_num
        fixdata = makeFixdata8s0922(kk, FixationSummaryAll, stims);
        sel = (fixdata(:,7)>0 & ~isnan(fixdata(:,8))); % >1 deg ampl & inside the display
        ff = fixdata(sel,:);
        pp = zeros(64, 80);
        for ii=1:size(ff,1)
            pp(ff(ii,9),ff(ii,8)) = pp(ff(ii,9),ff(ii,8)) + 1;
        end
        fixM(:,:,stims,kk) = pp;
    end
end
if (sum(isnan(fixM(:)))), warning('with NaN'); end % check for NaN
save(savefilename, 'fixM')

%% mapごとにnomalize
fixMn = zeros(size(fixM));
sumM = NaN(size(fixM,3),size(fixM,4));
for jj = 1:size(fixM,4) % sbj_num
for ii = 1:size(fixM,3) % img_num
    img = fixM(:,:,ii,jj);
    if any(isnan(img(:))), warning('with NaN'); end
    if isnan(sum(img(:))), warning('sum with NaN'); end
    sumM(ii,jj) = sum(img(:));
    if sum(img(:))>0 % 0のときはそのまま 結構ある
        fixMn(:,:,ii,jj) =  img / sum(img(:));
    end
end
end
if any(isnan(fixMn(:))), warning('fixMn with NaN'); end % check for NaN

%% 平均データの作成と保存
% fixM からacross subjectで平均したデータを作る
% subjectを潰して画像ごとの平均
fixMSZ56 = mean(fixM(:,:,:,hcsz2 == 1),4);
fixMHC56 = mean(fixM(:,:,:,hcsz2 == 0),4);

% 画像ごとにnormalizeする
fixMnSZ56   = fixMSZ56;
fixMnHC56   = fixMHC56;
for ii = 1:img_num
    map = fixMSZ56(:,:,ii);
    fixMnSZ56(:,:,ii) = map / sum(map(:));
    map = fixMHC56(:,:,ii);
    fixMnHC56(:,:,ii) = map / sum(map(:));
end
% SZ-HC画像
DF = fixMnSZ56 - fixMnHC56;

% さらにimageを潰して全平均
fixMnSZ335 = mean(fixMnSZ56,3);
fixMnHC335 = mean(fixMnHC56,3);

save([savefilename 'b_am'], 'fixMnSZ56','fixMnHC56','DF')

%% 画像の作成 画像ごとの計算
fig3 = figure();
fig3.PaperOrientation = 'landscape';
fig3.PaperPosition = [0.63452 0.63452 28.431 19.731];
for ii = 1:size(fixMnSZ56,3)
    sp = subplot(8,7,ii);
    imagesc(fixMnSZ56(:,:,ii));
    axis equal
    axis tight
    sp.XTick = [];
    sp.YTick = [];
end
colorbar
fig4 = figure();
fig4.PaperOrientation = 'landscape';
fig4.PaperPosition = [0.63452 0.63452 28.431 19.731];
for ii = 1:size(fixMnHC56,3)
    sp = subplot(8,7,ii);
    imagesc(fixMnHC56(:,:,ii));
    axis equal
    axis tight
    sp.XTick = [];
    sp.YTick = [];
end
colorbar
fig5 = figure();
fig5.PaperOrientation = 'landscape';
fig5.PaperPosition = [0.6345 0.6345 28.4310 19.7310];
gain = 0.001;
for ii = 1:56
    sp = subplot(8,7,ii);
    imagesc(DF(:,:,ii), [-1 1]*gain)
    axis equal
    axis tight
    sp.XTick = [];
    sp.YTick = [];
end
colorbar

%%
print(fig3, [savefilename 'c_am'], '-dpdf')
print(fig4, [savefilename 'd_am'], '-dpdf')
print(fig5, [savefilename 'e_am'], '-dpdf')

return

