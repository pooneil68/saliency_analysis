function out = ittikochmap3CIO( img )

params = makeGBVSParams;
params.useIttiKochInsteadOfGBVS = 1;
params.activationType = 2; % ( type 2 used if useIttiKoch..= 1 )
params.normalizationType = 3;  %( type 3 used if useIttiKoch..=1 )
params.normalizeTopChannelMaps = 1; % 1 = do it. (used by ittiKoch scheme)
p.ittiblurfrac = 0.03;            % apply final blur to master saliency map
                                  % (not in original Itti/Koch algo. but improves eye-movement predctions)
params.verbose = 0;
params.unCenterBias = 0;

params.channels = 'CIO'; % CIOÇ…ïœçX
% weightÇÕdefaultÇ≈1Ç»ÇÃÇ≈ÇªÇÃÇ‹Ç‹
% params.dklcolorWeight = 1;
% params.intensityWeight = 1;             
% params.orientationWeight = 1;

% uncomment the line below (ittiDeltaLevels = [2 3]) for more faithful implementation 
% (however, known to give crappy results for small images i.e. < 640 in height or width )
params.ittiDeltaLevels = [ 2 3 ];

if ( strcmp(class(img),'char') == 1 ) img = imread(img); end
if ( strcmp(class(img),'uint8') == 1 ) img = double(img)/255; end

params.salmapmaxsize = round( max(size(img))/8 );

out = gbvs_my(img,params);
