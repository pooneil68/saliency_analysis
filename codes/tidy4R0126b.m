%%
clearvars;

load subject_label12
plotdatafile = 'plotdata1028b';
csvfile1 = 'plotdata_tidy_20220126b.csv';
csvfile2 = 'plotdata_tidy_20220126b_am.csv';

load(plotdatafile)
% age matched resample用データ
load idxM0419

sbj = sc.demographics(:,1); % 1がpatient, 0がcontrol
ec = 16;
plotdata2 = plotdata2(1:ec,:,:);

%% all control subjects
ii = 12; Y12 = squeeze(plotdata2(:,ii,:))';
ii = 13; Y13 = squeeze(plotdata2(:,ii,:))';
ii = 14; Y14 = squeeze(plotdata2(:,ii,:))';
ii = 15; Y15 = squeeze(plotdata2(:,ii,:))';

subjectM = repmat(sbj, 1, size(plotdata2,1));
SaccM = repmat([1:size(plotdata2,1)], length(sbj), 1);
idM = repmat([1:length(sbj)]', 1, size(plotdata2,1));
t = table(subjectM(:), idM(:), SaccM(:),Y12(:),Y13(:),Y14(:),Y15(:),...
    'VariableNames',{'subjectM','idM','SaccM','Sal','SalL','SalC','SalO'});

sel = isnan(t.Sal);
t(sel,:) = [];

writetable(t, csvfile1)

%% age-matched
hcidx = idxM(:,1); % とりあえず1をつかってやってみる
hcsel = zeros(length(sbj),1);
hcsel(hcidx) = 2;
sbj = sbj + hcsel; % 1がpatient, 2がage-matched control
plotdata2sel = plotdata2(:,:,sbj > 0);
plotdata2 = plotdata2sel;
sbj2 = sbj(sbj > 0);

ii = 12; Y12 = squeeze(plotdata2(1:ec,ii,:))';
ii = 13; Y13 = squeeze(plotdata2(1:ec,ii,:))';
ii = 14; Y14 = squeeze(plotdata2(1:ec,ii,:))';
ii = 15; Y15 = squeeze(plotdata2(1:ec,ii,:))';

subjectM = repmat(sbj2, 1, size(plotdata2,1));
SaccM = repmat([1:size(plotdata2,1)], length(sbj2), 1);
idM = repmat([1:length(sbj2)]', 1, size(plotdata2,1));
t = table(subjectM(:), idM(:), SaccM(:),Y12(:),Y13(:),Y14(:),Y15(:),...
    'VariableNames',{'subjectM','idM','SaccM','Sal','SalL','SalC','SalO'});

sel = isnan(t.Sal);
t(sel,:) = [];

writetable(t, csvfile2)

return
