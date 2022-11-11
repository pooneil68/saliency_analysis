clearvars;
load subject_label12
hcsz = sc.demographics(:,1); % 1がpatient, 0がcontrol

%%
fig1 = figure();
fig1.PaperOrientation = 'landscape';
fig1.PaperPosition = [0.6345    0.6345   28 14];

for img = [8 38]
    plotdatafile = sprintf('plotdata%02d', img);
    load(plotdatafile)
    savepdffile = sprintf('plot_saliency_value%02d', img);

    clf(fig1);

    % DKLO
    sp = 1;
    idx1 = 12;
    ylim = [-Inf Inf];
    subp1 = plot_saliency2mod3b(plotdata2, hcsz, sp, idx1, ylim);

    print(fig1, savepdffile, '-dpdf')

end
return

%%
function subp1 = plot_saliency2mod3b(plotdata2, hcsz, sp, idx1, ylim)

    ec = 16; % これより後ろの時点のデータはcut

    hc_plotdata2 = plotdata2(:, :, hcsz == 0);
    sp_plotdata2 = plotdata2(:, :, hcsz == 1);

    % script plot_saliency2mod3
    x2a = squeeze(hc_plotdata2(1:ec,2,:));
    xx2a = nanmedian(x2a, 2);
    x2b = squeeze(sp_plotdata2(1:ec,2,:));
    xx2b = nanmedian(x2b, 2);

    hcnum = squeeze(hc_plotdata2(1:ec,3,:));
    spnum = squeeze(sp_plotdata2(1:ec,3,:));

    hc2 = squeeze(hc_plotdata2(1:ec,idx1,:));
    yy2a = nanmean(hc2');
    err2a = nanstd(hc2')./sqrt(sum(~isnan(hc2')));

    sp2 = squeeze(sp_plotdata2(1:ec,idx1,:));
    yy2b = nanmean(sp2');
    err2b = nanstd(sp2')./sqrt(sum(~isnan(sp2')));

    ymax = max([yy2a+err2a yy2b+err2b]) * 1.05;
    ymin = min([yy2a-err2a yy2b-err2b]) * 0.95;

    subp1 = subplot(2,3,sp);
    hold on
    h1 = errorbar(xx2a, yy2a, err2a, 'mo-');
    h2 = errorbar(xx2b, yy2b, err2b, 'bo-');

    h1.MarkerEdgeColor = 'none';
    h1.MarkerFaceColor =[1 0 1];
    h1.Color = [1 0 1];
    h2.MarkerEdgeColor = 'none';
    h2.MarkerFaceColor =[0 0 1];
    h2.Color = [0 0 1];

    subp1.XTick = 0:4000:8000;
    subp1.XTickLabel = [0 4 8];
    subp1.Box =  'off';
    subp1.TickDir = 'out';

    % axis([0 8000 ylim(1) ylim(2)])
    axis([0 8000 ymin ymax])

end


