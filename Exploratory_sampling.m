%% Histograms of stim efffects
%Choice Reaction Time  - orignial histogram

% during Learning
% only correct trials
% both monkeys

% figure 3,4 - seperate monkeys

Colmain = [0.99 0.79 0.95;    0.59  0.41   0.94;     0.47    0.09    0.57];
Col1 =    [0.8 0.8 0.8;    1    0.64   0.64;  0.64    0.85    1];
Col2 =    [0.63 0.63 0.63; 1    0.3    0.3;   0.31    0.72    1];
Col3 =    [0.41 0.41 0.41; 1    0.08    0.08; 0.08    0.59    0.9];

EOD=TrialDATA.durationFixationsPriorToChoice;
EOD(EOD>10 | EOD<0.005) = nan;
EOD_no4=TrialDATA.durationFixationsPriorToChoice_no4;
EOD_no4(EOD_no4>10) = nan;
EON=TrialDATA.numFixationsPriorToChoice;
EON(EON>15 | EON<0) = nan;

Area = 1;
kk = [1,2,3];
Vec = EOD;
dim = 3;
trl_num = 30;

%1 Saccade
numbins = 50;
binEdges = linspace(0, 1, numbins+1);
ylimit = 160;

%Y1=Vec(TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
%Y2=Vec(TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == 4 & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
Y1=Vec(TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area  & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim   );
Y2=Vec(TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area  & TrialDATA.StimCnd5 == kk(2) & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim   );
% Mn1 = nanmedian(Y1);
% Mn2 = nanmedian(Y2);
Mn1 = nanmean(Y1)
Mn2 = nanmean(Y2)
sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = nanstd(Y2)/sqrt(length(Y2));
figure(1)
subplot(3,2,1)
histogram(Y1,numbins,'FaceColor', Col1(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col1(2,:),'BinEdges', binEdges); hold on; 
xline([Mn1],'-',{' ','Median',' '}, 'Color', Col1(1,:),'LabelHorizontalAlignment', 'left' , 'LabelOrientation', 'horizontal')
xline([Mn2],'-',{' ','Median',' '}, 'Color', Col1(2,:), 'LabelOrientation', 'horizontal')
xlim([0 1.1])
ylim([0 ylimit])
x_patch1 = [Mn1 - sd1, Mn1 - sd1, ...
           Mn1 + sd1, Mn1 + sd1];
y_patch1 = [0, ylimit, ylimit, 0];
patch(x_patch1, y_patch1, Col1(1,:),'FaceAlpha', 0.2,'EdgeColor','none');
x_patch2 = [Mn2 - sd2, Mn2 - sd2, ...
           Mn2 + sd2, Mn2 + sd2];
y_patch2 = [0, ylimit, ylimit, 0];
patch(x_patch2, y_patch2, Col1(2,:),'FaceAlpha', 0.2,'EdgeColor','none');
legend({'Sham','Sr+'})
ylabel({'1 Object Saccade';' Count'})

Y1=Vec(TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Y2=Vec(TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area  & TrialDATA.StimCnd5 == kk(3)  & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
% Mn1 = nanmean(Y1)
% Mn2 = nanmean(Y2)
sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = nanstd(Y2)/sqrt(length(Y2));
figure(1)
subplot(3,2,2)
histogram(Y1,numbins,'FaceColor', Col1(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col1(3,:),'BinEdges', binEdges); hold on; 
xline([Mn1],'-',{' ','Median',' '}, 'Color', Col1(1,:),'LabelHorizontalAlignment', 'left' , 'LabelOrientation', 'horizontal')
xline([Mn2],'-',{' ','Median',' '}, 'Color', Col1(3,:), 'LabelOrientation', 'horizontal')
xlim([0 1.1])
ylim([0 ylimit])
x_patch1 = [Mn1 - sd1, Mn1 - sd1, ...
           Mn1 + sd1, Mn1 + sd1];
y_patch1 = [0, ylimit, ylimit, 0];
patch(x_patch1, y_patch1, Col1(1,:),'FaceAlpha', 0.2,'EdgeColor','none');
x_patch2 = [Mn2 - sd2, Mn2 - sd2, ...
           Mn2 + sd2, Mn2 + sd2];
y_patch2 = [0, ylimit, ylimit, 0];
patch(x_patch2, y_patch2, Col1(3,:),'FaceAlpha', 0.2,'EdgeColor','none');
legend({'Sham','Sr-'})
ylabel({'1 Object Saccade';' Count'})


%2 Saccade
numbins = 50;
binEdges = linspace(0, 1.5, numbins+1);
ylimit = 200;

Y1=Vec(TrialDATA.numFixationsPriorToChoice == 1 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area  & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 1  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Y2=Vec(TrialDATA.numFixationsPriorToChoice == 1 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area  & TrialDATA.StimCnd5 == kk(2) & TrialDATA.stimsessionType == 1  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
% Mn1 = nanmean(Y1)
% Mn2 = nanmean(Y2)
sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = nanstd(Y2)/sqrt(length(Y2));
figure(1)
subplot(3,2,3)
histogram(Y1,numbins,'FaceColor', Col2(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col2(2,:),'BinEdges', binEdges); hold on; 
xline([Mn1],'-',{' ','Median',' '}, 'Color', Col2(1,:),'LabelHorizontalAlignment', 'left' , 'LabelOrientation', 'horizontal')
xline([Mn2],'-',{' ','Median',' '}, 'Color', Col2(2,:), 'LabelOrientation', 'horizontal')
xlim([0 1.5])
ylim([0 ylimit])
x_patch1 = [Mn1 - sd1, Mn1 - sd1, ...
           Mn1 + sd1, Mn1 + sd1];
y_patch1 = [0, ylimit, ylimit, 0];
patch(x_patch1, y_patch1, Col2(1,:),'FaceAlpha', 0.2,'EdgeColor','none');
x_patch2 = [Mn2 - sd2, Mn2 - sd2, ...
           Mn2 + sd2, Mn2 + sd2];
y_patch2 = [0, ylimit, ylimit, 0];
patch(x_patch2, y_patch2, Col2(2,:),'FaceAlpha', 0.2,'EdgeColor','none');
legend({'Sham','Sr+'})
ylabel({'2 Object Saccade';' Count'})


Y1=Vec(TrialDATA.numFixationsPriorToChoice == 1 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 2  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Y2=Vec(TrialDATA.numFixationsPriorToChoice == 1 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area & TrialDATA.StimCnd5 == kk(3) & TrialDATA.stimsessionType == 2  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
% Mn1 = nanmean(Y1)
% Mn2 = nanmean(Y2)
sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = nanstd(Y2)/sqrt(length(Y2));
figure(1)
subplot(3,2,4)
histogram(Y1,numbins,'FaceColor', Col2(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col2(3,:),'BinEdges', binEdges); hold on; 
xline([Mn1],'-',{' ','Median',' '}, 'Color', Col2(1,:),'LabelHorizontalAlignment', 'left' , 'LabelOrientation', 'horizontal')
xline([Mn2],'-',{' ','Median',' '}, 'Color', Col2(3,:), 'LabelOrientation', 'horizontal')
xlim([0 1.5])
ylim([0 ylimit])
x_patch1 = [Mn1 - sd1, Mn1 - sd1, ...
           Mn1 + sd1, Mn1 + sd1];
y_patch1 = [0, ylimit, ylimit, 0];
patch(x_patch1, y_patch1, Col2(1,:),'FaceAlpha', 0.2,'EdgeColor','none');
x_patch2 = [Mn2 - sd2, Mn2 - sd2, ...
           Mn2 + sd2, Mn2 + sd2];
y_patch2 = [0, ylimit, ylimit, 0];
patch(x_patch2, y_patch2, Col2(3,:),'FaceAlpha', 0.2,'EdgeColor','none');
ylabel({'2 Object Saccade';' Count'})
legend({'Sham','Sr-'})

%+3 Saccade
numbins = 50;
binEdges = linspace(0, 2.5, numbins+1);
ylimit = 230;

Y1=Vec(TrialDATA.numFixationsPriorToChoice >= 2 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 1  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Y2=Vec(TrialDATA.numFixationsPriorToChoice>= 2 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area  & TrialDATA.StimCnd5 == kk(2) & TrialDATA.stimsessionType == 1  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
% Mn1 = nanmean(Y1)
% Mn2 = nanmean(Y2)
sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = nanstd(Y2)/sqrt(length(Y2));
figure(1)
subplot(3,2,5)
histogram(Y1,numbins,'FaceColor', Col3(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col3(2,:),'BinEdges', binEdges); hold on; 
xline([Mn1],'-',{' ','Median',' '}, 'Color', Col3(1,:),'LabelHorizontalAlignment', 'left' , 'LabelOrientation', 'horizontal')
xline([Mn2],'-',{' ','Median',' '}, 'Color', Col3(2,:), 'LabelOrientation', 'horizontal')
xlim([0 2.5])
ylim([0 ylimit])
x_patch1 = [Mn1 - sd1, Mn1 - sd1, ...
           Mn1 + sd1, Mn1 + sd1];
y_patch1 = [0, ylimit, ylimit, 0];
patch(x_patch1, y_patch1, Col3(1,:),'FaceAlpha', 0.2,'EdgeColor','none');
x_patch2 = [Mn2 - sd2, Mn2 - sd2, ...
           Mn2 + sd2, Mn2 + sd2];
y_patch2 = [0, ylimit, ylimit, 0];
patch(x_patch2, y_patch2, Col3(2,:),'FaceAlpha', 0.2,'EdgeColor','none');
legend({'Sham','Sr+'})
ylabel({'+3 Object Saccade';' Count'})
xlabel('Exploratory Sampling Time (s)')

Y1=Vec(TrialDATA.numFixationsPriorToChoice >= 2 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area  & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 2  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Y2=Vec(TrialDATA.numFixationsPriorToChoice>= 2 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area & TrialDATA.StimCnd5 == kk(3)  & TrialDATA.stimsessionType == 2  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
% Mn1 = nanmean(Y1)
% Mn2 = nanmean(Y2)
sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = nanstd(Y2)/sqrt(length(Y2));
figure(1)
subplot(3,2,6)
histogram(Y1,numbins,'FaceColor', Col3(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col3(3,:),'BinEdges', binEdges); hold on; 
xline([Mn1],'-',{' ','Median',' '}, 'Color', Col3(1,:),'LabelHorizontalAlignment', 'left' , 'LabelOrientation', 'horizontal')
xline([Mn2],'-',{' ','Median',' '}, 'Color', Col3(3,:), 'LabelOrientation', 'horizontal')
xlim([0 2.5])
ylim([0 ylimit])
x_patch1 = [Mn1 - sd1, Mn1 - sd1, ...
           Mn1 + sd1, Mn1 + sd1];
y_patch1 = [0, ylimit, ylimit, 0];
patch(x_patch1, y_patch1, Col3(1,:),'FaceAlpha', 0.2,'EdgeColor','none');
x_patch2 = [Mn2 - sd2, Mn2 - sd2, ...
           Mn2 + sd2, Mn2 + sd2];
y_patch2 = [0, ylimit, ylimit, 0];
patch(x_patch2, y_patch2, Col3(3,:),'FaceAlpha', 0.2,'EdgeColor','none');
legend({'Sham','Sr-'})
ylabel({'+3 Object Saccade';' Count'})
xlabel('Exploratory Sampling Time (s)')

sgtitle('ACC Sessions')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Effective Sites
% Positive Stim effect
%Effective_Sites = [12;13;18;108;113;48;49;52;56;58;60;68;71;128;129;132;137;138;140;144;145;149];
% Negetive Stim effect
Effective_Sites = [9;11;15;21;22;33;37;104;105;106;109;110;111;116;121;122;123;50;51;133;134;139;142;143;148];

Area = 1;
kk = [1,2,3];

Vec = EOD;
dim = 3;

%1 Saccade
numbins = 50;
binEdges = linspace(0, 1, numbins+1);

%1 Saccade
Y1=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
Y2=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == kk(2) & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
%Mn = nanmedian(Y1);
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
sd1 = 0; %sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = 0; %sd2 = nanstd(Y2)/sqrt(length(Y2));

figure(2)
subplot(3,2,6)
histogram(Y1,numbins,'FaceColor', Col1(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col1(2,:),'BinEdges', binEdges); hold on; 
xline([Mn1-sd1 Mn1 Mn1+sd1],'-',{' ','Median',' '}, 'Color', Col1(1,:),'LabelHorizontalAlignment', 'left' , 'LabelOrientation', 'horizontal')
xline([Mn2-sd2 Mn2 Mn2+sd2],'-',{' ','Median',' '}, 'Color', Col1(2,:), 'LabelOrientation', 'horizontal')
xlim([0 0.9])
ylim([0 160])
legend({'Sham','Sr+'})
ylabel({'1 Object Saccade';' Count'})

Y1=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
Y2=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice == 0 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == kk(3)  & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
%Mn = nanmedian(Y1);
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
sd1 = 0; %sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = 0; %sd2 = nanstd(Y2)/sqrt(length(Y2));

subplot(3,2,2)
histogram(Y1,numbins,'FaceColor', Col1(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col1(3,:),'BinEdges', binEdges); hold on; 
xline([Mn1-sd1 Mn1 Mn1+sd1],'-',{' ','Median',' '}, 'Color', Col1(1,:),'LabelHorizontalAlignment', 'left', 'LabelOrientation', 'horizontal')
xline([Mn2-sd2 Mn2 Mn2+sd2],'-',{' ','Median',' '}, 'Color', Col2(3,:), 'LabelOrientation', 'horizontal')
xlim([0 0.9])
ylim([0 70])
legend({'Sham','Sr-'})



%2 Saccade
numbins = 50;
binEdges = linspace(0, 1.5, numbins+1);

Y1=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice == 1 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 1  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
Y2=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice == 1 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == kk(2) & TrialDATA.stimsessionType == 1  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
%Mn = nanmedian(Y1);
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
sd1 = 0; %sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = 0; %sd2 = nanstd(Y2)/sqrt(length(Y2));

subplot(3,2,3)
histogram(Y1,numbins,'FaceColor', Col2(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col2(2,:),'BinEdges', binEdges); hold on; 
xline([Mn1-sd1 Mn1 Mn1+sd1],'-',{' ','Median',' '}, 'Color', Col2(1,:),'LabelHorizontalAlignment', 'left', 'LabelOrientation', 'horizontal')
xline([Mn2-sd2 Mn2 Mn2+sd2],'-',{' ','Median',' '}, 'Color', Col2(2,:), 'LabelOrientation', 'horizontal')
xlim([0 1.5])
ylim([0 200])
legend({'Sham','Sr+'})
ylabel({'2 Object Saccade';' Count'})

Y1=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice == 1 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 2  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
Y2=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice == 1 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == kk(3) & TrialDATA.stimsessionType == 2  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
%Mn = nanmedian(Y1);
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
sd1 = 0; %sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = 0; %sd2 = nanstd(Y2)/sqrt(length(Y2));

subplot(3,2,4)
histogram(Y1,numbins,'FaceColor', Col2(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col2(3,:),'BinEdges', binEdges); hold on; 
xline([Mn1-sd1 Mn1 Mn1+sd1],'-',{' ','Median',' '}, 'Color', Col2(1,:),'LabelHorizontalAlignment', 'left', 'LabelOrientation', 'horizontal')
xline([Mn2-sd2 Mn2 Mn2+sd2],'-',{' ','Median',' '}, 'Color', Col2(3,:), 'LabelOrientation', 'horizontal')
xlim([0 1.5])
ylim([0 200])
legend({'Sham','Sr-'})

%+3 Saccade
numbins = 50;
binEdges = linspace(0, 2.5, numbins+1);

Y1=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice >= 2 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 1  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim  );
Y2=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice>= 2 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == kk(2) & TrialDATA.stimsessionType == 1  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
%Mn = nanmedian(Y1);
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
sd1 = 0; %sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = 0; %sd2 = nanstd(Y2)/sqrt(length(Y2));

subplot(3,2,5)
histogram(Y1,numbins,'FaceColor', Col3(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col3(2,:),'BinEdges', binEdges); hold on; 
xline([Mn1-sd1 Mn1 Mn1+sd1],'-',{' ','Median',' '}, 'Color', Col3(1,:),'LabelHorizontalAlignment', 'left', 'LabelOrientation', 'horizontal')
xline([Mn2-sd2 Mn2 Mn2+sd2],'-',{' ','Median',' '}, 'Color', Col3(2,:), 'LabelOrientation', 'horizontal')
xlim([0 2.5])
ylim([0 230])
legend({'Sham','Sr+'})
ylabel({'+3 Object Saccade';' Count'})
xlabel(' (seconds)')

Y1=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice >= 2 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == 1 & TrialDATA.stimsessionType == 2  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
Y2=Vec(ismember(TrialDATA.sessionNum,Effective_Sites) & TrialDATA.numFixationsPriorToChoice>= 2 & TrialDATA.trialInBlock <= trl_num  & TrialDATA.StimArea == Area   & TrialDATA.StimCnd5 == kk(3)  & TrialDATA.stimsessionType == 2  & TrialDATA.BlockNum >=  7 & TrialDATA.cndLOAD == dim );
%Mn = nanmedian(Y1);
Mn1 = nanmedian(Y1);
Mn2 = nanmedian(Y2);
sd1 = 0; %sd1 = nanstd(Y1)/sqrt(length(Y1));
sd2 = 0; %sd2 = nanstd(Y2)/sqrt(length(Y2));

subplot(3,2,6)
histogram(Y1,numbins,'FaceColor', Col3(1,:),'BinEdges', binEdges); hold on; 
histogram(Y2,numbins,'FaceColor', Col3(3,:),'BinEdges', binEdges); hold on; 
xline([Mn1-sd1 Mn1 Mn1+sd1],'-',{' ','Median',' '}, 'Color', Col3(1,:),'LabelHorizontalAlignment', 'left', 'LabelOrientation', 'horizontal')
xline([Mn2-sd2 Mn2 Mn2+sd2],'-',{' ','Median',' '}, 'Color', Col3(3,:), 'LabelOrientation', 'horizontal')
xlim([0 2.5])
ylim([0 230])
legend({'Sham','Sr-'})
xlabel(' (seconds)')

sgtitle('Effective Sties')
