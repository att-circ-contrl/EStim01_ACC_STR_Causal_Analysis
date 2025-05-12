%% During Learning Stimulation effects - block-wise
% for overall blocks, then Gain 2, Gain 3, Loss 1, Loss 3 blocks
%%%%%%%%%%%%%% Sr+ vs Sr- conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
Col_A = [];
Col_A(1,:,:) = [0.8000    0.8000    0.8000;0.8000    0.8000    0.8000; 0.7804    0.6    0.1961];
Col_A(2,:,:) = [0.6510    0.6510    0.6510;0.6510    0.6510    0.6510; 0.7804    0.4    0.1961];
Col_A(3,:,:) = [0.5000    0.5000    0.5000;0.5000    0.5000    0.5000; 0.7804    0.2    0.1961];


mot_titles = {'Gain 2','Gain 3','Loss 1', 'Loss 3'};
ylabel_title = {'Trials-to-Criterion', 'Choice Recation time (s)','Number of fixiations', 'Plateau Performance', 'AL Choice Recation time (s)','AL Number of fixiations','Average Stim Count'};
Mnk_Label = {'Fr','Ig','Both'};
Title={'1','2','3'};
FUSCnd_Label={'ACC Sham','ACC Sr-', 'ACC Sr+', 'Sham','SReinf-','SReinf+'};
FUSCnd_Label2 = {'ACC Sham','ACC Stim','aSTR Sham','aSTR Stim'};
test_Label={'Sr-', 'Sr+'};
YLabel={'1D','2D','3D'};


ylims=[0 25; 0.2 0.75; 0.2 1.8; 0.80 1; 0.35 0.75; 0.8 1.8; 1 30]; 
Marker={'o','o','o'};
Linestyles={':','--','-'};
% behavioral variables for analysis
Vec{1}=BlockDATA.LP; % learning trial number of block
Vec{2}=BlockDATA.ExplObjduration_DL; % Duration of viewing objects during learning
Vec{3}=BlockDATA.ExplObjNum_DL; % Number of viewing objects during learning
Vec{4}=BlockDATA.Asymp; % after learning accuracy 
Vec{5}=BlockDATA.ExplObjduration_AL; % Duration of viewing objects after learning
Vec{6}=BlockDATA.ExplObjNum_AL; % Duration of viewing objects after learning
Vec{7}=BlockDATA.learnedblock; % proportional of learned blocks

BlockNum_lim = 7; % sham LPs are slightly higher 
LP_lim = 1;
mot_context = [2,3,-1,-3];
fs = 12;

overall_pp = [1 2 5 6;
              9 10 13 14;
              17 18 21 22];
mot_pp = [3 4 7 8;
          11 12 15 16;
          19 20 23 24];

figure(1)
for i = 1 % During learning effects
%for i = 4:6 % After learning effects
    for dim = 1:3
        for Mnk = 1:3 % for stim condition
            Mnk
            if Mnk <=2
                % ACC
                Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                % aSTR
                Y4=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                Y5=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                Y6=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;

                    
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));

                    Mn4 = nanmean(Y4);
                    sd4 = nanstd(Y4)/sqrt(length(Y4));
        
                    Mn5 = nanmean(Y5);
                    sd5 = nanstd(Y5)/sqrt(length(Y5));
        
                    Mn6 = nanmean(Y6);
                    sd6 = nanstd(Y6)/sqrt(length(Y6));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3 4 5 6];
                    Mn = [Mn1 Mn2 Mn3 Mn4 Mn5 Mn6]
                    error = [sd1 sd2 sd3 sd4 sd5 sd6]
        
                    subplot(2,4, overall_pp(1,:))
                    errorbar(x(1:3),Mn(1:3),error(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    errorbar(x(4:6),Mn(4:6),error(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x(1:3),Mn(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    plot(x(4:6),Mn(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
    
            elseif Mnk ==3
               % ACC
                Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                % aSTR
                Y4=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                Y5=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                Y6=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;

                    
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));

                    Mn4 = nanmean(Y4);
                    sd4 = nanstd(Y4)/sqrt(length(Y4));
        
                    Mn5 = nanmean(Y5);
                    sd5 = nanstd(Y5)/sqrt(length(Y5));
        
                    Mn6 = nanmean(Y6);
                    sd6 = nanstd(Y6)/sqrt(length(Y6));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3 4 5 6];
                    Mn = [Mn1 Mn2 Mn3 Mn4 Mn5 Mn6]
                    error = [sd1 sd2 sd3 sd4 sd5 sd6]
        
                    subplot(2,4, overall_pp(1,:))
                    errorbar(x(1:3),Mn(1:3),error(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    errorbar(x(4:6),Mn(4:6),error(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn,50,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x(1:3),Mn(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    plot(x(4:6),Mn(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
            end
            xticks([1 2 3 4 5 6])
            xtickangle(45)
            ylabel(ylabel_title(i))
            %xlabel('Stim Conditions')          
            set(gca,'xlim',[0.5 6.5],'ylim',ylims(i,:),'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 12)
        end
    end
    
    %Mot conditions
    figure(1)
    for dim = 1:3
        for mot = 1:4
            q = mot_context(mot);
            for Mnk = 1:3 % for stim condition
                if Mnk <=2
                    if mot <=2
                        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y4=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y5=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y6=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                    elseif mot >= 3
                        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y4=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y5=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y6=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                    end
                            
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));

                    Mn4 = nanmean(Y4);
                    sd4 = nanstd(Y4)/sqrt(length(Y4));
        
                    Mn5 = nanmean(Y5);
                    sd5 = nanstd(Y5)/sqrt(length(Y5));
        
                    Mn6 = nanmean(Y6);
                    sd6 = nanstd(Y6)/sqrt(length(Y6));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3 4 5 6];
                    Mn = [Mn1 Mn2 Mn3 Mn4 Mn5 Mn6]
                    error = [sd1 sd2 sd3 sd4 sd5 sd6]
        
                    subplot(2,4, mot_pp(1,mot))
                    errorbar(x(1:3),Mn(1:3),error(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    errorbar(x(4:6),Mn(4:6),error(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x(1:3),Mn(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    plot(x(4:6),Mn(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                     title(mot_titles(mot))
        
                elseif Mnk ==3
                    if mot <=2
                        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y4=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y5=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y6=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                    elseif mot >= 3
                        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y4=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y5=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y6=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                    end
                            
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));

                    Mn4 = nanmean(Y4);
                    sd4 = nanstd(Y4)/sqrt(length(Y4));
        
                    Mn5 = nanmean(Y5);
                    sd5 = nanstd(Y5)/sqrt(length(Y5));
        
                    Mn6 = nanmean(Y6);
                    sd6 = nanstd(Y6)/sqrt(length(Y6));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3 4 5 6];
                    Mn = [Mn1 Mn2 Mn3 Mn4 Mn5 Mn6]
                    error = [sd1 sd2 sd3 sd4 sd5 sd6]
            
                    subplot(2,4, mot_pp(1,mot))
                    errorbar(x(1:3),Mn(1:3),error(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    errorbar(x(4:6),Mn(4:6),error(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn,50,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x(1:3),Mn(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    plot(x(4:6),Mn(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    title(mot_titles(mot))
        
                end
                xticks([1 2 3 4 5 6])
                xtickangle(45)   
                set(gca,'xlim',[0.5 6.5],'ylim',ylims(i,:),'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 12)
            end
        end
    end
end

%% Looking at Effective sites

% % Positive Stim effect
% Effective_Sites = [12;13;18;108;113;48;49;52;56;58;60;68;71;128;129;132;137;138;140;144;145;149];
%Negetive Stim effect
Effective_Sites = [9;11;15;21;22;33;37;104;105;106;109;110;111;116;121;122;123;50;51;133;134;139;142;143;148];


%ylims=[0 45; 0.2 0.75; 0.2 1.8; 0.85 1; 0.35 0.75; 0.8 1.65]; 
Marker={'o','o','o'};
Linestyles={':','--','-'};

Vec{1}=BlockDATA.LP;
Vec{2}=BlockDATA.ExplObjduration_DL;
Vec{3}=BlockDATA.ExplObjNum_DL;
Vec{4}=BlockDATA.Asymp;
Vec{5}=BlockDATA.ExplObjduration_AL;
Vec{6}=BlockDATA.ExplObjNum_AL;

BlockNum_lim = 7; % sham LPs are slightly higher 
mot_context = [2,3,-1,-3];

overall_pp = [1 2 5 6;
              9 10 13 14;
              17 18 21 22];
mot_pp = [3 4 7 8;
          11 12 15 16;
          19 20 23 24];

figure(1)
for i = 1 % During learning effects
%for i = 4:6 % After learning effects
    for dim = 1:3
        for Mnk = 3 % for stim condition
            Mnk
            if Mnk <=2
                % ACC
                Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                % aSTR
                Y4=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                Y5=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;
                Y6=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.cndLoad == dim  ); hold on;

                    
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));

                    Mn4 = nanmean(Y4);
                    sd4 = nanstd(Y4)/sqrt(length(Y4));
        
                    Mn5 = nanmean(Y5);
                    sd5 = nanstd(Y5)/sqrt(length(Y5));
        
                    Mn6 = nanmean(Y6);
                    sd6 = nanstd(Y6)/sqrt(length(Y6));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3 4 5 6];
                    Mn = [Mn1 Mn2 Mn3 Mn4 Mn5 Mn6]
                    error = [sd1 sd2 sd3 sd4 sd5 sd6]
        
                    subplot(2,4, overall_pp(1,:))
                    errorbar(x(1:3),Mn(1:3),error(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    errorbar(x(4:6),Mn(4:6),error(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x(1:3),Mn(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    plot(x(4:6),Mn(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
    
            elseif Mnk ==3
               % ACC
                Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                % aSTR
                Y4=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                Y5=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;
                Y6=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  ); hold on;

                    
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));

                    Mn4 = nanmean(Y4);
                    sd4 = nanstd(Y4)/sqrt(length(Y4));
        
                    Mn5 = nanmean(Y5);
                    sd5 = nanstd(Y5)/sqrt(length(Y5));
        
                    Mn6 = nanmean(Y6);
                    sd6 = nanstd(Y6)/sqrt(length(Y6));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3 4 5 6];
                    Mn = [Mn1 Mn2 Mn3 Mn4 Mn5 Mn6]
                    error = [sd1 sd2 sd3 sd4 sd5 sd6]
        
                    subplot(2,4, overall_pp(1,:))
                    errorbar(x(1:3),Mn(1:3),error(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    errorbar(x(4:6),Mn(4:6),error(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn,50,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x(1:3),Mn(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    plot(x(4:6),Mn(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
            end
            xticks([1 2 3 4 5 6])
            xtickangle(45)
            ylabel(ylabel_title(i))
            xlabel('Stim Conditions')          
            set(gca,'xlim',[0.5 6.5],'ylim',ylims(i,:),'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 12)
        end
    end
    
    %Mot conditions
    figure(1)
    for dim = 1:3
        for mot = 1:4
            q = mot_context(mot);
            for Mnk = 1:3 % for stim condition
                if Mnk <=2
                    if mot <=2
                        Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y4=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y5=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==5 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y6=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==4 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                    elseif mot >= 3
                        Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y4=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y5=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==5 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y6=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==4 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                    end
                            
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));

                    Mn4 = nanmean(Y4);
                    sd4 = nanstd(Y4)/sqrt(length(Y4));
        
                    Mn5 = nanmean(Y5);
                    sd5 = nanstd(Y5)/sqrt(length(Y5));
        
                    Mn6 = nanmean(Y6);
                    sd6 = nanstd(Y6)/sqrt(length(Y6));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3 4 5 6];
                    Mn = [Mn1 Mn2 Mn3 Mn4 Mn5 Mn6]
                    error = [sd1 sd2 sd3 sd4 sd5 sd6]
        
                    subplot(2,4, mot_pp(1,mot))
                    errorbar(x(1:3),Mn(1:3),error(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    errorbar(x(4:6),Mn(4:6),error(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x(1:3),Mn(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    plot(x(4:6),Mn(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                     title(mot_titles(mot))
        
                elseif Mnk ==3
                    if mot <=2
                        Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y4=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y5=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==5 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y6=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==4 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim  ); hold on;
                    elseif mot >= 3
                        Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y4=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y5=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==5 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                        Y6=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==4 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim  ); hold on;
                    end
                            
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));

                    Mn4 = nanmean(Y4);
                    sd4 = nanstd(Y4)/sqrt(length(Y4));
        
                    Mn5 = nanmean(Y5);
                    sd5 = nanstd(Y5)/sqrt(length(Y5));
        
                    Mn6 = nanmean(Y6);
                    sd6 = nanstd(Y6)/sqrt(length(Y6));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3 4 5 6];
                    Mn = [Mn1 Mn2 Mn3 Mn4 Mn5 Mn6]
                    error = [sd1 sd2 sd3 sd4 sd5 sd6]
            
                    subplot(2,4, mot_pp(1,mot))
                    errorbar(x(1:3),Mn(1:3),error(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    errorbar(x(4:6),Mn(4:6),error(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    plot(x(1:3),Mn(1:3), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    plot(x(4:6),Mn(4:6), 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,40,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    title(mot_titles(mot))
        
                end
                xticks([1 2 3 4 5 6])
                xtickangle(45)   
                set(gca,'xlim',[0.5 6.5],'ylim',ylims(i,:),'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 12)
            end
        end
    end
end



%% Statistical testing - overall
clc;
BlockNum_lim = 7;

Area = 2; %area
i = 1 % behavioral measure
dim = 1 % dimension
num = 1 % Motivational context
Mnk = 2 % subject

% if Area == 1
%     %Both monkeys - ACC
%     if num == 1
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   );
%         Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   ); 
%         Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   );
%     % % Motivation
%     elseif num == 2
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
%         Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
%         Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
%     elseif num == 3
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
%         Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
%         Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
%     elseif num == 4
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
%         Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
%         Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
%     elseif num == 5
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
%         Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
%         Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
%     end 
% elseif Area == 2
%     %Both monkeys - aSTR
%     if num == 1
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   );
%         Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   ); 
%         Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   );
%     % % Motivation
%     elseif num == 2
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
%         Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
%         Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
%     elseif num == 3
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
%         Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
%         Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
%     elseif num == 4
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
%         Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
%         Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
%     elseif num == 5
%         Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
%         Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
%         Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea==2 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
%     end 
% end

% % indivdual monkeys
if Area == 1
    if num == 1
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk);
        Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk); 
        Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk );
    % % Motivation
    elseif num == 2
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2   & BlockDATA.monkey == Mnk);
        Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2   & BlockDATA.monkey == Mnk);
        Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2   & BlockDATA.monkey == Mnk);
    elseif num == 3
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  & BlockDATA.monkey == Mnk );
        Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3   & BlockDATA.monkey == Mnk);
        Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3   & BlockDATA.monkey == Mnk);
    elseif num == 4
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  & BlockDATA.monkey == Mnk );
        Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  & BlockDATA.monkey == Mnk );
        Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  & BlockDATA.monkey == Mnk );
    elseif num == 5
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  & BlockDATA.monkey == Mnk );
        Y2=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  & BlockDATA.monkey == Mnk );
        Y3=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  & BlockDATA.monkey == Mnk );
    end 
elseif Area == 2
%     %Both monkeys - aSTR
    if num == 1
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk);
        Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk); 
        Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk );
    % % Motivation
    elseif num == 2
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2   & BlockDATA.monkey == Mnk);
        Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2   & BlockDATA.monkey == Mnk);
        Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2   & BlockDATA.monkey == Mnk);
    elseif num == 3
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  & BlockDATA.monkey == Mnk );
        Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3   & BlockDATA.monkey == Mnk);
        Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3   & BlockDATA.monkey == Mnk);
    elseif num == 4
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  & BlockDATA.monkey == Mnk );
        Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  & BlockDATA.monkey == Mnk );
        Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  & BlockDATA.monkey == Mnk );
    elseif num == 5
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  & BlockDATA.monkey == Mnk );
        Y2=Vec{i}(BlockDATA.StimCnd5==4 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  & BlockDATA.monkey == Mnk );
        Y3=Vec{i}(BlockDATA.StimCnd5==5 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  & BlockDATA.monkey == Mnk );
    end 
    end

Y1_adj = Y1;
Y2_adj = Y2;
Y3_adj = Y3;
means = [nanmean(Y1_adj) nanmean(Y2_adj) nanmean(Y3_adj) ]
SEM = [nanstd(Y1_adj)/sqrt(length(Y1_adj)) nanstd(Y2_adj)/sqrt(length(Y2_adj)) nanstd(Y3_adj)/sqrt(length(Y3_adj))]

% P-values
[h,p1,ci] = ttest2(Y1_adj,Y2_adj);
[h,p2,ci] = ttest2(Y1_adj,Y3_adj);
[h,p3,ci] = ttest2(Y2_adj,Y3_adj);
           
p = [p1 p2 p3];

% P-value adjusted:
[h, crit_p, adj_ci_cvrg, p_corr_FDR]=fdr_bh(p, 0.05);
p_corr_FDR
% [p_corrected, h] = bonferroni_correction(p, 0.05)
% p_corrected

% %  Kruskal-Wallis Test
% Concatenation with a ; in between because these are **column** vectors
allData = [Y1; Y2; Y3]; 
groups = [ones(size(Y1)); 2*ones(size(Y2)); 3*ones(size(Y3))];
[P,ANOVATAB,STATS] = kruskalwallis(allData, groups, 'off');
P

% Anvoa 1
data = [Y1_adj; Y2_adj; Y3_adj];

% Create a group label array
groups = [repmat({'Sham'}, 1, length(Y1_adj)), ...
          repmat({'SR+'}, 1, length(Y2_adj)), ...
          repmat({'SR-'}, 1, length(Y3_adj))];

% Perform one-way ANOVA
[p, tbl, stats] = anova1(data, groups);

% Optional: run post-hoc test (e.g., Tukey's HSD)
% Run post-hoc pairwise comparisons
comparison_results = multcompare(stats, 'Display', 'off');

% Extract p-values from comparison_results
% Format: [group1, group2, lowerCI, meanDiff, upperCI, p-value]
p_values = comparison_results(:,6);

% Display pairwise comparisons and p-values
fprintf('\nPost-hoc pairwise comparisons (Tukey''s HSD):\n');
group_names = stats.gnames;
for i = 1:size(comparison_results, 1)
    g1 = group_names{comparison_results(i,1)};
    g2 = group_names{comparison_results(i,2)};
    pval = p_values(i);
    fprintf('%s vs %s: p = %.4f\n', g1, g2, pval);
end

%% For Effective sites
clc;
% Positive Stim effect
%Effective_Sites = [12;13;18;108;113;48;49;52;56;58;60;68;71;128;129;132;137;138;140;144;145;149];

% Negetive Stim effect
Effective_Sites = [9;11;15;21;22;33;37;104;105;106;109;110;111;116;121;122;123;50;51;133;134;139;142;143;148];

Area = 1
i = 1;
dim = 3
num = 1
Mnk = 1

% % Both monkeys**
% if num == 1
%     Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   );
%     Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   ); 
%     Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim   );
% % % Motivation
% elseif num == 2
%     Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
%     Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
%     Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  );
% elseif num == 3
%     Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
%     Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
%     Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  );
% elseif num == 4
%     Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
%     Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
%     Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  );
% elseif num == 5
%     Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
%     Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
%     Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea==1 & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3  );
% end 
% % indivdual monkeys
if num == 1
    Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk );
    Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk ); 
    Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.monkey == Mnk );
% % Motivation
elseif num == 2
    Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2 & BlockDATA.monkey == Mnk );
    Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  & BlockDATA.monkey == Mnk);
    Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==2  & BlockDATA.monkey == Mnk);
elseif num == 3
    Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  & BlockDATA.monkey == Mnk);
    Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  & BlockDATA.monkey == Mnk);
    Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.GainCond ==3  & BlockDATA.monkey == Mnk);
elseif num == 4
    Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1 & BlockDATA.monkey == Mnk );
    Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1 & BlockDATA.monkey == Mnk );
    Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-1  & BlockDATA.monkey == Mnk);
elseif num == 5
    Y1=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==1 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3 & BlockDATA.monkey == Mnk );
    Y2=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==2 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3 & BlockDATA.monkey == Mnk );
    Y3=Vec{i}(ismember(BlockDATA.sessionNum,Effective_Sites) & BlockDATA.StimCnd5==3 & BlockDATA.StimArea== Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim  & BlockDATA.LossCond ==-3 & BlockDATA.monkey == Mnk );
end 



Y1_adj = Y1;
Y2_adj = Y2;
Y3_adj = Y3;

%[h,p2,ci] = ttest2(Y1_adj,Y3_adj);

means = [nanmean(Y1_adj) nanmean(Y2_adj) nanmean(Y3_adj) ]
SEM = [nanstd(Y1_adj)/sqrt(length(Y1_adj)) nanstd(Y2_adj)/sqrt(length(Y2_adj)) nanstd(Y3_adj)/sqrt(length(Y3_adj))];

% P-values
[h,p1,ci] = ttest2(Y1_adj,Y2_adj);
[h,p2,ci] = ttest2(Y1_adj,Y3_adj);
[h,p3,ci] = ttest2(Y2_adj,Y3_adj);
% %             

% [p1] = ranksum(Y1_adj,Y2_adj);
% [p2] = ranksum(Y1_adj,Y3_adj);
% [p3] = ranksum(Y2_adj,Y3_adj);

p = [p1 p2 p3];

% P-value adjusted:
[h, crit_p, adj_ci_cvrg, p_corr_FDR]=fdr_bh(p);
p_corr_FDR

%% Group testing
% Both Monkeys
BlockNum_lim = 7;
Area = 1;

Metric=BlockDATA.LP(BlockDATA.StimArea==Area          & BlockDATA.BlockNum >= BlockNum_lim   );
AttLoad=BlockDATA.cndLoad(BlockDATA.StimArea==Area    & BlockDATA.BlockNum >= BlockNum_lim   );
GainCond=BlockDATA.GainCond(BlockDATA.StimArea==Area  & BlockDATA.BlockNum >= BlockNum_lim   ); 
LossCond=BlockDATA.LossCond(BlockDATA.StimArea==Area  & BlockDATA.BlockNum >= BlockNum_lim    );
StimCnd3=BlockDATA.StimCnd3(BlockDATA.StimArea==Area  & BlockDATA.BlockNum >= BlockNum_lim   );
StimCnd5=BlockDATA.StimCnd5(BlockDATA.StimArea==Area  & BlockDATA.BlockNum >= BlockNum_lim   );

% %Stim Type
% Metric=BlockDATA.LP(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim   );
% AttLoad=BlockDATA.cndLoad(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim   );
% GainCond=BlockDATA.GainCond(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim   ); 
% LossCond=BlockDATA.LossCond(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim    );
% StimCnd3=BlockDATA.StimCnd3(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim   );
% StimCnd5=BlockDATA.StimCnd5(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim   );

% % %Perform one-way ANOVA
% [p, table, stats] = anovan(Metric, {StimCnd3 }, ...
%     'varnames', {'Stim'}, ...
%     'model', 1); % model = 2 for interaction effect
% p

%Perform two-way ANOVA - all dim
[p, table, stats] = anovan(Metric, { AttLoad, GainCond, LossCond, StimCnd5 }, ...
    'varnames', {'Load', 'Gain', 'Loss', 'Stim'}, ...
    'model', 3); % model = 2 for interaction effect

%% Indivudal
Area = 2;
Mnk = 2;
stimType = 2;

% 4-way
% Metric=BlockDATA.LP(BlockDATA.StimArea==Area          & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk );
% AttLoad=BlockDATA.cndLoad(BlockDATA.StimArea==Area    & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk );
% GainCond=BlockDATA.GainCond(BlockDATA.StimArea==Area  & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk ); 
% LossCond=BlockDATA.LossCond(BlockDATA.StimArea==Area  & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk );
% StimCnd3=BlockDATA.StimCnd3(BlockDATA.StimArea==Area  & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk );
% StimCnd5=BlockDATA.StimCnd5(BlockDATA.StimArea==Area  & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.monkey == Mnk );

% %Stim Type -3D
Metric=BlockDATA.LP(BlockDATA.StimArea==Area         & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim    & BlockDATA.cndLoad == 3 & BlockDATA.monkey == Mnk);
GainCond=BlockDATA.GainCond(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim    & BlockDATA.cndLoad == 3 & BlockDATA.monkey == Mnk); 
LossCond=BlockDATA.LossCond(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim    & BlockDATA.cndLoad == 3 & BlockDATA.monkey == Mnk);
StimCnd3=BlockDATA.StimCnd3(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim    & BlockDATA.cndLoad == 3 & BlockDATA.monkey == Mnk);
StimCnd5=BlockDATA.StimCnd5(BlockDATA.StimArea==Area & BlockDATA.cndStim == stimType & BlockDATA.BlockNum >= BlockNum_lim    & BlockDATA.cndLoad == 3 & BlockDATA.monkey == Mnk);

% %Perform two-way ANOVA - all dim
% [p, table, stats] = anovan(Metric, { AttLoad, GainCond, LossCond, StimCnd5 }, ...
%     'varnames', {'Load', 'Gain', 'Loss', 'Stim'}, ...
%     'model', 2); % model = 2 for interaction effect

% %Perform two-way ANOVA - dim 3
% [p, table, stats] = anovan(Metric, { GainCond, LossCond, StimCnd5 }, ...
%     'varnames', {'Gain', 'Loss', 'Stim'}, ...
%     'model', 2); % model = 2 for interaction effect

% %Perform one-way ANOVA - dim 3
[p, table, stats] = anovan(Metric, { StimCnd3 }, ...
    'varnames', {'Stim'}, ...
    'model', 2); % model = 2 for interaction effect


