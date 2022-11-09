function fixdata = makeFixdata8_1008(kk, FixationSummaryAll, out_itti, stims)

FixationSummary = FixationSummaryAll{kk, stims}.FixationSummary;
valOffset = FixationSummaryAll{kk, stims}.valOffset;
tt = -1000:8300; % 決め打ち。要確認 DataAll{stims}.time;

% subplot(7,8,stims)
% imagesc(saliency_data{stims}.DKLO);
% imagesc(saliency_data{stims}.out_gbvs.master_map_resized);
% hold on

fixdata = NaN(size(FixationSummary,1), 81);
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
    
    % 512*640にて
    xxs2 = round(xx/2);
    yys2 = round(yy/2);
    % disp([xx yy xxs2 yys2])
    if (xxs2 > 640 || xxs2 < 1 || yys2 > 512 || yys2 < 1)
        fixdata(jj,8:end) = NaN;
    elseif (isnan(xxs2) || isnan(yys2))
        % warning('isnan(xxs) || isnan(yys)') % skip
    else
        % plot(xxs2, yys2, 'w.');
        fixdata(jj, 8) = out_itti{stims}.master_map(yys2, xxs2);
        fixdata(jj, 9) = out_itti{stims}.feature_map1(yys2, xxs2);
        fixdata(jj,10) = out_itti{stims}.feature_map2(yys2, xxs2);
        fixdata(jj,11) = out_itti{stims}.feature_map3(yys2, xxs2);
        fixdata(jj,12) = out_itti{stims}.rawfeatmaps000_2(yys2, xxs2);
        fixdata(jj,13) = out_itti{stims}.rawfeatmaps000_3(yys2, xxs2);
        fixdata(jj,14) = out_itti{stims}.rawfeatmaps000_4(yys2, xxs2);
        fixdata(jj,15) = out_itti{stims}.rawfeatmaps000_5(yys2, xxs2);
        fixdata(jj,16) = out_itti{stims}.rawfeatmaps000_6(yys2, xxs2);
        fixdata(jj,17) = out_itti{stims}.rawfeatmaps045_2(yys2, xxs2);
        fixdata(jj,18) = out_itti{stims}.rawfeatmaps045_3(yys2, xxs2);
        fixdata(jj,19) = out_itti{stims}.rawfeatmaps045_4(yys2, xxs2);
        fixdata(jj,20) = out_itti{stims}.rawfeatmaps045_5(yys2, xxs2);
        fixdata(jj,21) = out_itti{stims}.rawfeatmaps045_6(yys2, xxs2);
        fixdata(jj,22) = out_itti{stims}.rawfeatmaps090_2(yys2, xxs2);
        fixdata(jj,23) = out_itti{stims}.rawfeatmaps090_3(yys2, xxs2);
        fixdata(jj,24) = out_itti{stims}.rawfeatmaps090_4(yys2, xxs2);
        fixdata(jj,25) = out_itti{stims}.rawfeatmaps090_5(yys2, xxs2);
        fixdata(jj,26) = out_itti{stims}.rawfeatmaps090_6(yys2, xxs2);
        fixdata(jj,27) = out_itti{stims}.rawfeatmaps135_2(yys2, xxs2);
        fixdata(jj,28) = out_itti{stims}.rawfeatmaps135_3(yys2, xxs2);
        fixdata(jj,29) = out_itti{stims}.rawfeatmaps135_4(yys2, xxs2);
        fixdata(jj,30) = out_itti{stims}.rawfeatmaps135_5(yys2, xxs2);
        fixdata(jj,31) = out_itti{stims}.rawfeatmaps135_6(yys2, xxs2);
        fixdata(jj,32) = out_itti{stims}.rawfeatmapsALL_2(yys2, xxs2);
        fixdata(jj,33) = out_itti{stims}.rawfeatmapsALL_3(yys2, xxs2);
        fixdata(jj,34) = out_itti{stims}.rawfeatmapsALL_4(yys2, xxs2);
        fixdata(jj,35) = out_itti{stims}.rawfeatmapsALL_5(yys2, xxs2);
        fixdata(jj,36) = out_itti{stims}.rawfeatmapsALL_6(yys2, xxs2);
        fixdata(jj,37) = out_itti{stims}.featureActivationMaps000_2_4(yys2, xxs2);
        fixdata(jj,38) = out_itti{stims}.featureActivationMaps000_2_5(yys2, xxs2);
        fixdata(jj,39) = out_itti{stims}.featureActivationMaps000_3_5(yys2, xxs2);
        fixdata(jj,40) = out_itti{stims}.featureActivationMaps000_3_6(yys2, xxs2);
        fixdata(jj,41) = out_itti{stims}.featureActivationMaps045_2_4(yys2, xxs2);
        fixdata(jj,42) = out_itti{stims}.featureActivationMaps045_2_5(yys2, xxs2);
        fixdata(jj,43) = out_itti{stims}.featureActivationMaps045_3_5(yys2, xxs2);
        fixdata(jj,44) = out_itti{stims}.featureActivationMaps045_3_6(yys2, xxs2);
        fixdata(jj,45) = out_itti{stims}.featureActivationMaps090_2_4(yys2, xxs2);
        fixdata(jj,46) = out_itti{stims}.featureActivationMaps090_2_5(yys2, xxs2);
        fixdata(jj,47) = out_itti{stims}.featureActivationMaps090_3_5(yys2, xxs2);
        fixdata(jj,48) = out_itti{stims}.featureActivationMaps090_3_6(yys2, xxs2);
        fixdata(jj,49) = out_itti{stims}.featureActivationMaps135_2_4(yys2, xxs2);
        fixdata(jj,50) = out_itti{stims}.featureActivationMaps135_2_5(yys2, xxs2);
        fixdata(jj,51) = out_itti{stims}.featureActivationMaps135_3_5(yys2, xxs2);
        fixdata(jj,52) = out_itti{stims}.featureActivationMaps135_3_6(yys2, xxs2);
        fixdata(jj,53) = out_itti{stims}.featureActivationMapsALL_2_4(yys2, xxs2);
        fixdata(jj,54) = out_itti{stims}.featureActivationMapsALL_2_5(yys2, xxs2);
        fixdata(jj,55) = out_itti{stims}.featureActivationMapsALL_3_5(yys2, xxs2);
        fixdata(jj,56) = out_itti{stims}.featureActivationMapsALL_3_6(yys2, xxs2);
        fixdata(jj,57) = out_itti{stims}.normalizedActivationMaps000_2_4(yys2, xxs2);
        fixdata(jj,58) = out_itti{stims}.normalizedActivationMaps000_2_5(yys2, xxs2);
        fixdata(jj,59) = out_itti{stims}.normalizedActivationMaps000_3_5(yys2, xxs2);
        fixdata(jj,60) = out_itti{stims}.normalizedActivationMaps000_3_6(yys2, xxs2);
        fixdata(jj,61) = out_itti{stims}.normalizedActivationMaps045_2_4(yys2, xxs2);
        fixdata(jj,62) = out_itti{stims}.normalizedActivationMaps045_2_5(yys2, xxs2);
        fixdata(jj,63) = out_itti{stims}.normalizedActivationMaps045_3_5(yys2, xxs2);
        fixdata(jj,64) = out_itti{stims}.normalizedActivationMaps045_3_6(yys2, xxs2);
        fixdata(jj,65) = out_itti{stims}.normalizedActivationMaps090_2_4(yys2, xxs2);
        fixdata(jj,66) = out_itti{stims}.normalizedActivationMaps090_2_5(yys2, xxs2);
        fixdata(jj,67) = out_itti{stims}.normalizedActivationMaps090_3_5(yys2, xxs2);
        fixdata(jj,68) = out_itti{stims}.normalizedActivationMaps090_3_6(yys2, xxs2);
        fixdata(jj,69) = out_itti{stims}.normalizedActivationMaps135_2_4(yys2, xxs2);
        fixdata(jj,70) = out_itti{stims}.normalizedActivationMaps135_2_5(yys2, xxs2);
        fixdata(jj,71) = out_itti{stims}.normalizedActivationMaps135_3_5(yys2, xxs2);
        fixdata(jj,72) = out_itti{stims}.normalizedActivationMaps135_3_6(yys2, xxs2);
        fixdata(jj,73) = out_itti{stims}.normalizedActivationMapsALL_2_4(yys2, xxs2);
        fixdata(jj,74) = out_itti{stims}.normalizedActivationMapsALL_2_5(yys2, xxs2);
        fixdata(jj,75) = out_itti{stims}.normalizedActivationMapsALL_3_5(yys2, xxs2);
        fixdata(jj,76) = out_itti{stims}.normalizedActivationMapsALL_3_6(yys2, xxs2);
        fixdata(jj,77) = out_itti{stims}.rawfeatmapsLum2(yys2, xxs2);
        fixdata(jj,78) = out_itti{stims}.rawfeatmapsLum3(yys2, xxs2);
        fixdata(jj,79) = out_itti{stims}.rawfeatmapsLum4(yys2, xxs2);
        fixdata(jj,80) = out_itti{stims}.rawfeatmapsLum5(yys2, xxs2);
        fixdata(jj,81) = out_itti{stims}.rawfeatmapsLum6(yys2, xxs2);
    end
end
