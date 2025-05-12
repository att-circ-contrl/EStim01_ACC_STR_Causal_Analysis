% Figure for session-wise Difference plots
% How does Stimulation effect each session - stim site effects

clc;
Vec{1}=BlockDATA.LP;
Vec{2}=BlockDATA.ExplObjduration_DL;
Vec{3}=BlockDATA.ExplObjNum_DL;
Vec{4}=BlockDATA.Asymp;
Vec{5}=BlockDATA.ExplObjduration_AL;
Vec{6}=BlockDATA.ExplObjNum_AL;

BlockNum_lim = 7;

% add Two histograms for 
clc; clf;
ColTUS1 = [0.5020 0.5020 0.5020;      0.8941    0.8039    0.9686];
Ses_num = unique(BlockDATA.sessionNum);
q = 1;
j = 1;

figure(1)
F_data = [];
I_data = [];
Effective_Sessions = [];
trl_lim = 30;

numbins = 15;
binEdges = linspace(-1.3, 1.3, numbins+1);

for i = 1:length(Ses_num)
    Session_Number = Ses_num(i);

    SessionBlks = find(BlockDATA.sessionNum == Session_Number);
    StimType = unique(BlockDATA.cndStim(SessionBlks));
    AreaType = unique(BlockDATA.StimArea(SessionBlks));
    Mnk = unique(BlockDATA.monkey(SessionBlks));

    %if AreaType == 1 % ACC
    if AreaType == 2 % aSTR

        if j == 1
            Y1=Vec{q}(BlockDATA.StimCnd3 == 3 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == 1); 
            Y2=Vec{q}(BlockDATA.StimCnd3 == 1 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == 1); 
            Y3=Vec{q}(BlockDATA.StimCnd3 == 3 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == 3); 
            Y4=Vec{q}(BlockDATA.StimCnd3 == 1 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == 3); 
        elseif j == 2
            Y1=Vec{q}(BlockDATA.StimCnd3 == 2 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad >= 2 & BlockDATA.GainCond == 2); 
            Y2=Vec{q}(BlockDATA.StimCnd3 == 1 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad >= 2 & BlockDATA.GainCond == 2); 
            Y3=Vec{q}(BlockDATA.StimCnd3 == 2 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad >= 2 & BlockDATA.GainCond == 3); 
            Y4=Vec{q}(BlockDATA.StimCnd3 == 1 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad >= 2 & BlockDATA.GainCond == 3); 
        elseif j == 3
            Y1=Vec{q}(BlockDATA.StimCnd3 == 2 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad >= 2 & BlockDATA.LossCond == -1); 
            Y2=Vec{q}(BlockDATA.StimCnd3 == 1 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad >= 2 & BlockDATA.LossCond == -1); 
            Y3=Vec{q}(BlockDATA.StimCnd3 == 2 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad >= 2 & BlockDATA.LossCond == -3); 
            Y4=Vec{q}(BlockDATA.StimCnd3 == 1 & BlockDATA.sessionNum == Session_Number & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk & BlockDATA.cndLoad >= 2 & BlockDATA.LossCond == -3); 
        end

        Mn1 = nanmean(Y1);
        sd1 = nanstd(Y1)/sqrt(length(Y1));
        Mn2 = nanmean(Y2);
        sd2 = nanstd(Y2)/sqrt(length(Y2));
        Mn3 = nanmean(Y3);
        sd3 = nanstd(Y3)/sqrt(length(Y3));
        Mn4 = nanmean(Y4);
        sd4 = nanstd(Y4)/sqrt(length(Y4));

        y1  = [Mn1-sd1 Mn1+sd1];
        y2  = [Mn2-sd2 Mn2+sd2];
        y3  = [Mn3-sd3 Mn1+sd3];
        y4  = [Mn4-sd4 Mn2+sd4];

        %diff1 = (Mn1 - Mn2);
        %diff2 = (Mn3 - Mn4);   
        diff1 = (Mn1 - Mn2)/(Mn1 + Mn2);
        diff2 = (Mn3 - Mn4)/(Mn3 + Mn4); 

        diff1_SE = diff1*sqrt((sd1/Mn1)^2 + (sd2/Mn2)^2);
        diff2_SE = diff1*sqrt((sd3/Mn3)^2 + (sd4/Mn4)^2);

         %Run the exact test
         % For the fisher Exact test - total correct/Incorrrect betwwn sham and stim

        %Test 1 - trial-wise in the  blocks during learning (trialDATA) and all conditions
        StimResponse = TrialDATA.outcomes_isCorrect(find(TrialDATA.sessionNum == Session_Number & TrialDATA.stimBlockCond == 1 & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.trialInBlock <= trl_lim & TrialDATA.cndLOAD == 3));
        StimCorrectResponseNum = length(find(StimResponse == 1));
        StimIncorrectResponseNum = length(find(StimResponse == 0));
        
        ShamResponse = TrialDATA.outcomes_isCorrect(find(TrialDATA.sessionNum == Session_Number & TrialDATA.stimBlockCond == 0 & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.trialInBlock <= trl_lim & TrialDATA.cndLOAD == 3));
        ShamCorrectResponseNum = length(find(ShamResponse == 1));
        ShamIncorrectResponseNum = length(find(ShamResponse == 0));

                % Define contingency table
        % A: Stim blocks, B: Control blocks
        % |       | Outcome = Correct | Outcome = Incorrect |
        % |-------|--------------|-------------|
        % | Stim  |       10     |     20      |
        % | Sham  |       5      |     25      |

        contingency_table = [StimCorrectResponseNum, StimIncorrectResponseNum;...
                             ShamCorrectResponseNum, ShamIncorrectResponseNum];
        % Perform Fisher's exact test
        [h, p_value] = fishertest(contingency_table,'Alpha',0.05);
        
        Effective_Sessions(i,1) = Session_Number;
        Effective_Sessions(i,2) = h;
        Effective_Sessions(i,3) = p_value;
        Effective_Sessions(i,3) = diff2;

        if Mnk == 1
            F_data = [F_data; diff1 diff2 Mn1 Mn2 Mn3 Mn4 sd1 sd2 sd3 sd4];
            lCol= [0.6039    0.7765    0.9294];
            subplot(4,4,[5 6 9 10])
            errorbar(diff1, diff2, diff2_SE, diff2_SE, diff1_SE, diff1_SE, 'color',lCol,'linewidth',1); hold on;               
            if h == 0 % not effective
                scatter(diff1, diff2 ,50,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
            elseif h == 1
                scatter(diff1, diff2 ,50,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol, 'MarkerEdgeColor', 'k', 'LineWidth', 1.5); hold on;
            end
        elseif Mnk == 2
            lCol= [0.9686    0.6392    0.6392];
            I_data = [I_data; diff1 diff2 Mn1 Mn2 Mn3 Mn4 sd1 sd2 sd3 sd4];
            subplot(4,4,[5 6 9 10])
            errorbar(diff1, diff2, diff2_SE, diff2_SE, diff1_SE, diff1_SE, 'color',lCol,'linewidth',1); hold on;               
            if h == 0 % not effective
                scatter(diff1, diff2 ,50,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
            elseif h == 1
                scatter(diff1, diff2 ,50,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol, 'MarkerEdgeColor', 'k', 'LineWidth', 1.5); hold on;
            end
        end
    end
end

sum(Effective_Sessions(:,2))

% means
Mn1_F_data = nanmean(F_data(:,1));
Mn2_F_data = nanmean(F_data(:,2));
sd1_F_data = nanstd(F_data(:,1))/sqrt(length(F_data(:,1)));
sd2_F_data = nanstd(F_data(:,2))/sqrt(length(F_data(:,2)));

Mn1_I_data = nanmean(I_data(:,1));
Mn2_I_data = nanmean(I_data(:,2));
sd1_I_data = nanstd(I_data(:,1))/sqrt(length(I_data(:,1)));
sd2_I_data = nanstd(I_data(:,2))/sqrt(length(I_data(:,2)));

subplot(4,4,[5 6 9 10])
lCol= [0.0745    0.6235    1.0000];
scatter( Mn1_F_data, Mn2_F_data ,70,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor','k'); hold on;
errorbar(Mn1_F_data, Mn2_F_data, sd2_F_data, sd2_F_data, sd1_F_data, sd1_F_data, 'color',lCol,'linewidth',1); hold on;               
lCol= [0.8   0    0];
scatter( Mn1_I_data, Mn2_I_data ,70,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor','k'); hold on;
errorbar(Mn1_I_data, Mn2_I_data, sd2_I_data, sd2_I_data, sd1_I_data, sd1_I_data, 'color',lCol,'linewidth',1); hold on;   

%dataMax = 1.3 * max(abs(both_data(:))); 
%set(gca,'xlim', [0 dataMax], 'ylim', [0 dataMax])
xlim([-1.3 1.3])
ylim([-1.3 1.3])
xline(0)
yline(0)

if j == 1
    ylabel({[Yaxistitle2{q}] [Yaxistitle{j}]})
else
    ylabel(Yaxistitle{j})
end

xlabel(Xaxistitle{j})
set(gca,'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
%title('Consistency of Stimulation Effects')

% now add the histograms
 x1 = [F_data(:,1); I_data(:,1)];
 y1 = [F_data(:,2); I_data(:,2)];
 %x2 = [F_data(:,5); I_data(:,5)];
 %y2 = [F_data(:,6); I_data(:,6)];

% looking at the differences
%Plot as histogram
%Create the histogram on the top
topHist = subplot(4,4,[1 2]);
histogram(x1,numbins,'facealpha',0.7, 'FaceColor', ColTUS1(2,:), 'Normalization', 'count', 'BinEdges', binEdges); hold on;
%histogram(y1,numbins,'facealpha',0.3, 'FaceColor', ColTUS1(1,:), 'Normalization', 'count', 'BinEdges', binEdges); hold on;
ylabel('Count')
xlabel('1D Index')
%topHist.XAxis.Visible = 'off';
topHist.YAxisLocation = 'right';
xline(0, '--k', 'LineWidth', 2); % Index reference
xline(Mn1_F_data, '-b', 'LineWidth', 2); % F mean
xline(Mn1_I_data, '-r', 'LineWidth', 2); % F mean

set(gca,'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)

% Create the histogram on the right
rightHist = subplot(4,4,[7 11]);
%histogram(x2,numbins,'facealpha',0.7, 'FaceColor', ColTUS1(2,:), 'Orientation', 'horizontal', 'Normalization', 'count', 'BinEdges', binEdges); hold on;
histogram(y1,numbins,'facealpha',0.7, 'FaceColor', ColTUS1(2,:), 'Orientation', 'horizontal', 'Normalization', 'count', 'BinEdges', binEdges); hold on;
xlabel('Count')
ylabel('3D Index')
%rightHist.YAxis.Visible = 'off';
rightHist.XAxisLocation = 'top';
yline(0, '--k', 'LineWidth', 2); % Index reference
yline(Mn2_F_data, '-b', 'LineWidth', 2); % F mean
yline(Mn2_I_data, '-r', 'LineWidth', 2); % F mean
set(gca,'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)

% add pie charts
ColTUS3 = [0.5686    0.9098    0.4471; 
           0.9294    0.8392    0.5843;
           0.8000    0.8000    0.8000];
% %aACC
num_PosMnk1 = 3;
num_NegMnk1 = 7;

num_PosMnk2 = 2;
num_NegMnk2 = 10;

%aSTR
% num_PosMnk1 = 8;
% num_NegMnk1 = 2;
% 
% num_PosMnk2 = 9;
% num_NegMnk2 = 6;

subplot(4,4,8);
data = [num_PosMnk1,num_NegMnk1 , 24 - (num_PosMnk1+num_NegMnk1)];
h1 = pie(data,[1,1,0]);
title('Monkey F');

labels = arrayfun(@num2str, data, 'UniformOutput', false);
%need to change the color 
for k = 1:3
    if k <= length(ColTUS3)
        h1(2*k-1).FaceColor = ColTUS3(k, :);
    end
    if ishandle(h1(2*k)) % Check if the handle is valid (text objects are even-indexed)
        h1(2*k).String = labels{k};
    end
end

subplot(4,4,12);
data = [num_PosMnk2,num_NegMnk2 , 24 - (num_PosMnk2+num_NegMnk2)];
h1 = pie(data,[1,1,0]);
title('Monkey I');

labels = arrayfun(@num2str, data, 'UniformOutput', false);
%need to change the color 
for k = 1:3
    if k <= length(ColTUS3)
        h1(2*k-1).FaceColor = ColTUS3(k, :);
    end
    if ishandle(h1(2*k)) % Check if the handle is valid (text objects are even-indexed)
        h1(2*k).String = labels{k};
    end
end

% test mean LP for the histograms

% means
Mn1_F = F_data(:,3);
Mn2_F = F_data(:,4);
Mn3_F = F_data(:,5);
Mn4_F = F_data(:,6);

Mn1_I = I_data(:,3);
Mn2_I = I_data(:,4);
Mn3_I = I_data(:,5);
Mn4_I = I_data(:,6);

%1D
p1 = ranksum(Mn1_F,Mn2_F)
p2 = ranksum(Mn1_I,Mn2_I)

%3D
p3 = ranksum(Mn3_F,Mn4_F)
p4 = ranksum(Mn3_I,Mn4_I)
