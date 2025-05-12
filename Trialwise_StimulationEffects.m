% Trial-wise effects

clc;clf;
ColStim2 = [0.8706    0.7137    0.7137; 1 0 0; 
           0.7333    0.7608    0.9412; 0.0745 0.6235 1.0000];

Mnk_Label = {'Monkey F','Monkey I','Both Monkeys'};
Title={'1','2','3'};
StimCnd_Label={'Sham', 'S-ACC','S-aSTR',};


% Lengends
StimLegend1={'Sham', 'Stim ACC','Stim aSTR',};
StimLegend2 = {'Sham', 'Sr+ ACC', 'Sr- ACC','Sr+ aSTR','Sr- aSTR'};
fs = 11
ax = axes;
xx= [1,2,3,4,5,6,7];
patchx = [2.3 2.7 2.7 2.3];
patchy = [-1 -1 1 1];

Mnk = 2;

BlockNum_lim = 7;
trl_num = 30;

% ACC
Area = 1;
kk = [1,2,1,3];
dim = 3;

%StimReinf+
% Accuracy following Loss
figure(1)
for q = 1:2 % for stim condition
    k = kk(q);
    Loss_history1 = [];

    if Mnk <= 2
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim    & TrialDATA.monkey == Mnk );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
         end
    elseif Mnk == 3
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim    );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  &  TrialDATA.cndLOAD == dim & TrialDATA.StimCount >= 2 );
        end
    end

    
    for t = 1:length(inds)
        outcome = TrialDATA.outcomes_isCorrect(inds(t));
        trialInBlock = TrialDATA.trialInBlock(inds(t));
        LPinblock = TrialDATA.trialsToCriterion(inds(t));
        BlockLen = TrialDATA.BlockLength(inds(t));

        %looking at Loss outcome
        if outcome == 0
            if trialInBlock == 1
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = nan;
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == 2
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == BlockLen
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:7) = nan(1,5);
            elseif trialInBlock == (BlockLen - 1)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                    Loss_history1(t,4:7) = nan(1,4);
            elseif trialInBlock == (BlockLen - 2)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                    Loss_history1(t,5:7) = nan(1,3);
            elseif trialInBlock == (BlockLen - 3)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                    Loss_history1(t,6:7) = nan(1,2);
            elseif trialInBlock == (BlockLen - 4)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                    Loss_history1(t,7) = nan;
            else
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            end
        elseif outcome == 1 
            Loss_history1(t,:) =nan(1,7);
        end
    end

    %norm = nanmean(Loss_history1_norm);
    %Y1 = Loss_history1 - norm;
    Y1 = Loss_history1;
    
    Mn1=nanmean(Y1);
    SE1=nanstd(Y1)./sqrt(length(Y1));

    lCol = ColStim2(q,:);
    figure(1)
    subplot(2,4,1)
    hold on
    for p = 1:7
        x = [p p];    
        y1 = [Mn1(p)-SE1(p) Mn1(p)+SE1(p)];
        plot(x, y1, 'color',lCol,'linewidth',2,'linestyle','-','Marker','_'); hold on;
    end
    scatter(xx ,Mn1 ,25, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
    plot(xx, Mn1, 'color',lCol,'linewidth',2,'linestyle','-'); hold on;

    patch(patchx,patchy,'r', 'EdgeColor', 'none','FaceAlpha',0.1 ,'EdgeAlpha', 0.1  ); hold on;
%         
   %ylabel('Accuracy')
   ylabel({['3D Accuracy'] ['for Trials 1:LP(ACC StimR+)']})
    
    set(gca,'tickdir','out','xlim',[0 8],'ylim',[.29 .71],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                ax = gca;

    % Set text colors to black using gca
    ax.Title.Color = 'k';       % Set title text color
    ax.XLabel.Color = 'k';      % Set x-axis label text color
    ax.YLabel.Color = 'k';      % Set y-axis label text color
    ax.XColor = 'k';            % Set x-axis tick label color
    ax.YColor = 'k';            % Set y-axis tick label color  
    xticks([1 2 3 4 5 6 7])
    xticklabels({'-2','-1','1','2','3','4','5'})
        
%         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
%         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})
        
    xlabel('Trials after Loss')
end

%After gain
figure(1)
for q = 1:2 % for stim condition - ACC only
    k = kk(q);
    Loss_history1 = [];

    if Mnk <= 2
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim    & TrialDATA.monkey == Mnk );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
         end
    elseif Mnk == 3
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim    );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  &  TrialDATA.cndLOAD == dim & TrialDATA.StimCount >= 2 );
        end
    end

    for t = 1:length(inds)
        outcome = TrialDATA.outcomes_isCorrect(inds(t));
        trialInBlock = TrialDATA.trialInBlock(inds(t));
        LPinblock = TrialDATA.trialsToCriterion(inds(t));
        BlockLen = TrialDATA.BlockLength(inds(t));

        %looking at gain outcomes
        if outcome == 1
            if trialInBlock == 1
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = nan;
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == 2
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == BlockLen
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:7) = nan(1,5);
            elseif trialInBlock == (BlockLen - 1)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                    Loss_history1(t,4:7) = nan(1,4);
            elseif trialInBlock == (BlockLen - 2)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                    Loss_history1(t,5:7) = nan(1,3);
            elseif trialInBlock == (BlockLen - 3)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                    Loss_history1(t,6:7) = nan(1,2);
            elseif trialInBlock == (BlockLen - 4)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                    Loss_history1(t,7) = nan;
            else
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            end
        elseif outcome == 0 
            Loss_history1(t,:) = nan(1,7);
        end
    end
    
     Y1 = Loss_history1;
    
    Mn1=nanmean(Y1);
    SE1=nanstd(Y1)./sqrt(length(Y1));

    lCol = ColStim2(q,:);
    figure(1)
    subplot(2,4,2)
    hold on
    for p = 1:7
        x = [p p];    
        y1 = [Mn1(p)-SE1(p) Mn1(p)+SE1(p)];
        plot(x, y1, 'color',lCol,'linewidth',2,'linestyle','-','Marker','_'); hold on;
    end
    scatter(xx ,Mn1 ,25, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
    plot(xx, Mn1, 'color',lCol,'linewidth',2,'linestyle','-'); hold on;

    patch(patchx,patchy,'g', 'EdgeColor', 'none','FaceAlpha',0.1 ,'EdgeAlpha', 0.1  ); hold on;
%         
   ylabel({['3D Accuracy'] ['for Trials 1:LP(ACC StimR+)']})

    set(gca,'tickdir','out','xlim',[0 8],'ylim',[.5 .9],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                ax = gca;

    % Set text colors to black using gca
    ax.Title.Color = 'k';       % Set title text color
    ax.XLabel.Color = 'k';      % Set x-axis label text color
    ax.YLabel.Color = 'k';      % Set y-axis label text color
    ax.XColor = 'k';            % Set x-axis tick label color
    ax.YColor = 'k';            % Set y-axis tick label color  
    xticks([1 2 3 4 5 6 7])
    xticklabels({'-2','-1','1','2','3','4','5'})
        
%         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
%         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})     
    xlabel('Trials after Gain')
end

%StimReinf-
% Accuracy following Loss
figure(1)
for q = 3:4 % for stim condition
    k = kk(q);
    Loss_history1 = [];

    if Mnk <= 2
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim    & TrialDATA.monkey == Mnk );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
         end
    elseif Mnk == 3
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim    );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  &  TrialDATA.cndLOAD == dim & TrialDATA.StimCount >= 2 );
        end
    end

    
    for t = 1:length(inds)
        outcome = TrialDATA.outcomes_isCorrect(inds(t));
        trialInBlock = TrialDATA.trialInBlock(inds(t));
        LPinblock = TrialDATA.trialsToCriterion(inds(t));
        BlockLen = TrialDATA.BlockLength(inds(t));

        %looking at Loss outcome
        if outcome == 0
            if trialInBlock == 1
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = nan;
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == 2
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == BlockLen
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:7) = nan(1,5);
            elseif trialInBlock == (BlockLen - 1)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                    Loss_history1(t,4:7) = nan(1,4);
            elseif trialInBlock == (BlockLen - 2)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                    Loss_history1(t,5:7) = nan(1,3);
            elseif trialInBlock == (BlockLen - 3)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                    Loss_history1(t,6:7) = nan(1,2);
            elseif trialInBlock == (BlockLen - 4)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                    Loss_history1(t,7) = nan;
            else
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            end
        elseif outcome == 1 
            Loss_history1(t,:) =nan(1,7);
        end
    end

    %norm = nanmean(Loss_history1_norm);
    %Y1 = Loss_history1 - norm;
    Y1 = Loss_history1;
    
    Mn1=nanmean(Y1);
    SE1=nanstd(Y1)./sqrt(length(Y1));

    lCol = ColStim2(q,:);
    figure(1)
    subplot(2,4,3)
    hold on
    for p = 1:7
        x = [p p];    
        y1 = [Mn1(p)-SE1(p) Mn1(p)+SE1(p)];
        plot(x, y1, 'color',lCol,'linewidth',2,'linestyle','-','Marker','_'); hold on;
    end
    scatter(xx ,Mn1 ,25, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
    plot(xx, Mn1, 'color',lCol,'linewidth',2,'linestyle','-'); hold on;

    patch(patchx,patchy,'r', 'EdgeColor', 'none','FaceAlpha',0.1 ,'EdgeAlpha', 0.1  ); hold on;
%         
   %ylabel('Accuracy')
   ylabel({['3D Accuracy'] ['for Trials 1:LP(ACC StimR+)']})
    
    set(gca,'tickdir','out','xlim',[0 8],'ylim',[.29 .71],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                ax = gca;

    % Set text colors to black using gca
    ax.Title.Color = 'k';       % Set title text color
    ax.XLabel.Color = 'k';      % Set x-axis label text color
    ax.YLabel.Color = 'k';      % Set y-axis label text color
    ax.XColor = 'k';            % Set x-axis tick label color
    ax.YColor = 'k';            % Set y-axis tick label color  
    xticks([1 2 3 4 5 6 7])
    xticklabels({'-2','-1','1','2','3','4','5'})
        
%         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
%         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})
        
    xlabel('Trials after Loss')
end

%After gain
figure(1)
for q = 3:4 % for stim condition - ACC only
    k = kk(q);
    Loss_history1 = [];

    if Mnk <= 2
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim    & TrialDATA.monkey == Mnk );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
         end
    elseif Mnk == 3
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim    );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  &  TrialDATA.cndLOAD == dim & TrialDATA.StimCount >= 2 );
        end
    end

    for t = 1:length(inds)
        outcome = TrialDATA.outcomes_isCorrect(inds(t));
        trialInBlock = TrialDATA.trialInBlock(inds(t));
        LPinblock = TrialDATA.trialsToCriterion(inds(t));
        BlockLen = TrialDATA.BlockLength(inds(t));

        %looking at gain outcomes
        if outcome == 1
            if trialInBlock == 1
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = nan;
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == 2
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == BlockLen
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:7) = nan(1,5);
            elseif trialInBlock == (BlockLen - 1)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                    Loss_history1(t,4:7) = nan(1,4);
            elseif trialInBlock == (BlockLen - 2)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                    Loss_history1(t,5:7) = nan(1,3);
            elseif trialInBlock == (BlockLen - 3)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                    Loss_history1(t,6:7) = nan(1,2);
            elseif trialInBlock == (BlockLen - 4)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                    Loss_history1(t,7) = nan;
            else
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            end
        elseif outcome == 0 
            Loss_history1(t,:) = nan(1,7);
        end
    end
    
     Y1 = Loss_history1;
    
    Mn1=nanmean(Y1);
    SE1=nanstd(Y1)./sqrt(length(Y1));

    lCol = ColStim2(q,:);
    figure(1)
    subplot(2,4,4)
    hold on
    for p = 1:7
        x = [p p];    
        y1 = [Mn1(p)-SE1(p) Mn1(p)+SE1(p)];
        plot(x, y1, 'color',lCol,'linewidth',2,'linestyle','-','Marker','_'); hold on;
    end
    scatter(xx ,Mn1 ,25, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
    plot(xx, Mn1, 'color',lCol,'linewidth',2,'linestyle','-'); hold on;

    patch(patchx,patchy,'g', 'EdgeColor', 'none','FaceAlpha',0.1 ,'EdgeAlpha', 0.1  ); hold on;
%         
   ylabel({['3D Accuracy'] ['for Trials 1:LP(ACC StimR+)']})

    set(gca,'tickdir','out','xlim',[0 8],'ylim',[.5 .9],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                ax = gca;

    % Set text colors to black using gca
    ax.Title.Color = 'k';       % Set title text color
    ax.XLabel.Color = 'k';      % Set x-axis label text color
    ax.YLabel.Color = 'k';      % Set y-axis label text color
    ax.XColor = 'k';            % Set x-axis tick label color
    ax.YColor = 'k';            % Set y-axis tick label color  
    xticks([1 2 3 4 5 6 7])
    xticklabels({'-2','-1','1','2','3','4','5'})
        
%         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
%         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})     
    xlabel('Trials after Gain')
end


% aSTR
Area = 2;
kk = [1,4,1,5];
dim = 3;
trl_num = 30;

ax = axes;
xx= [1,2,3,4,5,6,7];
patchx = [2.3 2.7 2.7 2.3];
patchy = [-1 -1 1 1];


%StimReinf+
% Accuracy following Loss
figure(1)
for q = 1:2 % for stim condition
    k = kk(q);
    Loss_history1 = [];

    if Mnk <= 2
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim    & TrialDATA.monkey == Mnk );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
         end
    elseif Mnk == 3
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim    );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  &  TrialDATA.cndLOAD == dim & TrialDATA.StimCount >= 2 );
        end
    end

    
    for t = 1:length(inds)
        outcome = TrialDATA.outcomes_isCorrect(inds(t));
        trialInBlock = TrialDATA.trialInBlock(inds(t));
        LPinblock = TrialDATA.trialsToCriterion(inds(t));
        BlockLen = TrialDATA.BlockLength(inds(t));

        %looking at Loss outcome
        if outcome == 0
            if trialInBlock == 1
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = nan;
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == 2
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == BlockLen
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:7) = nan(1,5);
            elseif trialInBlock == (BlockLen - 1)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                    Loss_history1(t,4:7) = nan(1,4);
            elseif trialInBlock == (BlockLen - 2)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                    Loss_history1(t,5:7) = nan(1,3);
            elseif trialInBlock == (BlockLen - 3)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                    Loss_history1(t,6:7) = nan(1,2);
            elseif trialInBlock == (BlockLen - 4)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                    Loss_history1(t,7) = nan;
            else
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            end
        elseif outcome == 1 
            Loss_history1(t,:) =nan(1,7);
        end
    end

    %norm = nanmean(Loss_history1_norm);
    %Y1 = Loss_history1 - norm;
    Y1 = Loss_history1;
    
    Mn1=nanmean(Y1);
    SE1=nanstd(Y1)./sqrt(length(Y1));

    lCol = ColStim2(q,:);
    figure(1)
    subplot(2,4,5)
    hold on
    for p = 1:7
        x = [p p];    
        y1 = [Mn1(p)-SE1(p) Mn1(p)+SE1(p)];
        plot(x, y1, 'color',lCol,'linewidth',2,'linestyle','-','Marker','_'); hold on;
    end
    scatter(xx ,Mn1 ,25, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
    plot(xx, Mn1, 'color',lCol,'linewidth',2,'linestyle','-'); hold on;

    patch(patchx,patchy,'r', 'EdgeColor', 'none','FaceAlpha',0.1 ,'EdgeAlpha', 0.1  ); hold on;
%         
   %ylabel('Accuracy')
   ylabel({['3D Accuracy'] ['for Trials 1:LP(ACC StimR+)']})
    
    set(gca,'tickdir','out','xlim',[0 8],'ylim',[.29 .71],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                ax = gca;

    % Set text colors to black using gca
    ax.Title.Color = 'k';       % Set title text color
    ax.XLabel.Color = 'k';      % Set x-axis label text color
    ax.YLabel.Color = 'k';      % Set y-axis label text color
    ax.XColor = 'k';            % Set x-axis tick label color
    ax.YColor = 'k';            % Set y-axis tick label color  
    xticks([1 2 3 4 5 6 7])
    xticklabels({'-2','-1','1','2','3','4','5'})
        
%         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
%         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})
        
    xlabel('Trials after Loss')
end

%After gain
figure(1)
for q = 1:2 % for stim condition - ACC only
    k = kk(q);
    Loss_history1 = [];

    if Mnk <= 2
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim    & TrialDATA.monkey == Mnk );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
         end
    elseif Mnk == 3
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim    );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  &  TrialDATA.cndLOAD == dim & TrialDATA.StimCount >= 2 );
        end
    end

    for t = 1:length(inds)
        outcome = TrialDATA.outcomes_isCorrect(inds(t));
        trialInBlock = TrialDATA.trialInBlock(inds(t));
        LPinblock = TrialDATA.trialsToCriterion(inds(t));
        BlockLen = TrialDATA.BlockLength(inds(t));

        %looking at gain outcomes
        if outcome == 1
            if trialInBlock == 1
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = nan;
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == 2
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == BlockLen
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:7) = nan(1,5);
            elseif trialInBlock == (BlockLen - 1)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                    Loss_history1(t,4:7) = nan(1,4);
            elseif trialInBlock == (BlockLen - 2)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                    Loss_history1(t,5:7) = nan(1,3);
            elseif trialInBlock == (BlockLen - 3)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                    Loss_history1(t,6:7) = nan(1,2);
            elseif trialInBlock == (BlockLen - 4)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                    Loss_history1(t,7) = nan;
            else
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            end
        elseif outcome == 0 
            Loss_history1(t,:) = nan(1,7);
        end
    end
    
     Y1 = Loss_history1;
    
    Mn1=nanmean(Y1);
    SE1=nanstd(Y1)./sqrt(length(Y1));

    lCol = ColStim2(q,:);
    figure(1)
    subplot(2,4,6)
    hold on
    for p = 1:7
        x = [p p];    
        y1 = [Mn1(p)-SE1(p) Mn1(p)+SE1(p)];
        plot(x, y1, 'color',lCol,'linewidth',2,'linestyle','-','Marker','_'); hold on;
    end
    scatter(xx ,Mn1 ,25, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
    plot(xx, Mn1, 'color',lCol,'linewidth',2,'linestyle','-'); hold on;

    patch(patchx,patchy,'g', 'EdgeColor', 'none','FaceAlpha',0.1 ,'EdgeAlpha', 0.1  ); hold on;
%         
   ylabel({['3D Accuracy'] ['for Trials 1:LP(ACC StimR+)']})

    set(gca,'tickdir','out','xlim',[0 8],'ylim',[.5 .9],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                ax = gca;

    % Set text colors to black using gca
    ax.Title.Color = 'k';       % Set title text color
    ax.XLabel.Color = 'k';      % Set x-axis label text color
    ax.YLabel.Color = 'k';      % Set y-axis label text color
    ax.XColor = 'k';            % Set x-axis tick label color
    ax.YColor = 'k';            % Set y-axis tick label color  
    xticks([1 2 3 4 5 6 7])
    xticklabels({'-2','-1','1','2','3','4','5'})
        
%         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
%         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})     
    xlabel('Trials after Gain')
end

%StimReinf-
% Accuracy following Loss
figure(1)
for q = 3:4 % for stim condition
    k = kk(q);
    Loss_history1 = [];

    if Mnk <= 2
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim    & TrialDATA.monkey == Mnk );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
         end
    elseif Mnk == 3
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim    );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  &  TrialDATA.cndLOAD == dim & TrialDATA.StimCount >= 2 );
        end
    end

    
    for t = 1:length(inds)
        outcome = TrialDATA.outcomes_isCorrect(inds(t));
        trialInBlock = TrialDATA.trialInBlock(inds(t));
        LPinblock = TrialDATA.trialsToCriterion(inds(t));
        BlockLen = TrialDATA.BlockLength(inds(t));

        %looking at Loss outcome
        if outcome == 0
            if trialInBlock == 1
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = nan;
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == 2
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == BlockLen
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:7) = nan(1,5);
            elseif trialInBlock == (BlockLen - 1)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                    Loss_history1(t,4:7) = nan(1,4);
            elseif trialInBlock == (BlockLen - 2)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                    Loss_history1(t,5:7) = nan(1,3);
            elseif trialInBlock == (BlockLen - 3)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                    Loss_history1(t,6:7) = nan(1,2);
            elseif trialInBlock == (BlockLen - 4)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                    Loss_history1(t,7) = nan;
            else
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            end
        elseif outcome == 1 
            Loss_history1(t,:) =nan(1,7);
        end
    end

    %norm = nanmean(Loss_history1_norm);
    %Y1 = Loss_history1 - norm;
    Y1 = Loss_history1;
    
    Mn1=nanmean(Y1);
    SE1=nanstd(Y1)./sqrt(length(Y1));

    lCol = ColStim2(q,:);
    figure(1)
    subplot(2,4,7)
    hold on
    for p = 1:7
        x = [p p];    
        y1 = [Mn1(p)-SE1(p) Mn1(p)+SE1(p)];
        plot(x, y1, 'color',lCol,'linewidth',2,'linestyle','-','Marker','_'); hold on;
    end
    scatter(xx ,Mn1 ,25, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
    plot(xx, Mn1, 'color',lCol,'linewidth',2,'linestyle','-'); hold on;

    patch(patchx,patchy,'r', 'EdgeColor', 'none','FaceAlpha',0.1 ,'EdgeAlpha', 0.1  ); hold on;
%         
   %ylabel('Accuracy')
   ylabel({['3D Accuracy'] ['for Trials 1:LP(ACC StimR+)']})
    
    set(gca,'tickdir','out','xlim',[0 8],'ylim',[.29 .71],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                ax = gca;

    % Set text colors to black using gca
    ax.Title.Color = 'k';       % Set title text color
    ax.XLabel.Color = 'k';      % Set x-axis label text color
    ax.YLabel.Color = 'k';      % Set y-axis label text color
    ax.XColor = 'k';            % Set x-axis tick label color
    ax.YColor = 'k';            % Set y-axis tick label color  
    xticks([1 2 3 4 5 6 7])
    xticklabels({'-2','-1','1','2','3','4','5'})
        
%         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
%         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})
        
    xlabel('Trials after Loss')
end

%After gain
figure(1)
for q = 3:4 % for stim condition - ACC only
    k = kk(q);
    Loss_history1 = [];

    if Mnk <= 2
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim    & TrialDATA.monkey == Mnk );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
         end
    elseif Mnk == 3
        if  q == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim    );
        elseif  q == 2 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num &  TrialDATA.cndLOAD == dim   );
        elseif  q == 3 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num&  TrialDATA.cndLOAD == dim  );
        elseif  q == 4 
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  &  TrialDATA.cndLOAD == dim & TrialDATA.StimCount >= 2 );
        end
    end

    for t = 1:length(inds)
        outcome = TrialDATA.outcomes_isCorrect(inds(t));
        trialInBlock = TrialDATA.trialInBlock(inds(t));
        LPinblock = TrialDATA.trialsToCriterion(inds(t));
        BlockLen = TrialDATA.BlockLength(inds(t));

        %looking at gain outcomes
        if outcome == 1
            if trialInBlock == 1
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = nan;
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == 2
                    Loss_history1(t,1) = nan;
                    Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                    Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            elseif trialInBlock == BlockLen
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:7) = nan(1,5);
            elseif trialInBlock == (BlockLen - 1)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                    Loss_history1(t,4:7) = nan(1,4);
            elseif trialInBlock == (BlockLen - 2)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                    Loss_history1(t,5:7) = nan(1,3);
            elseif trialInBlock == (BlockLen - 3)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                    Loss_history1(t,6:7) = nan(1,2);
            elseif trialInBlock == (BlockLen - 4)
                    Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                    Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                    Loss_history1(t,7) = nan;
            else
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
            end
        elseif outcome == 0 
            Loss_history1(t,:) = nan(1,7);
        end
    end
    
     Y1 = Loss_history1;
    
    Mn1=nanmean(Y1);
    SE1=nanstd(Y1)./sqrt(length(Y1));

    lCol = ColStim2(q,:);
    figure(1)
    subplot(2,4,8)
    hold on
    for p = 1:7
        x = [p p];    
        y1 = [Mn1(p)-SE1(p) Mn1(p)+SE1(p)];
        plot(x, y1, 'color',lCol,'linewidth',2,'linestyle','-','Marker','_'); hold on;
    end
    scatter(xx ,Mn1 ,25, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on;
    plot(xx, Mn1, 'color',lCol,'linewidth',2,'linestyle','-'); hold on;

    patch(patchx,patchy,'g', 'EdgeColor', 'none','FaceAlpha',0.1 ,'EdgeAlpha', 0.1  ); hold on;
%         
   ylabel({['3D Accuracy'] ['for Trials 1:LP(ACC StimR+)']})

    set(gca,'tickdir','out','xlim',[0 8],'ylim',[.5 .9],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                ax = gca;

    % Set text colors to black using gca
    ax.Title.Color = 'k';       % Set title text color
    ax.XLabel.Color = 'k';      % Set x-axis label text color
    ax.YLabel.Color = 'k';      % Set y-axis label text color
    ax.XColor = 'k';            % Set x-axis tick label color
    ax.YColor = 'k';            % Set y-axis tick label color  
    xticks([1 2 3 4 5 6 7])
    xticklabels({'-2','-1','1','2','3','4','5'})
        
%         yticks([0.2 0.3 0.4 0.5 0.6 0.7])
%         yticklabels({'0.2', '0.3', '0.4', '0.5', '0.6', '0.7'})     
    xlabel('Trials after Gain')
end

%% Statistical testing
clc;

%ACC
Area = 1;
trl_num = 30;
kk = [1,2,1,3];
% %Straitum
% Area = 2;
% trl_num = 30;
% kk = [1,4,1,5];

Mnk = 2;
dim = 3;

% 1st row - Accuracy following Loss
Loss = 'true'
Mnk
Loss_history1 = [];
Loss_history2 = [];
Loss_history3 = [];
Loss_history4 = [];

% Sham - Loss_history1
k = kk(1);
if Mnk <= 2
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num   & TrialDATA.monkey == Mnk);
elseif Mnk ==3
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num   );
end

for t = 1:length(inds)
    outcome = TrialDATA.outcomes_isCorrect(inds(t));
    trialInBlock = TrialDATA.trialInBlock(inds(t));
    LPinblock = TrialDATA.trialsToCriterion(inds(t));
    BlockLen = TrialDATA.BlockLength(inds(t));

    %looking at Loss outcome
    if outcome == 0
        if trialInBlock == 1
                Loss_history1(t,1) = nan;
                Loss_history1(t,2) = nan;
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == 2
                Loss_history1(t,1) = nan;
                Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == BlockLen
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = nan(1,5);
        elseif trialInBlock == (BlockLen - 1)
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                Loss_history1(t,4:7) = nan(1,4);
        elseif trialInBlock == (BlockLen - 2)
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:4) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                Loss_history1(t,5:7) = nan(1,3);
        elseif trialInBlock == (BlockLen - 3)
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                Loss_history1(t,6:7) = nan(1,2);
        elseif trialInBlock == (BlockLen - 4)
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                Loss_history1(t,7) = nan;
        else
            Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        end
    elseif outcome == 1 
        Loss_history1(t,:) =nan(1,7);
    end
end

% Sr+ Stim - Loss_history2
k = kk(2);
if Mnk <= 2
inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num & TrialDATA.monkey == Mnk );
elseif Mnk ==3
inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim    & TrialDATA.trialInBlock <= trl_num   );
end

for t = 1:length(inds)
outcome = TrialDATA.outcomes_isCorrect(inds(t));
trialInBlock = TrialDATA.trialInBlock(inds(t));
LPinblock = TrialDATA.trialsToCriterion(inds(t));
BlockLen = TrialDATA.BlockLength(inds(t));

%looking at gain outcomes
if outcome == 0
    if trialInBlock == 1
            Loss_history2(t,1) = nan;
            Loss_history2(t,2) = nan;
            Loss_history2(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
    elseif trialInBlock == 2
            Loss_history2(t,1) = nan;
            Loss_history2(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
            Loss_history2(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
    elseif trialInBlock == BlockLen
            Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history2(t,3:7) = nan(1,5);
    elseif trialInBlock == (BlockLen - 1)
            Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history2(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
            Loss_history2(t,4:7) = nan(1,4);
    elseif trialInBlock == (BlockLen - 2)
            Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history2(t,3:4) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
            Loss_history2(t,5:7) = nan(1,3);
    elseif trialInBlock == (BlockLen - 3)
            Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history2(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
            Loss_history2(t,6:7) = nan(1,2);
    elseif trialInBlock == (BlockLen - 4)
            Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history2(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
            Loss_history2(t,7) = nan;
    else
        Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
        Loss_history2(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
    end
elseif outcome == 1 
    Loss_history2(t,:) = nan(1,7);
end
end

% Sr- Stim - Loss_history3
k = kk(3);
if Mnk <= 2
inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  & TrialDATA.monkey == Mnk  );
elseif Mnk ==3
inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num   & TrialDATA.trialsToCriterion >= 2 );
end

for t = 1:length(inds)
outcome = TrialDATA.outcomes_isCorrect(inds(t));
trialInBlock = TrialDATA.trialInBlock(inds(t));
LPinblock = TrialDATA.trialsToCriterion(inds(t));
BlockLen = TrialDATA.BlockLength(inds(t));

%looking at gain outcomes
if outcome == 0
    if trialInBlock == 1
            Loss_history3(t,1) = nan;
            Loss_history3(t,2) = nan;
            Loss_history3(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
    elseif trialInBlock == 2
            Loss_history3(t,1) = nan;
            Loss_history3(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
            Loss_history3(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
    elseif trialInBlock == BlockLen
            Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history3(t,3:7) = nan(1,5);
    elseif trialInBlock == (BlockLen - 1)
            Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history3(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
            Loss_history3(t,4:7) = nan(1,4);
    elseif trialInBlock == (BlockLen - 2)
            Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history3(t,3:4) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
            Loss_history3(t,5:7) = nan(1,3);
    elseif trialInBlock == (BlockLen - 3)
            Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history3(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
            Loss_history3(t,6:7) = nan(1,2);
    elseif trialInBlock == (BlockLen - 4)
            Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history3(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
            Loss_history3(t,7) = nan;
    else
        Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
        Loss_history3(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
    end
elseif outcome == 1
    Loss_history3(t,:) = nan(1,7);
end
end

% Stim Sr-
k = kk(4);
if Mnk <= 2
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2);
elseif Mnk ==3
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim    & TrialDATA.trialInBlock <= trl_num   & TrialDATA.trialsToCriterion >= 2 );
end

for t = 1:length(inds)
    outcome = TrialDATA.outcomes_isCorrect(inds(t));
    trialInBlock = TrialDATA.trialInBlock(inds(t));
    LPinblock = TrialDATA.trialsToCriterion(inds(t));
    BlockLen = TrialDATA.BlockLength(inds(t));
    
    %looking at gain outcomes
    if outcome == 0
        if trialInBlock == 1
                Loss_history4(t,1) = nan;
                Loss_history4(t,2) = nan;
                Loss_history4(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == 2
                Loss_history4(t,1) = nan;
                Loss_history4(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                Loss_history4(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == BlockLen
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3:7) = nan(1,5);
        elseif trialInBlock == (BlockLen - 1)
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                Loss_history4(t,4:7) = nan(1,4);
        elseif trialInBlock == (BlockLen - 2)
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3:4) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                Loss_history4(t,5:7) = nan(1,3);
        elseif trialInBlock == (BlockLen - 3)
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                Loss_history4(t,6:7) = nan(1,2);
        elseif trialInBlock == (BlockLen - 4)
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                Loss_history4(t,7) = nan;
        else
            Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history4(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        end
    elseif outcome == 1
        Loss_history4(t,:) = nan(1,7);
    end
end

Y1 = Loss_history1;
Y2 = Loss_history2;
Y3 = Loss_history3;
Y4 = Loss_history4;

Mn1=nanmean(Y1);
Mn2=nanmean(Y2);
Mn3=nanmean(Y3);
Mn4=nanmean(Y4);

% Perumation testing
% Sham Sr+ vs Stim Sr+
[p1, observeddifference1, effectsize1] = runPermutationTest(Y1(:,1), Y2(:,1), 1000);
[p2, observeddifference2, effectsize2] = runPermutationTest(Y1(:,2), Y2(:,2), 1000);
[p3, observeddifference3, effectsize3] = runPermutationTest(Y1(:,3), Y2(:,3), 1000);
[p4, observeddifference4, effectsize4] = runPermutationTest(Y1(:,4), Y2(:,4), 1000);
[p5, observeddifference5, effectsize5] = runPermutationTest(Y1(:,5), Y2(:,5), 1000);
[p6, observeddifference6, effectsize6] = runPermutationTest(Y1(:,6), Y2(:,6), 1000);
[p7, observeddifference7, effectsize7] = runPermutationTest(Y1(:,7), Y2(:,7), 1000);

% Sham Sr- vs Sr- Stim
[p8, observeddifference1, effectsize1] = runPermutationTest(Y3(:,1), Y4(:,1), 1000);
[p9, observeddifference2, effectsize2] = runPermutationTest(Y3(:,2), Y4(:,2), 1000);
[p10, observeddifference3, effectsize3] = runPermutationTest(Y3(:,3), Y4(:,3), 1000);
[p11, observeddifference4, effectsize4] = runPermutationTest(Y3(:,4), Y4(:,4), 1000);
[p12, observeddifference5, effectsize5] = runPermutationTest(Y3(:,5), Y4(:,5), 1000);
[p13, observeddifference6, effectsize6] = runPermutationTest(Y3(:,6), Y4(:,6), 1000);
[p14, observeddifference7, effectsize7] = runPermutationTest(Y3(:,7), Y4(:,7), 1000);

x = [1 2 3 4 5 6 7];
pvalue_1 = [p1 p2 p3 p4 p5 p6 p7];
pvalue_2 = [p8 p9 p10 p11 p12 p13 p14];
%pvalue_3 = [p15 p16 p17 p18 p19 p20 p21];

figure(2)
subplot(2,3,1)
scatter(x, pvalue_1,'marker', 'square', 'markerfacecolor','r');hold on
scatter(x, pvalue_2,'marker', 'square', 'markerfacecolor','b');hold on
%scatter(x, pvalue_3,'marker', 'square', 'markerfacecolor','m');hold on
yline(0.05,'r')

if Mnk == 1
ylabel('pvalues')
end
xlabel('Trials after Loss')
title(Mnk_Label(Mnk))

%Sr+
Stim = 'SR+'
y1 = Y1(:,3:end);
y2 = Y2(:,3:end);

y1 = y1(~any(isnan(y1), 2), :);
y2 = y2(~any(isnan(y2), 2), :);

% Reshape y1 and y2 into column vectors
y_all = [reshape(y1', [], 1); reshape(y2', [], 1)];  % Binary outcomes (0 or 1)
x1 = repmat((1:5)', length(y1), 1);  % X values (repeated across 5 rows)
x2 = repmat((1:5)', length(y2), 1);  % X values (repeated across 5 rows)
trial = [x1;x2];
stim_cond = [ones(numel(y1), 1); 2*ones(numel(y2), 1)];

% Design matrix: Intercept, Time, Group, Time × Group Interaction
X = [ones(size(trial)), trial, stim_cond , trial.*stim_cond ]; % Interaction term

% Fit logistic regression using fitglm
mdl_SR_Pos = fitglm(X, y_all, 'linear', 'Distribution', 'binomial', 'Link', 'logit');
% Display model summary
disp(mdl_SR_Pos);


%Sr-
Stim = 'SR-'
y1 = Y3(:,3:end);
y2 = Y4(:,3:end);

y1 = y1(~any(isnan(y1), 2), :);
y2 = y2(~any(isnan(y2), 2), :);

% Reshape y1 and y2 into column vectors
y_all = [reshape(y1', [], 1); reshape(y2', [], 1)];  % Binary outcomes (0 or 1)
x1 = repmat((1:5)', length(y1), 1);  % X values (repeated across 5 rows)
x2 = repmat((1:5)', length(y2), 1);  % X values (repeated across 5 rows)
trial = [x1;x2];
stim_cond = [ones(numel(y1), 1); 2*ones(numel(y2), 1)];

% Design matrix: Intercept, Time, Group, Time × Group Interaction
X = [ones(size(trial)), trial, stim_cond , trial.*stim_cond ]; % Interaction term

% Fit logistic regression using fitglm
mdl_SR_Neg = fitglm(X, y_all, 'linear', 'Distribution', 'binomial', 'Link', 'logit');
% Display model summary
disp(mdl_SR_Neg);

%     % FDR corrected
%     p = [pvalue_1; pvalue_2; pvalue_3];
% 
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR1]=fdr_bh(p(:,1));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR2]=fdr_bh(p(:,2));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR3]=fdr_bh(p(:,3));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR4]=fdr_bh(p(:,4));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR5]=fdr_bh(p(:,5));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR6]=fdr_bh(p(:,6));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR7]=fdr_bh(p(:,7));
% 
%     cor_p = [p_corr_FDR1,p_corr_FDR2,p_corr_FDR3,p_corr_FDR4,p_corr_FDR5,p_corr_FDR6,p_corr_FDR7];
%     cor_p 
%     
%     figure(3)
%     subplot(2,3,(Mnk))
%     scatter(x, cor_p(1,:),'marker', 'square', 'markerfacecolor','r');hold on
%     scatter(x, cor_p(2,:),'marker', '<', 'markerfacecolor','b');hold on
%     scatter(x, cor_p(3,:),'marker', '>', 'markerfacecolor','m');hold on
%     yline(0.05,'r')
% 
%     if Mnk == 1
%         ylabel('FDR-pvalues')
%     end
%     xlabel('Trials after Loss')
%     title(Mnk_Label(Mnk))

%  2nd row - after gain
gain = 'true'
Loss_history1 = [];
Loss_history2 = [];
Loss_history3 = [];
Loss_history4 = [];

% Sham - Loss_history1
k = kk(1);
if Mnk <= 2
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num    & TrialDATA.monkey == Mnk);
elseif Mnk ==3
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  );
end


for t = 1:length(inds)
    outcome = TrialDATA.outcomes_isCorrect(inds(t));
    trialInBlock = TrialDATA.trialInBlock(inds(t));
    LPinblock = TrialDATA.trialsToCriterion(inds(t));
    BlockLen = TrialDATA.BlockLength(inds(t));

    %looking at gain outcomes
    if outcome == 1
        if trialInBlock == 1
                Loss_history1(t,1) = nan;
                Loss_history1(t,2) = nan;
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == 2
                Loss_history1(t,1) = nan;
                Loss_history1(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == BlockLen
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:7) = nan(1,5);
        elseif trialInBlock == (BlockLen - 1)
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                Loss_history1(t,4:7) = nan(1,4);
        elseif trialInBlock == (BlockLen - 2)
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:4) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                Loss_history1(t,5:7) = nan(1,3);
        elseif trialInBlock == (BlockLen - 3)
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                Loss_history1(t,6:7) = nan(1,2);
        elseif trialInBlock == (BlockLen - 4)
                Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history1(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                Loss_history1(t,7) = nan;
        else
            Loss_history1(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history1(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        end
    elseif outcome == 0 
        Loss_history1(t,:) = nan(1,7);
    end
end


k = kk(2);
if Mnk <= 2
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num    & TrialDATA.monkey == Mnk );
elseif Mnk ==3
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 1 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num  );
end

for t = 1:length(inds)
    outcome = TrialDATA.outcomes_isCorrect(inds(t));
    trialInBlock = TrialDATA.trialInBlock(inds(t));
    LPinblock = TrialDATA.trialsToCriterion(inds(t));
    BlockLen = TrialDATA.BlockLength(inds(t));

    %looking at gain outcomes
    if outcome == 1
        if trialInBlock == 1
                Loss_history2(t,1) = nan;
                Loss_history2(t,2) = nan;
                Loss_history2(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == 2
                Loss_history2(t,1) = nan;
                Loss_history2(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                Loss_history2(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == BlockLen
                Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history2(t,3:7) = nan(1,5);
        elseif trialInBlock == (BlockLen - 1)
                Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history2(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                Loss_history2(t,4:7) = nan(1,4);
        elseif trialInBlock == (BlockLen - 2)
                Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history2(t,3:4) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                Loss_history2(t,5:7) = nan(1,3);
        elseif trialInBlock == (BlockLen - 3)
                Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history2(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                Loss_history2(t,6:7) = nan(1,2);
        elseif trialInBlock == (BlockLen - 4)
                Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history2(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                Loss_history2(t,7) = nan;
        else
            Loss_history2(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history2(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        end
    elseif outcome == 0 
        Loss_history2(t,:) = nan(1,7);
    end
end


k = kk(3);
if Mnk <= 2
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num    & TrialDATA.monkey == Mnk );
elseif Mnk ==3
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num & TrialDATA.trialsToCriterion >= 2 );
end

for t = 1:length(inds)
    outcome = TrialDATA.outcomes_isCorrect(inds(t));
    trialInBlock = TrialDATA.trialInBlock(inds(t));
    LPinblock = TrialDATA.trialsToCriterion(inds(t));
    BlockLen = TrialDATA.BlockLength(inds(t));

    %looking at gain outcomes
    if outcome == 1
        if trialInBlock == 1
                Loss_history3(t,1) = nan;
                Loss_history3(t,2) = nan;
                Loss_history3(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == 2
                Loss_history3(t,1) = nan;
                Loss_history3(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                Loss_history3(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == BlockLen
                Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history3(t,3:7) = nan(1,5);
        elseif trialInBlock == (BlockLen - 1)
                Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history3(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                Loss_history3(t,4:7) = nan(1,4);
        elseif trialInBlock == (BlockLen - 2)
                Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history3(t,3:4) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                Loss_history3(t,5:7) = nan(1,3);
        elseif trialInBlock == (BlockLen - 3)
                Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history3(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                Loss_history3(t,6:7) = nan(1,2);
        elseif trialInBlock == (BlockLen - 4)
                Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history3(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                Loss_history3(t,7) = nan;
        else
            Loss_history3(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history3(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        end
    elseif outcome == 0 
        Loss_history3(t,:) = nan(1,7);
    end
end

k = kk(4);
if Mnk <= 2
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num   & TrialDATA.monkey == Mnk & TrialDATA.StimCount >= 2 );
elseif Mnk ==3
    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.cndLOAD == dim & TrialDATA.stimsessionType == 2 & TrialDATA.BlockNum >= BlockNum_lim   & TrialDATA.trialInBlock <= trl_num & TrialDATA.trialsToCriterion >= 2 );
end

for t = 1:length(inds)
    outcome = TrialDATA.outcomes_isCorrect(inds(t));
    trialInBlock = TrialDATA.trialInBlock(inds(t));
    LPinblock = TrialDATA.trialsToCriterion(inds(t));
    BlockLen = TrialDATA.BlockLength(inds(t));

    %looking at gain outcomes
    if outcome == 1
        if trialInBlock == 1
                Loss_history4(t,1) = nan;
                Loss_history4(t,2) = nan;
                Loss_history4(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == 2
                Loss_history4(t,1) = nan;
                Loss_history4(t,2) = TrialDATA.outcomes_isCorrect(inds(t)-1)';
                Loss_history4(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        elseif trialInBlock == BlockLen
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3:7) = nan(1,5);
        elseif trialInBlock == (BlockLen - 1)
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3) = TrialDATA.outcomes_isCorrect(inds(t)+1);
                Loss_history4(t,4:7) = nan(1,4);
        elseif trialInBlock == (BlockLen - 2)
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3:4) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+2)';
                Loss_history4(t,5:7) = nan(1,3);
        elseif trialInBlock == (BlockLen - 3)
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3:5) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+3)';
                Loss_history4(t,6:7) = nan(1,2);
        elseif trialInBlock == (BlockLen - 4)
                Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
                Loss_history4(t,3:6) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+4)';
                Loss_history4(t,7) = nan;
        else
            Loss_history4(t,1:2) = TrialDATA.outcomes_isCorrect(inds(t)-2:inds(t)-1)';
            Loss_history4(t,3:7) = TrialDATA.outcomes_isCorrect(inds(t)+1:inds(t)+5)';
        end
    elseif outcome == 0 
        Loss_history4(t,:) = nan(1,7);
    end
end

Y1 = Loss_history1;
Y2 = Loss_history2;
Y3 = Loss_history3;
Y4 = Loss_history4;

% Perumation testing
% Sham Sr+ vs Stim Sr+
[p1, observeddifference1, effectsize1] = runPermutationTest(Y1(:,1), Y2(:,1), 1000);
[p2, observeddifference2, effectsize2] = runPermutationTest(Y1(:,2), Y2(:,2), 1000);
[p3, observeddifference3, effectsize3] = runPermutationTest(Y1(:,3), Y2(:,3), 1000);
[p4, observeddifference4, effectsize4] = runPermutationTest(Y1(:,4), Y2(:,4), 1000);
[p5, observeddifference5, effectsize5] = runPermutationTest(Y1(:,5), Y2(:,5), 1000);
[p6, observeddifference6, effectsize6] = runPermutationTest(Y1(:,6), Y2(:,6), 1000);
[p7, observeddifference7, effectsize7] = runPermutationTest(Y1(:,7), Y2(:,7), 1000);

% Sham Sr- vs Sr- Stim
[p8, observeddifference1, effectsize1] = runPermutationTest(Y3(:,1), Y4(:,1), 1000);
[p9, observeddifference2, effectsize2] = runPermutationTest(Y3(:,2), Y4(:,2), 1000);
[p10, observeddifference3, effectsize3] = runPermutationTest(Y3(:,3), Y4(:,3), 1000);
[p11, observeddifference4, effectsize4] = runPermutationTest(Y3(:,4), Y4(:,4), 1000);
[p12, observeddifference5, effectsize5] = runPermutationTest(Y3(:,5), Y4(:,5), 1000);
[p13, observeddifference6, effectsize6] = runPermutationTest(Y3(:,6), Y4(:,6), 1000);
[p14, observeddifference7, effectsize7] = runPermutationTest(Y3(:,7), Y4(:,7), 1000);

x = [1 2 3 4 5 6 7];
pvalue_1 = [p1 p2 p3 p4 p5 p6 p7];
pvalue_2 = [p8 p9 p10 p11 p12 p13 p14];
%pvalue_3 = [p15 p16 p17 p18 p19 p20 p21];

figure(2)
subplot(2,3,2)
scatter(x, pvalue_1,'marker', 'square', 'markerfacecolor','r');hold on
scatter(x, pvalue_2,'marker', 'square', 'markerfacecolor','b');hold on
%scatter(x, pvalue_3,'marker', 'square', 'markerfacecolor','m');hold on
yline(0.05,'r')

if Mnk == 1
    ylabel('pvalues')
end
xlabel('Trials after Gain')
title(Mnk_Label(Mnk))


%Sr+
Stim = 'SR+'
y1 = Y1(:,3:end);
y2 = Y2(:,3:end);

y1 = y1(~any(isnan(y1), 2), :);
y2 = y2(~any(isnan(y2), 2), :);

% Reshape y1 and y2 into column vectors
y_all = [reshape(y1', [], 1); reshape(y2', [], 1)];  % Binary outcomes (0 or 1)
x1 = repmat((1:5)', length(y1), 1);  % X values (repeated across 5 rows)
x2 = repmat((1:5)', length(y2), 1);  % X values (repeated across 5 rows)
trial = [x1;x2];
stim_cond = [ones(numel(y1), 1); 2*ones(numel(y2), 1)];

% Design matrix: Intercept, Time, Group, Time × Group Interaction
X = [ones(size(trial)), trial, stim_cond , trial.*stim_cond ]; % Interaction term

% Fit logistic regression using fitglm
mdl_SR_Pos = fitglm(X, y_all, 'linear', 'Distribution', 'binomial', 'Link', 'logit');
% Display model summary
disp(mdl_SR_Pos);

%Sr-
Stim = 'SR-'
y1 = Y3(:,3:end);
y2 = Y4(:,3:end);

y1 = y1(~any(isnan(y1), 2), :);
y2 = y2(~any(isnan(y2), 2), :);

% Reshape y1 and y2 into column vectors
y_all = [reshape(y1', [], 1); reshape(y2', [], 1)];  % Binary outcomes (0 or 1)
x1 = repmat((1:5)', length(y1), 1);  % X values (repeated across 5 rows)
x2 = repmat((1:5)', length(y2), 1);  % X values (repeated across 5 rows)
trial = [x1;x2];
stim_cond = [ones(numel(y1), 1); 2*ones(numel(y2), 1)];

% Design matrix: Intercept, Time, Group, Time × Group Interaction
X = [ones(size(trial)), trial, stim_cond , trial.*stim_cond ]; % Interaction term

% Fit logistic regression using fitglm
mdl_SR_Neg = fitglm(X, y_all, 'linear', 'Distribution', 'binomial', 'Link', 'logit');
% Display model summary
disp(mdl_SR_Neg);



%     % FDR corrected
%     p = [pvalue_1; pvalue_2; pvalue_3];
% 
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR1]=fdr_bh(p(:,1));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR2]=fdr_bh(p(:,2));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR3]=fdr_bh(p(:,3));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR4]=fdr_bh(p(:,4));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR5]=fdr_bh(p(:,5));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR6]=fdr_bh(p(:,6));
%     [h, crit_p, adj_ci_cvrg, p_corr_FDR7]=fdr_bh(p(:,7));
% 
%     cor_p = [p_corr_FDR1,p_corr_FDR2,p_corr_FDR3,p_corr_FDR4,p_corr_FDR5,p_corr_FDR6,p_corr_FDR7];
%     cor_p 
%     
%     figure(3)
%     subplot(2,3,(Mnk))
%     scatter(x, cor_p(1,:),'marker', 'square', 'markerfacecolor','r');hold on
%     scatter(x, cor_p(2,:),'marker', '<', 'markerfacecolor','b');hold on
%     scatter(x, cor_p(3,:),'marker', '>', 'markerfacecolor','m');hold on
%     yline(0.05,'r')
% 
%     if Mnk == 1
%         ylabel('FDR-pvalues')
%     end
%     xlabel('Trials after Loss')
%     title(Mnk_Label(Mnk))

%% Nested functions

% Permutation Test
function [p, observeddifference, effectsize] = runPermutationTest(sample1, sample2, permutations)

    % Enforce row vectors
    if iscolumn(sample1)
        sample1 = sample1'; 
    end
    if iscolumn(sample2)
        sample2 = sample2';
    end

    % Calculate observed difference and effect size
    allobservations = [sample1, sample2];
    observeddifference = nanmean(sample1) - nanmean(sample2);
    pooledstd = sqrt(((numel(sample1)-1)*std(sample1)^2 + (numel(sample2)-1)*std(sample2)^2) / (numel(allobservations)-2));
    effectsize = observeddifference / pooledstd;

    % Permutation test
    randomdifferences = zeros(1, permutations);
    for n = 1:permutations
        permutation = randperm(length(allobservations));
        randomSample1 = allobservations(permutation(1:length(sample1)));
        randomSample2 = allobservations(permutation(length(sample1)+1:end));
        randomdifferences(n) = nanmean(randomSample1) - nanmean(randomSample2);
    end

    % Calculating p-value (two-sided)
    p = (sum(abs(randomdifferences) >= abs(observeddifference)) + 1) / (permutations + 1);
end

%%
function [p_corrected, h] = fdr_bh(p_vals, alpha)
%FDR_CORRECTION Applies Benjamini-Hochberg FDR correction to p-values.
%
%   [p_corrected, h] = fdr_correction(p_vals, alpha)
%
%   Inputs:
%       p_vals - vector of p-values (e.g., [0.01, 0.04, 0.03])
%       alpha  - significance level (e.g., 0.05)
%
%   Outputs:
%       p_corrected - FDR-adjusted p-values
%       h           - logical vector indicating whether null hypothesis is rejected

    if nargin < 2
        alpha = 0.05;
    end

    p_vals = p_vals(:); % ensure column vector
    m = length(p_vals);
    
    [sorted_p, sort_idx] = sort(p_vals);
    unsort_idx(sort_idx) = 1:m;  % to unsort later

    % Benjamini-Hochberg critical values
    bh_crit = (1:m)' * alpha / m;

    % Find which p-values are below their BH threshold
    below = sorted_p <= bh_crit;
    
    if any(below)
        max_k = find(below, 1, 'last');
        h_sorted = false(m,1);
        h_sorted(1:max_k) = true;
    else
        h_sorted = false(m,1);
    end

    % Compute adjusted p-values (Benjamini-Hochberg step-up procedure)
    p_adj = sorted_p .* m ./ (1:m)';
    p_adj = min(1, p_adj); % cap at 1
    % Ensure monotonicity
    for i = m-1:-1:1
        p_adj(i) = min(p_adj(i), p_adj(i+1));
    end

    % Return in original order
    p_corrected = p_adj(unsort_idx)';
    h = h_sorted(unsort_idx)';
end

%%
function [p_corrected, h] = bonferroni_correction(p_vals, alpha)
%BONFERRONI_CORRECTION Applies Bonferroni correction to p-values.
%
%   [p_corrected, h] = bonferroni_correction(p_vals, alpha)
%
%   Inputs:
%       p_vals - vector of p-values (e.g., [0.01, 0.04, 0.03])
%       alpha  - significance level (e.g., 0.05)
%
%   Outputs:
%       p_corrected - Bonferroni-adjusted p-values
%       h           - logical vector indicating whether null hypothesis is rejected

    if nargin < 2
        alpha = 0.05;
    end

    m = length(p_vals); % number of comparisons
    p_corrected = min(p_vals * m, 1); % cap at 1
    h = p_corrected < alpha; % reject null hypothesis if corrected p < alpha
end
