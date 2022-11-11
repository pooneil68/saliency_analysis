function fixdata = makeFixdata8_0922(kk, FixationSummaryAll, out_itti, stims)

FixationSummary = FixationSummaryAll{kk, stims}.FixationSummary;
valOffset = FixationSummaryAll{kk, stims}.valOffset;
tt = -1000:8300; % time relative to stimulus onset (in ms)

salmap_num = 21;
fixdata = NaN(size(FixationSummary,1), salmap_num);
counter = 0;
counter2 = 0;
imgtime = 300; % accept as a sacade if it is > 300ms after image onset
minamp = 1; % accept as a saccade if it is >1 deg in ampliitudes
for jj = 1:size(FixationSummary,1)

    tt2 = tt(FixationSummary(jj,1)); % saccade onset
    fixdata(jj,1) = tt2;
    if fixdata(jj,1) > imgtime
        counter = counter + 1;
    end
    xx = FixationSummary(jj,5) - valOffset(1);
    yy = FixationSummary(jj,6) - valOffset(2);
    fixdata(jj,2) = xx;
    fixdata(jj,3) = yy;

    fixdata(jj,4) = FixationSummary(jj,3); % not used
    fixdata(jj,5) = counter;
    fixdata(jj,6) = FixationSummary(jj,4);
    if (fixdata(jj,1) > imgtime && FixationSummary(jj,4) > minamp)
        counter2 = counter2 + 1;
        fixdata(jj,7) = counter2; % count up if it a saccade
    else
        fixdata(jj,7) = 0;
    end
    
    % to rescale with 64*80 saliency map
    xxs2 = round(xx/16);
    yys2 = round(yy/16);
    % disp([xx yy xxs2 yys2])
    if (xxs2 > 80 || xxs2 < 1 || yys2 > 64 || yys2 < 1)
        fixdata(jj,8:end) = NaN;
    elseif (isnan(xxs2) || isnan(yys2))
        % warning('isnan(xxs) || isnan(yys)') % skip
    else
        % plot(xxs2, yys2, 'w.');
        fixdata(jj, 8) = out_itti{stims}.CIO_Full(yys2, xxs2);
        fixdata(jj, 9) = out_itti{stims}.CIO_Col(yys2, xxs2);
        fixdata(jj,10) = out_itti{stims}.CIO_Lum(yys2, xxs2);
        fixdata(jj,11) = out_itti{stims}.CIO_Ori(yys2, xxs2);
        fixdata(jj,12) = out_itti{stims}.DIO_Full(yys2, xxs2);
        fixdata(jj,13) = out_itti{stims}.DIO_Col(yys2, xxs2);
        fixdata(jj,14) = out_itti{stims}.DIO_Lum(yys2, xxs2);
        fixdata(jj,15) = out_itti{stims}.DIO_Ori(yys2, xxs2);
        fixdata(jj,16) = out_itti{stims}.LumD(yys2, xxs2);
        fixdata(jj,17) = out_itti{stims}.LumK(yys2, xxs2);
        fixdata(jj,18) = out_itti{stims}.LumL(yys2, xxs2);
        fixdata(jj,19) = out_itti{stims}.OriD(yys2, xxs2);
        fixdata(jj,20) = out_itti{stims}.OriK(yys2, xxs2);
        fixdata(jj,21) = out_itti{stims}.OriL(yys2, xxs2);
    end
end
