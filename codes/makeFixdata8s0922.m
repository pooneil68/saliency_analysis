function fixdata = makeFixdata8s0922(kk, FixationSummaryAll, stims)

FixationSummary = FixationSummaryAll{kk, stims}.FixationSummary;
valOffset = FixationSummaryAll{kk, stims}.valOffset;
tt = -1000:8300; % 決め打ち。要確認 DataAll{stims}.time;

% ここを変える
salmap_num = 21;
fixdata = NaN(size(FixationSummary,1), salmap_num);
counter = 0;
counter2 = 0;
imgtime = 300; % onsetから300ms以上ならfixationしたことにする
minamp = 1; % 1deg以上の移動の時のみcount upする
for jj = 1:size(FixationSummary,1)

    tt2 = tt(FixationSummary(jj,1)); % fixation開始時間
    fixdata(jj,1) = tt2;
    if fixdata(jj,1) > imgtime
        counter = counter + 1;
    end
    xx = FixationSummary(jj,5) - valOffset(1);
    yy = FixationSummary(jj,6) - valOffset(2);
    fixdata(jj,2) = xx;
    fixdata(jj,3) = yy;

    % pre_conditionのデータを付加
    fixdata(jj,4) = FixationSummary(jj,3);
    fixdata(jj,5) = counter; % img提示後のfixationの回数
    % 前の視線位置との間の移動距離を入れておく
    fixdata(jj,6) = FixationSummary(jj,4);
    if (fixdata(jj,1) > imgtime && FixationSummary(jj,4) > minamp)
        counter2 = counter2 + 1;
        fixdata(jj,7) = counter2; % img提示後のfixationの回数(>1degにて)
    else
        fixdata(jj,7) = 0; % count upしないだけでなく、0を入れておく
    end
    
    % 64*80にて
    xxs2 = round(xx/16);
    yys2 = round(yy/16);
    if (xxs2 > 80 || xxs2 < 1 || yys2 > 64 || yys2 < 1)
        xxs2 = NaN; yys2 = NaN; 
    end
    fixdata(jj,8:9) = [xxs2 yys2];

end


