clearvars;
load subject_label12
load imageavrdata0923mean
savepdfname = 'plot_data0930image/';

hcsz = sc.demographics(:,1); % 1がpatient, 0がcontrol

% age-matched control用hcsz2
load idxM0419
hcidx = idxM(:,1); % とりあえず1をつかってやってみる
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

sbj_num = size(plotdata2,1);
img_num = size(plotdata2,2);
salmap_num = size(plotdata2,3);

%% pictureごとのzvalueの計算 (all subjects)
map = 12; % DIO_FUll
YTick = (0:2:20)*10^(-4);
YLim = [0.5 15; 1 6]*10^(-4);
fig2 = figure();
fig2.PaperOrientation = 'landscape';
fig2.PaperPosition = [0.6345 0.6345 20 19.7310];

counter = 0;
for idx = [8 38]
    counter = counter + 1;
    saliency = squeeze(plotdata2(:,idx,map));
    subp = plot_saliency0507c(saliency, hcsz, counter);
    subp.YTick = YTick;
    subp.YLim = YLim(counter,:);
    
end
print(fig2, 'plot_data0930image', '-dpdf');

%%
function subp = plot_saliency0507c(saliency, hcsz, sp)

    subp = subplot(3,4,sp);
    sal_sz = saliency(hcsz == 1);
    sal_hc = saliency(hcsz == 0);
    g1 = repmat({'SZ'},length(sal_sz),1);
    g2 = repmat({'HC'},length(sal_hc),1);
    violinplot([sal_sz; sal_hc], [g1;g2],...
               'ViolinColor',[1 1 1]*0.9,...
               'ViolinAlpha', 0.1);
    hold on
    pl = plot([1 2],[median(sal_hc,'omitnan') median(sal_sz,'omitnan')],'ko-');
    pl.MarkerFaceColor = [0 0 0];
    pl.MarkerEdgeColor = 'none';
    pl.MarkerSize = 6;
    pl.LineWidth = 2;
    
     subp.Children(9).SizeData = 6;
     subp.Children(17).SizeData = 6;
     subp.Children(9).MarkerFaceColor = [0 0 0];
     subp.Children(17).MarkerFaceColor = [0 0 0];
     subp.Children(16).FaceColor = [1 1 1]*0.9;
     subp.Children(8).FaceColor = [1 1 1]*0.9;

    subp.XTick = [1 2];
    subp.XTickLabel = {'HC', 'SZ'};
    subp.Box =  'off';
    subp.TickDir = 'out';
    subp.XLim = [0 3];
    axis([0 3 -Inf Inf])
    
    % 独立2群のテスト
    [h,p1,ci,stats1] = ttest2(sal_sz, sal_hc);
    [p2,h,stats2] = ranksum(sal_sz, sal_hc);
    % 効果量
    Cohen_d = computeCohen_d(sal_sz, sal_hc, 'independent');
    W = stats2.ranksum;
    U = W - length(sal_sz)*(length(sal_sz)+1)/2;
    Cliff_d = 2 * U / (length(sal_sz) * length(sal_hc)) - 1; % subjectの数が違う
    title(sprintf('%1.2e / %2.2f', p2, Cliff_d));


end
