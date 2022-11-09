clearvars;
loadname = 'out_itti1008';
savename = 'out_itti1009b';
load(loadname)

out_itti2 = [];
tic;
for jj = 1:length(out_itti)
    
    % 640*512‚Érescale‚µ‚Ä•Û‘¶
    % blur‚Í‚©‚¯‚È‚¢
    map = out_itti{jj}.master_map_resized;
    out_itti2{jj}.master_map = map/sum(map(:)); 
    map = out_itti{jj}.top_level_feat_maps{1};
    map = imresize(map, 8, 'nearest');
    out_itti2{jj}.feature_map1 = map/sum(map(:));
    map = out_itti{jj}.top_level_feat_maps{2};
    map = imresize(map, 8, 'nearest');
    out_itti2{jj}.feature_map2 = map/sum(map(:));
    map = out_itti{jj}.top_level_feat_maps{3};
    map = imresize(map, 8, 'nearest');
    out_itti2{jj}.feature_map3 = map/sum(map(:));
    
    % Ori
    % rawfeatmaps
    rawfeatmaps000 = out_itti{jj}.rawfeatmaps.orientation.maps.origval{1};
    rawfeatmaps045 = out_itti{jj}.rawfeatmaps.orientation.maps.origval{2};
    rawfeatmaps090 = out_itti{jj}.rawfeatmaps.orientation.maps.origval{3};
    rawfeatmaps135 = out_itti{jj}.rawfeatmaps.orientation.maps.origval{4};
    
    map = imresize(rawfeatmaps000{2}, 4, 'nearest');
    out_itti2{jj}.rawfeatmaps000_2 = map/sum(map(:));
    map = imresize(rawfeatmaps000{3}, 8, 'nearest');
    out_itti2{jj}.rawfeatmaps000_3 = map/sum(map(:));
    map = imresize(rawfeatmaps000{4},16, 'nearest');
    out_itti2{jj}.rawfeatmaps000_4 = map/sum(map(:));
    map = imresize(rawfeatmaps000{5},32, 'nearest');
    out_itti2{jj}.rawfeatmaps000_5 = map/sum(map(:));
    map = imresize(rawfeatmaps000{6},64, 'nearest');
    out_itti2{jj}.rawfeatmaps000_6 = map/sum(map(:));

    map = imresize(rawfeatmaps045{2}, 4, 'nearest');
    out_itti2{jj}.rawfeatmaps045_2 = map/sum(map(:));
    map = imresize(rawfeatmaps045{3}, 8, 'nearest');
    out_itti2{jj}.rawfeatmaps045_3 = map/sum(map(:));
    map = imresize(rawfeatmaps045{4},16, 'nearest');
    out_itti2{jj}.rawfeatmaps045_4 = map/sum(map(:));
    map = imresize(rawfeatmaps045{5},32, 'nearest');
    out_itti2{jj}.rawfeatmaps045_5 = map/sum(map(:));
    map = imresize(rawfeatmaps045{6},64, 'nearest');
    out_itti2{jj}.rawfeatmaps045_6 = map/sum(map(:));

    map = imresize(rawfeatmaps090{2}, 4, 'nearest');
    out_itti2{jj}.rawfeatmaps090_2 = map/sum(map(:));
    map = imresize(rawfeatmaps090{3}, 8, 'nearest');
    out_itti2{jj}.rawfeatmaps090_3 = map/sum(map(:));
    map = imresize(rawfeatmaps090{4},16, 'nearest');
    out_itti2{jj}.rawfeatmaps090_4 = map/sum(map(:));
    map = imresize(rawfeatmaps090{5},32, 'nearest');
    out_itti2{jj}.rawfeatmaps090_5 = map/sum(map(:));
    map = imresize(rawfeatmaps090{6},64, 'nearest');
    out_itti2{jj}.rawfeatmaps090_6 = map/sum(map(:));

    map = imresize(rawfeatmaps135{2}, 4, 'nearest');
    out_itti2{jj}.rawfeatmaps135_2 = map/sum(map(:));
    map = imresize(rawfeatmaps135{3}, 8, 'nearest');
    out_itti2{jj}.rawfeatmaps135_3 = map/sum(map(:));
    map = imresize(rawfeatmaps135{4},16, 'nearest');
    out_itti2{jj}.rawfeatmaps135_4 = map/sum(map(:));
    map = imresize(rawfeatmaps135{5},32, 'nearest');
    out_itti2{jj}.rawfeatmaps135_5 = map/sum(map(:));
    map = imresize(rawfeatmaps135{6},64, 'nearest');
    out_itti2{jj}.rawfeatmaps135_6 = map/sum(map(:));

    out_itti2{jj}.rawfeatmapsALL_2 =(out_itti2{jj}.rawfeatmaps000_2 + ...
                                     out_itti2{jj}.rawfeatmaps045_2 + ...
                                     out_itti2{jj}.rawfeatmaps090_2 + ...
                                     out_itti2{jj}.rawfeatmaps135_2)/4;
    out_itti2{jj}.rawfeatmapsALL_3 =(out_itti2{jj}.rawfeatmaps000_3 + ...
                                     out_itti2{jj}.rawfeatmaps045_3 + ...
                                     out_itti2{jj}.rawfeatmaps090_3 + ...
                                     out_itti2{jj}.rawfeatmaps135_3)/4;
    out_itti2{jj}.rawfeatmapsALL_4 =(out_itti2{jj}.rawfeatmaps000_4 + ...
                                     out_itti2{jj}.rawfeatmaps045_4 + ...
                                     out_itti2{jj}.rawfeatmaps090_4 + ...
                                     out_itti2{jj}.rawfeatmaps135_4)/4;
    out_itti2{jj}.rawfeatmapsALL_5 =(out_itti2{jj}.rawfeatmaps000_5 + ...
                                     out_itti2{jj}.rawfeatmaps045_5 + ...
                                     out_itti2{jj}.rawfeatmaps090_5 + ...
                                     out_itti2{jj}.rawfeatmaps135_5)/4;
    out_itti2{jj}.rawfeatmapsALL_6 =(out_itti2{jj}.rawfeatmaps000_6 + ...
                                     out_itti2{jj}.rawfeatmaps045_6 + ...
                                     out_itti2{jj}.rawfeatmaps090_6 + ...
                                     out_itti2{jj}.rawfeatmaps135_6)/4;

    % featureActivationMaps
    featureActivationMaps = out_itti{jj}.intermed_maps.featureActivationMaps;
    
    map = featureActivationMaps{17};
    map = imresize(map.map, 4, 'nearest');
    out_itti2{jj}.featureActivationMaps000_2_4 = map/sum(map(:));
    map = featureActivationMaps{18};
    map = imresize(map.map, 4, 'nearest');
    out_itti2{jj}.featureActivationMaps000_2_5 = map/sum(map(:));
    map = featureActivationMaps{19};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.featureActivationMaps000_3_5 = map/sum(map(:));
    map = featureActivationMaps{20};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.featureActivationMaps000_3_6 = map/sum(map(:));
    map = featureActivationMaps{21};
    map = imresize(map.map, 4, 'nearest');
    out_itti2{jj}.featureActivationMaps045_2_4 = map/sum(map(:));
    map = featureActivationMaps{22};
    map = imresize(map.map, 4, 'nearest');
    out_itti2{jj}.featureActivationMaps045_2_5 = map/sum(map(:));
    map = featureActivationMaps{23};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.featureActivationMaps045_3_5 = map/sum(map(:));
    map = featureActivationMaps{24};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.featureActivationMaps045_3_6 = map/sum(map(:));
    map = featureActivationMaps{25};
    map = imresize(map.map, 4, 'nearest');
    out_itti2{jj}.featureActivationMaps090_2_4 = map/sum(map(:));
    map = featureActivationMaps{26};
    map = imresize(map.map, 4, 'nearest');
    out_itti2{jj}.featureActivationMaps090_2_5 = map/sum(map(:));
    map = featureActivationMaps{27};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.featureActivationMaps090_3_5 = map/sum(map(:));
    map = featureActivationMaps{28};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.featureActivationMaps090_3_6 = map/sum(map(:));
    map = featureActivationMaps{29};
    map = imresize(map.map, 4, 'nearest');
    out_itti2{jj}.featureActivationMaps135_2_4 = map/sum(map(:));
    map = featureActivationMaps{30};
    map = imresize(map.map, 4, 'nearest');
    out_itti2{jj}.featureActivationMaps135_2_5 = map/sum(map(:));
    map = featureActivationMaps{31};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.featureActivationMaps135_3_5 = map/sum(map(:));
    map = featureActivationMaps{32};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.featureActivationMaps135_3_6 = map/sum(map(:));
    
    out_itti2{jj}.featureActivationMapsALL_2_4 = ...
             (out_itti2{jj}.featureActivationMaps000_2_4 + ...
              out_itti2{jj}.featureActivationMaps045_2_4 + ...
              out_itti2{jj}.featureActivationMaps090_2_4 + ...
              out_itti2{jj}.featureActivationMaps135_2_4)/4;
    out_itti2{jj}.featureActivationMapsALL_2_5 = ...
             (out_itti2{jj}.featureActivationMaps000_2_5 + ...
              out_itti2{jj}.featureActivationMaps045_2_5 + ...
              out_itti2{jj}.featureActivationMaps090_2_5 + ...
              out_itti2{jj}.featureActivationMaps135_2_5)/4;
    out_itti2{jj}.featureActivationMapsALL_3_5 = ...
             (out_itti2{jj}.featureActivationMaps000_3_5 + ...
              out_itti2{jj}.featureActivationMaps045_3_5 + ...
              out_itti2{jj}.featureActivationMaps090_3_5 + ...
              out_itti2{jj}.featureActivationMaps135_3_5)/4;
    out_itti2{jj}.featureActivationMapsALL_3_6 = ...
             (out_itti2{jj}.featureActivationMaps000_3_6 + ...
              out_itti2{jj}.featureActivationMaps045_3_6 + ...
              out_itti2{jj}.featureActivationMaps090_3_6 + ...
              out_itti2{jj}.featureActivationMaps135_3_6)/4;

    % normalizedActivationMaps
    normalizedActivationMaps = out_itti{jj}.intermed_maps.normalizedActivationMaps;

    map = normalizedActivationMaps{17};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps000_2_4 = map/sum(map(:));
    map = normalizedActivationMaps{18};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps000_2_5 = map/sum(map(:));
    map = normalizedActivationMaps{19};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps000_3_5 = map/sum(map(:));
    map = normalizedActivationMaps{20};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps000_3_6 = map/sum(map(:));
    map = normalizedActivationMaps{21};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps045_2_4 = map/sum(map(:));
    map = normalizedActivationMaps{22};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps045_2_5 = map/sum(map(:));
    map = normalizedActivationMaps{23};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps045_3_5 = map/sum(map(:));
    map = normalizedActivationMaps{24};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps045_3_6 = map/sum(map(:));
    map = normalizedActivationMaps{25};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps090_2_4 = map/sum(map(:));
    map = normalizedActivationMaps{26};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps090_2_5 = map/sum(map(:));
    map = normalizedActivationMaps{27};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps090_3_5 = map/sum(map(:));
    map = normalizedActivationMaps{28};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps090_3_6 = map/sum(map(:));
    map = normalizedActivationMaps{29};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps135_2_4 = map/sum(map(:));
    map = normalizedActivationMaps{30};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps135_2_5 = map/sum(map(:));
    map = normalizedActivationMaps{31};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps135_3_5 = map/sum(map(:));
    map = normalizedActivationMaps{32};
    map = imresize(map.map, 8, 'nearest');
    out_itti2{jj}.normalizedActivationMaps135_3_6 = map/sum(map(:));
 
    out_itti2{jj}.normalizedActivationMapsALL_2_4 = ...
             (out_itti2{jj}.normalizedActivationMaps000_2_4 + ...
              out_itti2{jj}.normalizedActivationMaps045_2_4 + ...
              out_itti2{jj}.normalizedActivationMaps090_2_4 + ...
              out_itti2{jj}.normalizedActivationMaps135_2_4)/4;
    out_itti2{jj}.normalizedActivationMapsALL_2_5 = ...
             (out_itti2{jj}.normalizedActivationMaps000_2_5 + ...
              out_itti2{jj}.normalizedActivationMaps045_2_5 + ...
              out_itti2{jj}.normalizedActivationMaps090_2_5 + ...
              out_itti2{jj}.normalizedActivationMaps135_2_5)/4;
    out_itti2{jj}.normalizedActivationMapsALL_3_5 = ...
             (out_itti2{jj}.normalizedActivationMaps000_3_5 + ...
              out_itti2{jj}.normalizedActivationMaps045_3_5 + ...
              out_itti2{jj}.normalizedActivationMaps090_3_5 + ...
              out_itti2{jj}.normalizedActivationMaps135_3_5)/4;
    out_itti2{jj}.normalizedActivationMapsALL_3_6 = ...
             (out_itti2{jj}.normalizedActivationMaps000_3_6 + ...
              out_itti2{jj}.normalizedActivationMaps045_3_6 + ...
              out_itti2{jj}.normalizedActivationMaps090_3_6 + ...
              out_itti2{jj}.normalizedActivationMaps135_3_6)/4;

    % Lum
    % rawfeatmaps
    rawfeatmapsLum = out_itti{jj}.rawfeatmaps.intensity.maps.origval{1};
    
    map = imresize(rawfeatmapsLum{2}, 4, 'nearest');
    out_itti2{jj}.rawfeatmapsLum2 = map/sum(map(:));
    map = imresize(rawfeatmapsLum{3}, 8, 'nearest');
    out_itti2{jj}.rawfeatmapsLum3 = map/sum(map(:));
    map = imresize(rawfeatmapsLum{4},16, 'nearest');
    out_itti2{jj}.rawfeatmapsLum4 = map/sum(map(:));
    map = imresize(rawfeatmapsLum{5},32, 'nearest');
    out_itti2{jj}.rawfeatmapsLum5 = map/sum(map(:));
    map = imresize(rawfeatmapsLum{6},64, 'nearest');
    out_itti2{jj}.rawfeatmapsLum6 = map/sum(map(:));

end
toc;

%%
tic;
out_itti = out_itti2;
save([savename '.mat'], 'out_itti', '-v7.3')
toc;

