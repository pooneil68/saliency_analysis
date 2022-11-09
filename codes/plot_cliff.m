clearvars;
load subject_label12
load imageavrdata0923mean

hcsz = sc.demographics(:,1); % 1:SZ, 0:HC

% age-matched control
load idxM0419
hcidx = idxM(:,1); % use #1 throughout analysis
hcsz2 = hcsz;
hcsz2(hcsz2 == 0) = 3;
hcsz2(hcidx) = 0;

img_num = size(plotdata2,2);

%% age matched
%% compute statistics for each image
statM2 = [];
map = [12 13 14 15]; % DIO_FUll, Col, Lum, Ori
for idx = 1:img_num

    for mm = 1:length(map)

        saliency = squeeze(plotdata2(:,idx,map(mm)));
        sal_sz = saliency(hcsz2 == 1);
        sal_hc = saliency(hcsz2 == 0);

        % test for two independent samples
        [~,~,~,stats1] = ttest2(sal_sz, sal_hc);
        [~,~,stats2] = ranksum(sal_sz, sal_hc);
        % effect size
        Cohen_d = computeCohen_d(sal_sz, sal_hc, 'independent');
        Cliff_d = computeCliff_delta(sal_sz, sal_hc, stats2);

        statM2(idx,mm,1) = stats1.tstat;
        statM2(idx,mm,2) = stats2.zval;
        statM2(idx,mm,3) = Cohen_d;
        statM2(idx,mm,4) = Cliff_d;

    end
end

%% plot for Cliff's delta
fig1 = figure();
fig1.PaperOrientation = 'landscape';
fig1.PaperPosition = [0.85 6.5 28 8];

wd = 0.6;
tstatM = squeeze(statM2(:,:,4)); 
pdfname = 'CliffD0923M2';

for ii = 1:4
    sp = subplot(1,4,ii);
    hold on
    plot([0 0],[1 56],'k:')
    pl = plot(tstatM(:,ii), 1:56, 'ko');
    if ii == 1
        sp.YTick = 0.5:7:56.5;
    else
        sp.YTick = [];
    end
    sp.YTickLabel = [];
    
    pl.MarkerFaceColor = [1 1 1];
    pl.MarkerEdgeColor = [0 0 0];
    pl.LineWidth = 1;

    axis ij
    axis([-wd wd 1 56])
    sp.LineWidth = 1;
    sp.Box = 'off';
    sp.TickDir = 'out';
end
print(fig1, '-painters', pdfname, '-dpdf')

%% histogram for cliff's delta
fig2 = figure();
fig2.PaperOrientation = 'landscape';
fig2.PaperPosition = [0.85 6.5 28 3];

pdfname = 'hist1016';
tstatM = squeeze(statM2(:,:,4)); % z, age matched

edges = -0.6:0.1:0.6;
for jj =1:4
    sp = subplot(1,4,jj);
    hold on
    
    hc = histcounts(tstatM(:,jj), edges);
    XX = edges(1:end-1)+(edges(2)-edges(1))/2;
    pl = bar(XX, hc);

    med = median(tstatM(:,jj));
    plot([med med], [0 13], 'k-')
    
    pl.BarWidth = 1;
    pl.FaceColor = [1 1 1]*0.8;
    pl.EdgeColor = [1 1 1]*0;
    
    sp.YTick = [];
    sp.XTick = [-0.5 0 0.5];
    axis([edges(1) edges(end) 0 13])
    sp.Box = 'off';
    sp.TickDir = 'out';
end

print(fig2, '-painters', pdfname, '-dpdf')
