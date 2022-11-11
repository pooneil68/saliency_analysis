function FixationSummary = makeFixationSummary(DataAll, stims)

time = DataAll{stims}.time;
val = DataAll{stims}.val;
% 1,2:xd,yd; 3,4:xp,yp; 7,8:vxd,vyd; 9,10:axd,ayd

valOffset = DataAll{stims}.valOffset;

fTimeIndex = 1 + DataAll{stims}.fTimeIndex; % fixation 0
%%mTimeIndex = 1 + DataAll{stims}.mTimeIndex; % sacc + microsacc 1(�g�c�I���W�i��)
%mTimeIndex = 1 + [DataAll{stims}.sTimeIndex;DataAll{stims}.mTimeIndex]; % sacc + microsacc 1
mTimeIndex = 1 + [DataAll{stims}.sTimeIndex]; % sacc
bTimeIndex = 1 + DataAll{stims}.bTimeIndex; % blink 2
semibTimeIndex = 1 + DataAll{stims}.semibTimeIndex; % semiblink 3
% index��0-9300 �ɂȂ��Ă���̂ŁA+1���Ă���
% artifact�͎��ԓI��fixation�̒��Ɋ܂܂�Ă���̂ŁA�J�E���g����K�v�Ȃ�
% ��ʂ̊O�����Ă��鎞������

% index�����Ԃ��Ƃ�align���Ă��΂����I    
TimeIndex = [...
    fTimeIndex 0 * ones(size(fTimeIndex,1),1);
    mTimeIndex 1 * ones(size(mTimeIndex,1),1);
    bTimeIndex 2 * ones(size(bTimeIndex,1),1);
    semibTimeIndex 3 * ones(size(semibTimeIndex,1),1);
    ];

TimeIndexS = sortrows(TimeIndex,1);
% fixation���Â��Ƃ�������̂ł��������̂�merge����
% 8317        9285           0
% 9285        9301           0
for ii=2:size(TimeIndexS,1)
    if (TimeIndexS(ii-1,3)==0 && TimeIndexS(ii,3)==0) % fixation���Â�
        TimeIndexS(ii-1,2) = TimeIndexS(ii,2);
        TimeIndexS(ii,3) = NaN; % flag������Ă����āA���Ƃł܂Ƃ߂č��
    elseif (TimeIndexS(ii-1,3)>0 && TimeIndexS(ii,3)>0) % fixation�ȊO���Â�
        % warning('atta! %d %d', kk, ii)
        TimeIndexS(ii-1,3) = NaN; % �A������ŏ��̕�������邽�߂�flag������
    end
end
sel = isnan(TimeIndexS(:,3));
TimeIndexS(sel,:) = [];
% �����0 vs 1,2,3 ��alternate���邱�Ƃ��ۏ؂��ꂽ

% �ړ�������fixation�̍��W��t������
TimeIndexS = [TimeIndexS NaN(size(TimeIndexS,1),3)];
for ii=1:size(TimeIndexS,1)
    fs = TimeIndexS(ii,1);
    fe = TimeIndexS(ii,2);
    if (TimeIndexS(ii,3)>0) % �ړ�������col4�ɓ����
        mov = sqrt((val(fe,1)-val(fs,1))^2 +(val(fe,2)-val(fs,2))^2);
        TimeIndexS(ii,4) = mov;
    elseif (TimeIndexS(ii,3)==0) % ���W��col5-6�ɓ����
        fp = [nanmedian(val(fs:fe,3)) nanmedian(val(fs:fe,4))];
        TimeIndexS(ii,5:6) = fp;
    else % 0 vs 1,2,3��alternate���Ă��Ȃ��Ƃ���m�点��
        %warning('atta2! %d %d', kk, ii)
        %warning('atta2! %d', ii)
    end
end

% FixationSummary�����
% FixStart(idx) FixEnd(idx) PreEvent(0-3) mov(deg) FixPosX(pix) FixPosY(pix)
if TimeIndexS(1,3)==0
    fp = TimeIndexS(1,5:6);
    FixationSummary = [TimeIndexS(1,1:2) 0 NaN fp];
else
    FixationSummary = [];
end
for ii=2:size(TimeIndexS,1)
    if (TimeIndexS(ii-1,3)>0 && TimeIndexS(ii,3)==0)
        mov = TimeIndexS(ii-1,4);
        fp = TimeIndexS(ii,5:6);
        flg = TimeIndexS(ii-1,3);
        FixationSummary = [FixationSummary;...
            TimeIndexS(ii,1:2) flg mov fp];
    elseif (TimeIndexS(ii-1,3)==0 && TimeIndexS(ii,3)>0)
        % skip
    else % 0 vs 1,2,3��alternate���Ă��Ȃ��Ƃ���m�点��
        %warning('atta! %d %d', kk, ii)
        %warning('atta2! %d', ii)
    end
end
% OK!

% kk
% FixationSummary

return
