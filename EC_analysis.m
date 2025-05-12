%% Error-Correct history analysis
clc;

Col_A = [];
Col_A(1,:,:) = [0.8000    0.8000    0.8000;0.8000    0.8000    0.8000; 0.7804    0.6    0.1961];
Col_A(2,:,:) = [0.6510    0.6510    0.6510;0.6510    0.6510    0.6510; 0.7804    0.4    0.1961];
Col_A(3,:,:) = [0.5000    0.5000    0.5000;0.5000    0.5000    0.5000; 0.7804    0.2    0.1961];


Mnk_Label = {'Monkey F','Monkey I','Both Monkeys'};
Title={'1','2','3'};
StimCnd_Label={'Sham', 'S-ACC','S-aSTR',};

% Legends
StimLegend1={'Sham', 'Stim ACC','Stim aSTR',};
StimLegend2 = {'Sham', 'Sr+ ACC', 'Sr- ACC','Sr+ aSTR','Sr- aSTR'};
fs = 11;

i = 1;
BlockNum_lim = 7;

ax = axes;
xx= [1,2,3,4,5,6,7];
patchx = [2.3 2.7 2.7 2.3];
patchy = [-1 -1 1 1];

ii = [5,4,3,2];

% % ACC
% Area = 1;
% kk = [1,2,3];
% STR
Area = 2;
kk = [1,4,5];
% EC_pattern = [0 NaN NaN NaN NaN NaN;
%               0 1 NaN NaN NaN NaN;
%               0 1 1 NaN NaN NaN;
%               0 1 1 1 NaN NaN;
%               0 1 1 1 1 NaN];
EC_pattern = [1 NaN NaN NaN NaN NaN;
              1 0 NaN NaN NaN NaN;
              1 0 0 NaN NaN NaN;
              1 0 0 0 NaN NaN;
              1 0 0 0 0 NaN];


EC_pattern_number = size(EC_pattern,1);
trl_len = 29;

figure(1)

for Mnk = 1:3
    for q=1:2 % for stim condition:  1,2 for Sr+, 3,4 for Sr-
        for dim = 1:3
            if Mnk <= 2
                if  q == 1
                    inds1=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==1 & TrialDATA.stimsessionType==1  & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.monkey == Mnk & TrialDATA.trialInBlock <= 30 & TrialDATA.cndLOAD == dim );
                    inds2=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==4 & TrialDATA.stimsessionType==1  & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock <= 30 & TrialDATA.cndLOAD == dim );
                    %inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.monkey == Mnk );
                elseif q == 2
                    inds1=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==1 & TrialDATA.stimsessionType==2  & TrialDATA.BlockNum >= BlockNum_lim  & TrialDATA.monkey == Mnk & TrialDATA.trialInBlock <= 30 & TrialDATA.cndLOAD == dim );
                    inds2=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==5 & TrialDATA.stimsessionType==2  & TrialDATA.BlockNum >= BlockNum_lim  & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock <= 30 & TrialDATA.cndLOAD == dim );
                    %inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.monkey == Mnk );
                end
            elseif Mnk ==3
                if  q == 1
                    inds1=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==1 & TrialDATA.stimsessionType==1  & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.trialInBlock <= 30 & TrialDATA.cndLOAD == dim );
                    inds2=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==4 & TrialDATA.stimsessionType==1  & TrialDATA.BlockNum >= BlockNum_lim  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock <= 30 & TrialDATA.cndLOAD == dim );
                    %inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.monkey == Mnk );
                elseif q == 2
                    inds1=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==1 & TrialDATA.stimsessionType==2  & TrialDATA.BlockNum >= BlockNum_lim  & TrialDATA.trialInBlock <= 30 & TrialDATA.cndLOAD == dim );
                    inds2=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==5 & TrialDATA.stimsessionType==2  & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock <= 30 & TrialDATA.cndLOAD == dim );
                    %inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= BlockNum_lim & TrialDATA.monkey == Mnk );
                end
            end
    
            EC_history1 = nan(10000,5);
            Block_trial_count1 = zeros(10000,5);
    
            EC_history2 = nan(10000,5);
            Block_trial_count2 = zeros(10000,5);
            
            % find all unquie blocks and sessions combos
            sess_num = unique(TrialDATA.sessionNum(inds1));
            block_num = unique(TrialDATA.BlockNum(inds1));
            count = 0;
    
            %Sham
            for s = 1:length(sess_num)
                for b = 1:length(block_num)
                    Session = sess_num(s);
                    Block = block_num(b);
                    count = count + 1; % each block gets a row
                    
                    inds = find(TrialDATA.sessionNum == Session & TrialDATA.BlockNum == Block);
                    Outcome_Vec = TrialDATA.outcomes_isCorrect(intersect(inds1,inds))';
    
                     if length(Outcome_Vec) >= 5 % make sure vector is not empty
                        for p = 1:EC_pattern_number
                            pattern1 = EC_pattern(p,:);
                            pattern1 = pattern1(~isnan(pattern1));
                    
                            % Initialize the count
                            %count_p = 0;
                            % Lengths of vector A and pattern p
                            %lenA = length(Outcome_Vec);
                            lenA = trl_len;
                            lenP = length(pattern1);
                            % Loop through the vector to find occurrences of the pattern
                            for x = 1:(lenA - lenP + 1)
                                if isequal(Outcome_Vec(x:x+lenP-1), pattern1)
                                    oc = Outcome_Vec(x+p);
                                    EC_history1(count,p) = oc;
                                    Block_trial_count1(count,p) = 1;
                                    count = count + 1;
                                end
                            end
                            %EC_history1(count,p) = count_p;
                        end
                        %Block_trial_count1(count,1) = lenA;
                    end
                end
            end
    
            %Stim
            % find all unquie blocks and sessions combos
            sess_num = unique(TrialDATA.sessionNum(inds2));
            block_num = unique(TrialDATA.BlockNum(inds2));
            count = 0;
    
             for s = 1:length(sess_num)
                for b = 1:length(block_num)
                    Session = sess_num(s);
                    Block = block_num(b);
                    count = count + 1; % each block gets a row
                    
                    inds = find(TrialDATA.sessionNum == Session & TrialDATA.BlockNum == Block);
                    Outcome_Vec = TrialDATA.outcomes_isCorrect(intersect(inds2,inds))';
    
                    if length(Outcome_Vec) >= 5 % make sure vector is not empty
                        for p = 1:EC_pattern_number
                            pattern1 = EC_pattern(p,:);
                            pattern1 = pattern1(~isnan(pattern1));
                    
                            % Initialize the count
                            %count_p = 0;
                            % Lengths of vector A and pattern p
                            %lenA = length(Outcome_Vec);
                            lenA = trl_len;
                            lenP = length(pattern1);
                            % Loop through the vector to find occurrences of the pattern
                            for x = 1:(lenA - lenP + 1)
                                if isequal(Outcome_Vec(x:x+lenP-1), pattern1)
                                    oc = Outcome_Vec(x+p);
                                    EC_history2(count,p) = oc;
                                    Block_trial_count2(count,p) = 1;
                                    count = count + 1;
                                end
                            end
                            %EC_history1(count,p) = count_p;
                        end
                        %Block_trial_count1(count,1) = lenA;
                    end
                end
            end
    
    %         EC_history1 = EC_history1(~any(isnan(EC_history1), 2), :);
    %         Block_trial_count1 = Block_trial_count1(~any(isnan(Block_trial_count1), 2), :);
    % 
    %         EC_history2 = EC_history2(~any(isnan(EC_history2), 2), :);
    %         Block_trial_count2 = Block_trial_count2(~any(isnan(Block_trial_count2), 2), :);
            Mn1 = nanmean(EC_history1);  
            Mn2 = nanmean(EC_history2);
          
            SEM1 = nanstd(EC_history1)./sqrt(sum(Block_trial_count1));
            SEM2 = nanstd(EC_history2)./sqrt(sum(Block_trial_count2));
    
            diff = (Mn1-Mn2);

            lCol=squeeze(Col_A(dim,3,:));
    
            figure(1)
            if q == 1
                subplot(2,3,(Mnk))
                %sham
                xx = [0.8 1.8 2.8 3.8 4.8] + 0.2*(dim-1);
                %errorbar(xx,Mn1,SEM1,'color', lCol,'linewidth',3,'LineStyle','none'); hold on;
                bar(xx,diff, 'FaceColor', lCol,'BarWidth',0.4, 'EdgeColor','none'); hold on;
                
            elseif q == 2
                subplot(2,3,(Mnk)+3)
                xx = [0.8 1.8 2.8 3.8 4.8] + 0.2*(dim-1);
                %errorbar(xx,Mn1,SEM1,'color', lCol,'linewidth',3,'LineStyle','none'); hold on;
                bar(xx,diff, 'FaceColor', lCol,'BarWidth',0.4, 'EdgeColor','none'); hold on;
            end
    
    
            if Mnk == 1
               ylabel({'Accuracy';'Percent Difference'})
            end
            %set(gca,'tickdir','out','xlim',[0 11],'ylim',[0 .30],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
            set(gca,'tickdir','out','xlim',[0.5 5.5],'ylim',[-0.4 0.4],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                
            xticks([1 2 3 4 5])
            %xticklabels({'E','EC','ECC','ECCC','ECCCC'});
            xticklabels({'C','CE','CEE','CEEE','CEEEE'});
            xlabel({'Following Trial'})
            %xticklabels({'EC','EEC','EEEC','EEEEC','EEEEEC'});
                
    %         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
    %         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})
            title(Mnk_Label(Mnk))
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%