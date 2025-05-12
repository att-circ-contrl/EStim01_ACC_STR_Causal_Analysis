% Supplemental Figures - Learning Curves all and proportion of learnedblocks

% for overall blocks, then Gain 2, Gain 3, Loss 1, Loss 3 blocks

% Gaze behavioral variables for analysis
EOD=TrialDATA.durationFixationsPriorToChoice;  % Duration of viewing object
EOD(EOD>10 | EOD<0.05) = nan;
EON=TrialDATA.numFixationsPriorToChoice; % Number of viewing objects 
EON(EON>30 | EON<0) = nan;

ColStim1 = [0.5020 0.5020 0.5020;    1     0     0 ; 0.0745    0.6235    1.0000];
ColStim2 = [0.5020 0.5020 0.5020 0;    1     0     0  0; 0.0745    0.6235    1.0000 0];
Linestyles={':','--','-'};
Mnk_Label = {'Monkey F','Monkey I','Both Monkeys'};
mot_titles = {'Gain 2','Gain 3','Loss 1', 'Loss 3'};
legend_label = {'Dim 1','Dim 2','Dim 3','Sham','Sr+ Stim','Sr- Stim'};
y_label = {'Proportion Correct','Choice Reaction Time (s)','Number of Fixations'};
ylims=[0.15 1.05; 0.1 0.8; 0 2]; 

Vec{1}=TrialDATA.outcomes_isCorrect;
Vec{2}=EOD;
Vec{3}=EON;

mot_context = [2,3,-1,-3];
fs = 12; % font size

% for ACC
Area = 1
stim = [1,2,3];

%for Str
% Area = 2
% stim = [1,4,5];

i = 1;
close all
Nt=60;
X=1:60;  %Trial Numbers
y=Vec{i};

smw=([0:1:59]/40).^2;
flw=round(exp(smw));
flw=fliplr(max(flw)-flw)+1;
flw(flw > 5) = 5;

%learning curve for different Token Conditions

figure(1)
hold on;
for Mnk = 1:3
    for dim = 1:3
        for kk=1:3
            k = stim(kk);
            for it=X
                if it > 30
                    if Mnk <=2
                        if  k <= 2
                            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7 & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk );
                        else
                            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7 & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk );
                        end
                    else
                        if  k <= 2
                            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it );
                        else
                            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it );
                        end
                    end
                else
                    if Mnk <=2
                        if  k <= 2
                            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7 & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk);
                        else
                            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7 & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk);
                        end
                    else
                        if  k <= 2
                            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it);
                        else
                            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it);
                        end
                    end
                end

                %l2 = length(inds);
                 l2 = length(inds);

                if it==1
                    l1=length(inds);
                    Yout=nan(l1,Nt);
                    Ys=nan(l1,Nt);
        
                    inds_pre5 = inds-5;
                    inds_pre4 = inds-4;
                    inds_pre3 = inds-3;
                    inds_pre2 = inds-2;
                    inds_pre1 = inds-1;
        
                    Yout(1:l2,it)=y(inds_pre5);
                    Yout(1:l2,it+1)=y(inds_pre4);
                    Yout(1:l2,it+2)=y(inds_pre3);
                    Yout(1:l2,it+3)=y(inds_pre2);
                    Yout(1:l2,it+4)=y(inds_pre1);
                    Yout(1:l2,it+5)=y(inds);
                else
                    Yout(1:l2,it+5)=y(inds);
                end
            end
            
            Ys(:,1:6) = Yout(:,1:6);

            for is =7:40
               Ys(:,is)=nanmean(Yout(:,is:is+flw(is-6)),2); 
               %Ys(:,is) = movmean(Yout(:,is),2);
            end
            
            Mn=nanmean(Ys);
            SE=nanstd(Ys)./sqrt(l1);

            Mn(1:5) = movmean(Mn(1:5),3);
            
            figure(1)
            subplot(5,3,Mnk)
            plot(X(1:35),Mn(X(1:35)),'Color',ColStim1(kk,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
            shadedErrorBar(X(1:35),Mn(X(1:35)),SE(X(1:35)),{'color',ColStim2(kk,:)},1)
            set(gca,'tickdir','out','xlim',[X(1) X(35)],'ylim',[0.1 .75],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
            %plot(get(gca,'xlim'),[.7 .7],'linestyle','--','linewidth',2,'color','k')

            xticks([1 6 15 25 35])
            xticklabels({'-5','0', '10', '20', '30'})
            
             yticks([0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8])
             yticklabels({'0.2', '0.4', '0.6', '0.8', '1', '1.2', '1.4', '1.6', '1.8'})
            xlabel('Trials since block switch')
            
            if Mnk == 1
                ylabel(y_label{i});
            end

            %yline(.7,'linestyle','--','linewidth',1,'color','k')

            set(gca,'tickdir','out','xlim',[X(1) X(35)],'ylim',ylims(i,:),'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
            
        end
    end
    if Mnk ==2
        title1 = 'Overall Blocks';
        title2 = 'Monkey I';
        title({[title1] [title2]})
    else
        title(Mnk_Label{Mnk});
    end


end

% figure(1)
hold on;
for mot = 1:4
    q = mot_context(mot);
    for Mnk = 1:3
        for dim = 1:3
            for kk=1:3
                k = stim(kk);

                for it=X
                    if it > 30
                        if mot <=2
                            if Mnk <=2
                                if  k <= 2
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk & TrialDATA.GainCond == q );
                                else
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk & TrialDATA.GainCond == q );
                                end
                            else
                                if  k <= 2
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it  & TrialDATA.GainCond == q );
                                else
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it  & TrialDATA.GainCond == q );
                                end
                            end
                        elseif  mot >=3
                            if Mnk <=2
                                if  k <= 2
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk & TrialDATA.LossCond == q );
                                else
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk & TrialDATA.LossCond == q );
                                end
                            else
                                if  k <= 2
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it  & TrialDATA.LossCond == q );
                                else
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it  & TrialDATA.LossCond == q );
                                end
                            end
                        end
                    else
                        if mot <=2
                            if Mnk <=2
                                if  k <= 2
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk & TrialDATA.GainCond == q);
                                else
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk & TrialDATA.GainCond == q);
                                end
                            else
                                if  k <= 2
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it  & TrialDATA.GainCond == q);
                                else
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it  & TrialDATA.GainCond == q);
                                end
                            end
                        elseif  mot >=3
                            if Mnk <=2
                                if  k <= 2
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk & TrialDATA.LossCond == q);
                                else
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk & TrialDATA.LossCond == q);
                                end
                            else
                                if  k <= 2
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it  & TrialDATA.LossCond == q);
                                else
                                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.cndLOAD == dim  & TrialDATA.trialInBlock==it  & TrialDATA.LossCond == q);
                                end
                            end
                        end
                    end

                 l2 = length(inds);

                 if it==1
                    l1=length(inds);
                    Yout=nan(l1,Nt);
                    Ys=nan(l1,Nt);
        
                    inds_pre5= inds-5;
                    inds_pre4= inds-4;
                    inds_pre3= inds-3;
                    inds_pre2= inds-2;
                    inds_pre1= inds-1;
        
        
                    Yout(1:l2,it)=y(inds_pre5);
                    Yout(1:l2,it+1)=y(inds_pre4);
                    Yout(1:l2,it+2)=y(inds_pre3);
                    Yout(1:l2,it+3)=y(inds_pre2);
                    Yout(1:l2,it+4)=y(inds_pre1);
                    Yout(1:l2,it+5)=y(inds);
                else
                    Yout(1:l2,it+5)=y(inds);
                 end       
%                 if it==1
%                     l1=length(inds);
%                     Yout=nan(l1,Nt);
%                     Ys=nan(l1,Nt);
%                     Yout(1:l2,it)=y(inds);
%                 else
%                     Yout(1:l2,it)=y(inds);
%                 end
                end

            Ys(:,1:6) = Yout(:,1:6);

            for is =7:40
                Ys(:,is)=nanmean(Yout(:,is:is+flw(is-6)),2);
            end
            
            Mn=nanmean(Ys);
            SE=nanstd(Ys)./sqrt(l1);

            Mn(1:5) = movmean(Mn(1:5),3);
           
                figure(1)
                subplot(5,3,Mnk+3*mot)
                plot(X(1:35),Mn(X(1:35)),'Color',ColStim1(kk,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
                shadedErrorBar(X(1:35),Mn(X(1:35)),SE(X(1:35)),{'color',ColStim2(kk,:)},1)
               set(gca,'tickdir','out','xlim',[X(1) X(35)],'ylim',[0.1 0.75],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)

                xticks([1 6 15 25 35])
                xticklabels({'-5','0', '10', '20', '30'})
                
                 yticks([0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8])
                 yticklabels({'0.2', '0.4', '0.6', '0.8', '1', '1.2', '1.4', '1.6', '1.8'})
                
                xlabel('Trials since block switch')
                
                if Mnk == 1
                    ylabel(y_label{i});
                end
    
                set(gca,'tickdir','out','xlim',[X(1) X(35)],'ylim',ylims(i,:),'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
            
            end
        end
    end
end


figure(1)
subplot(5,3,5)
title('Gain 2 Blocks'); hold on ;
subplot(5,3,8)
title('Gain 3 Blocks'); hold on ;
subplot(5,3,11)
title('Loss 1 Blocks'); hold on ;
subplot(5,3,14)
title('Loss 3 Blocks'); hold on ;

%% Supplemental Figure - Proportion of Learned blocks

% Attentation Load
%%%%%%%%%%%%%% Sr+ vs Sr- stimulation conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Col_A = [];
Col_A(1,:,:) = [0.8000    0.8000    0.8000;0.8000    0.8000    0.8000; 0.7804    0.6    0.1961];
Col_A(2,:,:) = [0.6510    0.6510    0.6510;0.6510    0.6510    0.6510; 0.7804    0.4    0.1961];
Col_A(3,:,:) = [0.5000    0.5000    0.5000;0.5000    0.5000    0.5000; 0.7804    0.2    0.1961];

Marker={'o','o','o'};
Linestyles={':','--','-'};
Vec{1}=BlockDATA.LP;
Vec{2}=BlockDATA.Asymp;
Vec{3}=BlockDATA.learnedblock;

Mnk_Label = {'Fr','Ig','Both'};
Title={'1','2','3'};
FUSCnd_Label={'Sham','Sr-', 'Sr+'};
test_Label={'Sr-', 'Sr+'};
YLabel={'1D','2D','3D'};

close all
figure(1)
% grid on
% grid minor

NCond=3;
NPar=4;

i = 3;
ylims=[0.60 1.02; 0.60 1.02; 0.6 1.102]; 

BlockNum_lim = 7;
Area = 1; % ACC = 1, Str = 2
Mnk = 1;
 

figure(1); hold on;
for dim = 1:3 % for dimensions
    if Mnk <=2
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim);
        Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
        Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim); 
        Mn1 = nanmean(Y1);
        Mn2 = nanmean(Y2);
        Mn3 = nanmean(Y3);

        lCol=squeeze(Col_A(1,Mnk,:));
        x = [1 2 3];
        Mn = [Mn1 Mn2 Mn3];

        subplot(2,4, [1 2 5 6])
        plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
    else
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim);
        Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
        Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim); 
        Mn1 = nanmean(Y1);
        Mn2 = nanmean(Y2);
        Mn3 = nanmean(Y3);

        lCol=squeeze(Col_A(dim,Mnk,:));
        x = [1 2 3];
        Mn = [Mn1 Mn2 Mn3];

        subplot(2,4, [1 2 5 6])
        plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
    end

end

figure(1)
for dim = 1:3
    for Mnk = 1:3 % for stim condition
        if Mnk <=2
            Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim);
            Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
            Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim);
                
                %Mn = nanmedian(Y1);
                Mn1 = nanmean(Y1);
                sd1 = nanstd(Y1)/sqrt(length(Y1));
    
                Mn2 = nanmean(Y2);
                sd2 = nanstd(Y2)/sqrt(length(Y2));
    
                Mn3 = nanmean(Y3);
                sd3 = nanstd(Y3)/sqrt(length(Y3));
    
                lCol=squeeze(Col_A(dim,Mnk,:));
                x = [1 2 3];
                Mn = [Mn1 Mn2 Mn3];
                error = [sd1 sd2 sd3];
    
                subplot(2,4, [1 2 5 6])
                errorbar(x,Mn,error, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 

        elseif Mnk ==3
            Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim);
            Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
            Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim);
                
                %Mn = nanmedian(Y1);
                Mn1 = nanmean(Y1);
                sd1 = nanstd(Y1)/sqrt(length(Y1));
    
                Mn2 = nanmean(Y2);
                sd2 = nanstd(Y2)/sqrt(length(Y2));
    
                Mn3 = nanmean(Y3);
                sd3 = nanstd(Y3)/sqrt(length(Y3));
    
                y1  = [Mn1-sd1 Mn1+sd1];
                y2  = [Mn2-sd2 Mn2+sd2];
                y3  = [Mn3-sd3 Mn3+sd3];
                %y  = [Md-sd Md+sd];
                
                lCol=squeeze(Col_A(dim,Mnk,:));
                x = [1 2 3];
                Mn = [Mn1 Mn2 Mn3];
                xx = [1 1 2 2 3 3];
                y = [y1 y2 y3];
    
                subplot(2,4, [1 2 5 6])
                plot(x,Mn, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on; 
                errorbar(x,Mn,error, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on;
                scatter(x,Mn ,40,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 

        end

        xticks([1 2 3])
        xtickangle(45)
        ylabel({'Proportion of'; 'Learned Blocks'})
        xlabel('Stim Conditions')
        set(gca,'xlim',[0.5 3.5],'ylim',[.8 1.01],'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 18)
    end
end


% Motavation Context
%%%%%%%%%%%%%% Sr+ vs Sr- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Col_A = [];
Col_A(1,:,:) = [0.8000    0.8000    0.8000;0.8000    0.8000    0.8000; 0.7804    0.6    0.1961];
Col_A(2,:,:) = [0.6510    0.6510    0.6510;0.6510    0.6510    0.6510; 0.7804    0.4    0.1961];
Col_A(3,:,:) = [0.5000    0.5000    0.5000;0.5000    0.5000    0.5000; 0.7804    0.2    0.1961];

mot_titles = {'Gain 2','Gain 3','Loss 1', 'Loss 3'};

Marker={'o','o','o'};
Linestyles={':','--','-'};

Mnk_Label = {'Fr','Ig','Both'};
Title={'1','2','3'};
FUSCnd_Label={'Sham','Sr-', 'Sr+'};
test_Label={'Sr-', 'Sr+'};
%YLabel={'Gain 2','Gain 3','Loss 1', 'Loss 3'};

mot_context = [2,3,-1,-3];
pp = [3 4 7 8];

figure(1)
for dim = 1:3
    for mot = 1:4
        q = mot_context(mot);
        for Mnk = 1:3 % for stim condition
            if Mnk <=2
                if mot <=2
                    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
                    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim)
                elseif mot >= 3
                    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
                    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
                end
                        
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3];
                    Mn = [Mn1 Mn2 Mn3];
                    error = [sd1 sd2 sd3];
        
                    subplot(2,4,pp(mot))
                    errorbar(x,Mn,error, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    title(mot_titles(mot))
    
            elseif Mnk ==3
                if mot <=2
                    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
                    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
                elseif mot >= 3
                    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
                    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
                end
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));
        
                    y1  = [Mn1-sd1 Mn1+sd1];
                    y2  = [Mn2-sd2 Mn2+sd2];
                    y3  = [Mn3-sd3 Mn3+sd3];
                    %y  = [Md-sd Md+sd];
                    
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3];
                    Mn = [Mn1 Mn2 Mn3];
                    xx = [1 1 2 2 3 3];
                    y = [y1 y2 y3];
        
                    subplot(2,4,pp(mot))
                    plot(x,Mn, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on; 
                    errorbar(x,Mn,error, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,40,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
    
            end
            xticks([1 2 3])
            xtickangle(45)
            %ytickangle(45)
            %ylabel(YLabel{dim},"Rotation",0);
    
%             label_h = ylabel(YLabel{mot},"Rotation",0);
%             label_h.Position(1) = -0.1; % change horizontal position of ylabel.
%             label_h.Position(2) = 20; % change vertical position of ylabel.
                    
            if mot == 1 || mot == 3
                 ylabel({'Proportion of'; 'Learned Blocks'})
            end

            if mot >=3
                 xlabel('Stim Conditions')
            end

            set(gca,'xlim',[0.5 3.5],'ylim',[.6 1.01],'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 18)
        end
    end
end


%% Or plot this way
Color = [0.5020 0.5020 0.5020; 0.0745 0.6235 1.0000; 1 0 0];
legend_label = {'Monkey F','Monkey I','Both Monkeys','Sham','Sr+ Stim','Sr- Stim'};
Marker={'o','o','o'};
Linestyles={':','--','-'};

Area = 1 % ACC

figure(1)
for dim = 1:3
    Mnk = 1;
    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.cndLoad == dim & BlockDATA.monkey == Mnk);
    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2 & BlockDATA.monkey == Mnk);
    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.monkey == Mnk);
        
    %Mn = nanmedian(Y1);
    Mn1 = nanmean(Y1);
    sd1 = nanstd(Y1)/sqrt(length(Y1));

    Mn2 = nanmean(Y2);
    sd2 = nanstd(Y2)/sqrt(length(Y2));

    Mn3 = nanmean(Y3);
    sd3 = nanstd(Y3)/sqrt(length(Y3));

    y1  = [Mn1-sd1 Mn1+sd1];
    y2  = [Mn2-sd2 Mn2+sd2];
    y3  = [Mn3-sd3 Mn3+sd3];
    %y  = [Md-sd Md+sd];
    
    x_m1 = [1 2 3]+12*(dim-1);
    Mn_m1 = [Mn1 Mn2 Mn3];
    error_m1 = [sd1 sd2 sd3];

    Mnk == 2
    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.monkey == 2);
    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2 & BlockDATA.monkey == 2);
    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.monkey == 2);
        
    %Mn = nanmedian(Y1);
    Mn1 = nanmean(Y1);
    sd1 = nanstd(Y1)/sqrt(length(Y1));

    Mn2 = nanmean(Y2);
    sd2 = nanstd(Y2)/sqrt(length(Y2));

    Mn3 = nanmean(Y3);
    sd3 = nanstd(Y3)/sqrt(length(Y3));

    y1  = [Mn1-sd1 Mn1+sd1];
    y2  = [Mn2-sd2 Mn2+sd2];
    y3  = [Mn3-sd3 Mn3+sd3];
    %y  = [Md-sd Md+sd];
    
    x_m2 = [5 6 7]+12*(dim-1);
    Mn_m2 = [Mn1 Mn2 Mn3];
    error_m2 = [sd1 sd2 sd3];

    %both subjects
    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim);
    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim);
        
    %Mn = nanmedian(Y1);
    Mn1 = nanmean(Y1);
    sd1 = nanstd(Y1)/sqrt(length(Y1));

    Mn2 = nanmean(Y2);
    sd2 = nanstd(Y2)/sqrt(length(Y2));

    Mn3 = nanmean(Y3);
    sd3 = nanstd(Y3)/sqrt(length(Y3));

    y1  = [Mn1-sd1 Mn1+sd1];
    y2  = [Mn2-sd2 Mn2+sd2];
    y3  = [Mn3-sd3 Mn3+sd3];
    %y  = [Md-sd Md+sd];
    
    %lCol=squeeze(Col_A(1,dim,:));
    lCol = Color';
    x = [9 10 11]+12*(dim-1);
    Mn = [Mn1 Mn2 Mn3];
    error = [sd1 sd2 sd3];

    for p = 1:3 
        %Fr
        d = errorbar(x_m1(p),Mn_m1(p),error_m1(p), 'color',lCol(:,p),'linewidth',3,'LineStyleMode', 'manual','LineStyle',Linestyles{1}); hold on;
        d.Bar.LineStyle = 'dotted';
        %scatter(x_m1(p),Mn_m1(p) ,40,'marker', Marker{1}, 'markerfacecolor',lCol(:,p),'markeredgecolor',lCol(:,p)); hold on;
%         x = x_m1(p)-0.4;  % x-coordinate for the rectangle
%         y = 0;        % Starting y-coordinate (0)
%         width = 0.8;    % Width of the rectangle
%         height = Mn_m1(p);  % Height of the rectangle based on data

        % Create the rectangle
        rectangle('Position', [x_m1(p)-0.4, 0, 0.8, Mn_m1(p)], 'EdgeColor', lCol(:,p), 'FaceColor', lCol(:,p)); hold on;

        %Ig
        d = errorbar(x_m2(p),Mn_m2(p),error_m2(p), 'color',lCol(:,p),'linewidth',3,'LineStyleMode', 'manual','LineStyle',Linestyles{2}); hold on;
        d.Bar.LineStyle = 'dashed';
        %scatter(x_m2(p),Mn_m2(p) ,40,'marker', Marker{2}, 'markerfacecolor',lCol(:,p),'markeredgecolor',lCol(:,p)); hold on;
        rectangle('Position', [x_m2(p)-0.4, 0, 0.8, Mn_m2(p)], 'EdgeColor', lCol(:,p), 'FaceColor', lCol(:,p)); hold on;

        %Both
        errorbar(x(p),Mn(p),error(p), 'color',lCol(:,p),'linewidth',3,'LineStyleMode', 'manual','LineStyle',Linestyles{3}); hold on;
        %scatter(x(p),Mn(p) ,40,'marker', Marker{Mnk}, 'markerfacecolor',lCol(:,p),'markeredgecolor',lCol(:,p)); hold on; 
        rectangle('Position', [x(p)-0.4, 0, 0.8, Mn(p)], 'EdgeColor', lCol(:,p), 'FaceColor', lCol(:,p)); hold on;
    end
end

xticks([6 18 30])
xticklabels({'Low','Mid','High'})
%xtickangle(45)
xlabel({'Attentional Load'})
ylabel({'Proportion of'; 'Learned Blocks'})
%legend(legend_label, "Location",'southwest','NumColumns',2)
set(gca,'xlim',[0 36],'ylim',[.60 1.01],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)


%% Supplemental Figure - Plateau Performance

% Attentation Load
%%%%%%%%%%%%%% Sr+ vs Sr- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Col_A = [];
Col_A(1,:,:) = [0.8000    0.8000    0.8000;0.8000    0.8000    0.8000; 0.7804    0.6    0.1961];
Col_A(2,:,:) = [0.6510    0.6510    0.6510;0.6510    0.6510    0.6510; 0.7804    0.4    0.1961];
Col_A(3,:,:) = [0.5000    0.5000    0.5000;0.5000    0.5000    0.5000; 0.7804    0.2    0.1961];

Marker={'o','o','o'};
Linestyles={':','--','-'};
Vec{2}=BlockDATA.Asymp;

Mnk_Label = {'Fr','Ig','Both'};
Title={'1','2','3'};
FUSCnd_Label={'Sham','Sr-', 'Sr+'};
test_Label={'Sr-', 'Sr+'};
YLabel={'1D','2D','3D'};

close all

figure(1)
% grid on
% grid minor

NCond=3;
NPar=4;

i = 2;
ylims=[0.85 1; 0.85 1; 0.85 1]; 
%ylims=[0 30; 0 30; 0 30]; 

BlockNum_lim = 7;

% 
%place legend
figure(1); hold on;
dim=1;
for Mnk = 1:3 % for stim condition
    if Mnk <=2
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim);
        Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
        Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim); 
        Mn1 = nanmean(Y1);
        Mn2 = nanmean(Y2);
        Mn3 = nanmean(Y3);

        lCol=squeeze(Col_A(1,Mnk,:));
        x = [1 2 3];
        Mn = [Mn1 Mn2 Mn3];

        subplot(2,4, [1 2 5 6])
        plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
    else
        Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim);
        Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
        Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim); 
        Mn1 = nanmean(Y1);
        Mn2 = nanmean(Y2);
        Mn3 = nanmean(Y3);

        lCol=squeeze(Col_A(dim,Mnk,:));
        x = [1 2 3];
        Mn = [Mn1 Mn2 Mn3];

        subplot(2,4, [1 2 5 6])
        plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
    end
end

figure(1)
for dim = 1:3
    for Mnk = 1:3 % for stim condition
        if Mnk <=2
            Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim);
            Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
            Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim);
                
                %Mn = nanmedian(Y1);
                Mn1 = nanmean(Y1);
                sd1 = nanstd(Y1)/sqrt(length(Y1));
    
                Mn2 = nanmean(Y2);
                sd2 = nanstd(Y2)/sqrt(length(Y2));
    
                Mn3 = nanmean(Y3);
                sd3 = nanstd(Y3)/sqrt(length(Y3));
    
                lCol=squeeze(Col_A(dim,Mnk,:));
                x = [1 2 3];
                Mn = [Mn1 Mn2 Mn3];
                error = [sd1 sd2 sd3];
    
                subplot(2,4, [1 2 5 6])
                errorbar(x,Mn,error, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 

        elseif Mnk ==3
            Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim);
            Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
            Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.cndLoad == dim);
                
                %Mn = nanmedian(Y1);
                Mn1 = nanmean(Y1);
                sd1 = nanstd(Y1)/sqrt(length(Y1));
    
                Mn2 = nanmean(Y2);
                sd2 = nanstd(Y2)/sqrt(length(Y2));
    
                Mn3 = nanmean(Y3);
                sd3 = nanstd(Y3)/sqrt(length(Y3));
    
                y1  = [Mn1-sd1 Mn1+sd1];
                y2  = [Mn2-sd2 Mn2+sd2];
                y3  = [Mn3-sd3 Mn3+sd3];
                %y  = [Md-sd Md+sd];
                
                lCol=squeeze(Col_A(dim,Mnk,:));
                x = [1 2 3];
                Mn = [Mn1 Mn2 Mn3];
                xx = [1 1 2 2 3 3];
                y = [y1 y2 y3];
    
                subplot(2,4, [1 2 5 6])
                plot(x,Mn, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on; 
                errorbar(x,Mn,error, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on;
                scatter(x,Mn ,40,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 

        end
        xticks([1 2 3])
        xtickangle(45)
        %ytickangle(45)
        %ylabel(YLabel{dim},"Rotation",0);
% 
%         label_h = ylabel(YLabel{dim},"Rotation",0);
%         label_h.Position(1) = 0.1; % change horizontal position of ylabel.
%         label_h.Position(2) = 15; % change vertical position of ylabel.
                
%         if dim == 1
%             legend(Mnk_Label)
%         end
          ylabel({'Post-Learning Accuracy'})
          xlabel('Stim Conditions')
         
        set(gca,'xlim',[0.5 3.5],'ylim',[.8 1],'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 18)
    end
end



% Motavation Context
%%%%%%%%%%%%%% Sr+ vs Sr- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Col_A = [];
Col_A(1,:,:) = [0.8000    0.8000    0.8000;0.8000    0.8000    0.8000; 0.7804    0.6    0.1961];
Col_A(2,:,:) = [0.6510    0.6510    0.6510;0.6510    0.6510    0.6510; 0.7804    0.4    0.1961];
Col_A(3,:,:) = [0.5000    0.5000    0.5000;0.5000    0.5000    0.5000; 0.7804    0.2    0.1961];

mot_titles = {'Gain 2','Gain 3','Loss 1', 'Loss 3'};

Marker={'o','o','o'};
Linestyles={':','--','-'};
Vec{2}=BlockDATA.Asymp;
%Vec{7}=BlockDATA.learnedblock;

Mnk_Label = {'Fr','Ig','Both'};
Title={'1','2','3'};
FUSCnd_Label={'Sham','Sr-', 'Sr+'};
test_Label={'Sr-', 'Sr+'};
%YLabel={'Gain 2','Gain 3','Loss 1', 'Loss 3'};

NCond=2;
NPar=2;

mot_context = [2,3,-1,-3];
pp = [3 4 7 8];

figure(1)
for dim = 1:3
    for mot = 1:4
        q = mot_context(mot);
        for Mnk = 1:3 % for stim condition
            if Mnk <=2
                if mot <=2
                    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
                    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim)
                elseif mot >= 3
                    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
                    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
                end
                        
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3];
                    Mn = [Mn1 Mn2 Mn3];
                    error = [sd1 sd2 sd3];
        
                    subplot(2,4,pp(mot))
                    errorbar(x,Mn,error, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
                    title(mot_titles(mot))
    
            elseif Mnk ==3
                if mot <=2
                    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
                    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
                elseif mot >= 3
                    Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
                    Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                    Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
                end
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));
        
                    y1  = [Mn1-sd1 Mn1+sd1];
                    y2  = [Mn2-sd2 Mn2+sd2];
                    y3  = [Mn3-sd3 Mn3+sd3];
                    %y  = [Md-sd Md+sd];
                    
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1 2 3];
                    Mn = [Mn1 Mn2 Mn3];
                    xx = [1 1 2 2 3 3];
                    y = [y1 y2 y3];
        
                    subplot(2,4,pp(mot))
                    plot(x,Mn, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on; 
                    errorbar(x,Mn,error, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,40,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
    
            end
            xticks([1 2 3])
            xtickangle(45)   
            if mot == 1 || mot == 3
                 ylabel({'Post-Learning Accuracy'})
            end

            if mot >=3
                 xlabel('Stim Conditions')
            end

            set(gca,'xlim',[0.5 3.5],'ylim',[.80 1],'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 18)
        end
    end
end




%% Supplemental Figure  - Information sampling duration
% According to the write up: 4x2 subplot
ColStim1 = [0.5020 0.5020 0.5020;    1     0     0 ; 0.0745    0.6235    1.0000];
ColStim2 = [0.5020 0.5020 0.5020 0;    1     0     0  0; 0.0745    0.6235    1.0000 0];

EOD=TrialDATA.durationFixationsPriorToChoice;
EOD(EOD>1 | EOD<0.05) = nan;
EON=TrialDATA.numFixationsPriorToChoice;
EON(EON>15 | EON<0) = nan;
EODno4=TrialDATA.durationFixationsPriorToChoice_no4;
EODno4(EODno4>1 | EODno4<0.05) = nan;

Vec{1}=TrialDATA.outcomes_isCorrect;
Vec{2}=EOD;
Vec{3}=EON;
Vec{4}=EODno4;
window = 4;

y=Vec{4};
X = 1:30;
%A: Overall for Fr
figure(1)
hold on;
for k=1:3
    for it=X
        if  k == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.trialInBlock == it & TrialDATA.monkey == 1);
        else
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock == it & TrialDATA.monkey == 1);
        end
        
         l2 = length(inds);

                if it==1
                    l1=length(inds);
                    Yout=nan(l1,Nt);
                    Ys=nan(l1,Nt);
        
                    inds_pre5 = inds-5;
                    inds_pre4 = inds-4;
                    inds_pre3 = inds-3;
                    inds_pre2 = inds-2;
                    inds_pre1 = inds-1;
        
                    Yout(1:l2,it)=y(inds_pre5);
                    Yout(1:l2,it+1)=y(inds_pre4);
                    Yout(1:l2,it+2)=y(inds_pre3);
                    Yout(1:l2,it+3)=y(inds_pre2);
                    Yout(1:l2,it+4)=y(inds_pre1);
                    Yout(1:l2,it+5)=y(inds);
                else
                    Yout(1:l2,it+5)=y(inds);
                end
            end
            
            Ys(:,1:6) = Yout(:,1:6);

            for is =7:40
                Ys(:,is)=nanmean(Yout(:,is:is+flw(is-6)),2);
            end
            
            Mn=nanmean(Ys);
            SE=nanstd(Ys)./sqrt(l1);

            Mn(1:5) = movmean(Mn(1:5),3);
    subplot(4,2,1)
    plot(X,Mn(X),'Color',ColStim1(k,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
    shadedErrorBar(X,Mn(X),SE(X),{'color',ColStim2(k,:)},1)

    set(gca,'tickdir','out','xlim',[X(1) X(end)],'ylim',[.3 .6],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)
    xticks([1 6 15 25 35])
    xticklabels({'-5','0', '10', '20', '30'})
    
    yticks([0.3 0.4 0.5])
    yticklabels({'300', '400', '500'})
    
    xlabel('Trials since block switch')
    ylabel('Exploratory Sampling (s)')
    title('Monkey F - Overall')
end


%B: Overall for Ig
figure(1)
hold on;
for k=1:3
    for it=X
        if  k == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.trialInBlock == it & TrialDATA.monkey == 2);
        else
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock == it & TrialDATA.monkey == 2);
        end
        
        l2 = length(inds);

        if it==1
            l1=length(inds);
            Yout=nan(l1,Nt);
            Ys=nan(l1,Nt);

            inds_pre5= inds-5;
            inds_pre4= inds-4;
            inds_pre3= inds-3;
            inds_pre2= inds-2;
            inds_pre1= inds-1;

            Yout(1:l2,it)=y(inds_pre5);
            Yout(1:l2,it+1)=y(inds_pre4);
            Yout(1:l2,it+2)=y(inds_pre3);
            Yout(1:l2,it+3)=y(inds_pre2);
            Yout(1:l2,it+4)=y(inds_pre1);
            Yout(1:l2,it+5)=y(inds);
        else
            Yout(1:l2,it+5)=y(inds);
        end
   end
            

   %Ys(:,1:6)= Yout(:,1:6);

    
   for is=1:35
      Ys(:,is)=nanmean(Yout(:,is:is+flw(is)),2);
   end

    %Mn=nanmean(Yout);
    Mn=nanmean(Ys);
    Mn(1:5) = movmean(Mn(1:5),3);
    SE=nanstd(Ys)./sqrt(l1);
    subplot(4,2,2)
    plot(X,Mn(X),'Color',ColStim1(k,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
    shadedErrorBar(X,Mn(X),SE(X),{'color',ColStim2(k,:)},1)

    set(gca,'tickdir','out','xlim',[X(1) X(end)],'ylim',[.3 .6],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)
    xticks([1 6 15 25 35])
    xticklabels({'-5','0', '10', '20', '30'})
    
    yticks([0.3 0.4 0.5])
    yticklabels({'300', '400', '500'})
    
    xlabel('Trials since block switch')
    ylabel('Exploratory Sampling (s)')
    title('Monkey I - Overall')
end


%C: 3D for Fr
figure(1)
hold on;
for k=1:3
    for it=X
        if  k == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.trialInBlock == it & TrialDATA.monkey == 1 & TrialDATA.cndLOAD == 3);
        else
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock == it & TrialDATA.monkey == 1 & TrialDATA.cndLOAD == 3);
        end
        
        l2 = length(inds);

        if it==1
            l1=length(inds);
            Yout=nan(l1,Nt);
            Ys=nan(l1,Nt);

            inds_pre5= inds-5;
            inds_pre4= inds-4;
            inds_pre3= inds-3;
            inds_pre2= inds-2;
            inds_pre1= inds-1;

            Yout(1:l2,it)=y(inds_pre5);
            Yout(1:l2,it+1)=y(inds_pre4);
            Yout(1:l2,it+2)=y(inds_pre3);
            Yout(1:l2,it+3)=y(inds_pre2);
            Yout(1:l2,it+4)=y(inds_pre1);
            Yout(1:l2,it+5)=y(inds);
        else
            Yout(1:l2,it+5)=y(inds);
        end
   end
            

   %Ys(:,1:6)= Yout(:,1:6);

    
   for is=1:35
      Ys(:,is)=nanmean(Yout(:,is:is+flw(is)),2);
   end

    %Mn=nanmean(Yout);
    Mn=nanmean(Ys);
    Mn(1:5) = movmean(Mn(1:5),3);
    SE=nanstd(Ys)./sqrt(l1);
    subplot(4,2,3)
    plot(X,Mn(X),'Color',ColStim1(k,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
    shadedErrorBar(X,Mn(X),SE(X),{'color',ColStim2(k,:)},1)

    set(gca,'tickdir','out','xlim',[X(1) X(end)],'ylim',[.3 .6],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)
    xticks([1 6 15 25 35])
    xticklabels({'-5','0', '10', '20', '30'})
    
    yticks([0.3 0.4 0.5])
    yticklabels({'300', '400', '500'})
    
    xlabel('Trials since block switch')
    ylabel('Exploratory Sampling (s)')
    title('Monkey F - 3D Blocks')
end


%D: 3D for Ig
figure(1)
hold on;
for k=1:3
    for it=X
        if  k == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.trialInBlock == it & TrialDATA.monkey == 2 & TrialDATA.cndLOAD == 3);
        else
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock == it & TrialDATA.monkey == 2 & TrialDATA.cndLOAD == 3);
        end
        
        l2 = length(inds);

        if it==1
            l1=length(inds);
            Yout=nan(l1,Nt);
            Ys=nan(l1,Nt);

            inds_pre5= inds-5;
            inds_pre4= inds-4;
            inds_pre3= inds-3;
            inds_pre2= inds-2;
            inds_pre1= inds-1;

            Yout(1:l2,it)=y(inds_pre5);
            Yout(1:l2,it+1)=y(inds_pre4);
            Yout(1:l2,it+2)=y(inds_pre3);
            Yout(1:l2,it+3)=y(inds_pre2);
            Yout(1:l2,it+4)=y(inds_pre1);
            Yout(1:l2,it+5)=y(inds);
        else
            Yout(1:l2,it+5)=y(inds);
        end
   end
            

   %Ys(:,1:6)= Yout(:,1:6);

    
   for is=1:35
      Ys(:,is)=nanmean(Yout(:,is:is+flw(is)),2);
   end

    %Mn=nanmean(Yout);
    Mn=nanmean(Ys);
    Mn(1:5) = movmean(Mn(1:5),3);
    SE=nanstd(Ys)./sqrt(l1);
    subplot(4,2,4)
    plot(X,Mn(X),'Color',ColStim1(k,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
    shadedErrorBar(X,Mn(X),SE(X),{'color',ColStim2(k,:)},1)

    set(gca,'tickdir','out','xlim',[X(1) X(end)],'ylim',[.3 .6],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)
    xticks([1 6 15 25 35])
    xticklabels({'-5','0', '10', '20', '30'})
    
    yticks([0.3 0.4 0.5])
    yticklabels({'300', '400', '500'})
    
    xlabel('Trials since block switch')
    ylabel('Exploratory Sampling (s)')
    title('Monkey I - 3D Blocks')
end


%E: G2 for Fr
figure(1)
hold on;
for k=1:3
    for it=X
        if  k == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.trialInBlock == it & TrialDATA.monkey == 1 & TrialDATA.GainCond == 2);
        else
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock == it & TrialDATA.monkey == 1 & TrialDATA.GainCond == 2);
        end
        
        l2 = length(inds);

        if it==1
            l1=length(inds);
            Yout=nan(l1,Nt);
            Ys=nan(l1,Nt);

            inds_pre5= inds-5;
            inds_pre4= inds-4;
            inds_pre3= inds-3;
            inds_pre2= inds-2;
            inds_pre1= inds-1;

            Yout(1:l2,it)=y(inds_pre5);
            Yout(1:l2,it+1)=y(inds_pre4);
            Yout(1:l2,it+2)=y(inds_pre3);
            Yout(1:l2,it+3)=y(inds_pre2);
            Yout(1:l2,it+4)=y(inds_pre1);
            Yout(1:l2,it+5)=y(inds);
        else
            Yout(1:l2,it+5)=y(inds);
        end
   end

   for is=1:35
      Ys(:,is)=nanmean(Yout(:,is:is+flw(is)),2);
   end

    %Mn=nanmean(Yout);
    Mn=nanmean(Ys);
    Mn(1:5) = movmean(Mn(1:5),3);
    SE=nanstd(Ys)./sqrt(l1);
    subplot(4,2,5)
    plot(X,Mn(X),'Color',ColStim1(k,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
    shadedErrorBar(X,Mn(X),SE(X),{'color',ColStim2(k,:)},1)

    set(gca,'tickdir','out','xlim',[X(1) X(end)],'ylim',[.3 .6],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)
    xticks([1 6 15 25 35])
    xticklabels({'-5','0', '10', '20', '30'})
    
    yticks([0.3 0.4 0.5])
    yticklabels({'300', '400', '500'})
    
    xlabel('Trials since block switch')
    ylabel('Exploratory Sampling (s)')
    title('Monkey F - Gain 2 Blocks')
end


%F: G2 for Ig
figure(1)
hold on;
for k=1:3
    for it=X
        if  k == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.trialInBlock == it & TrialDATA.monkey == 2 & TrialDATA.GainCond == 2);
        else
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock == it & TrialDATA.monkey == 2 & TrialDATA.GainCond == 2);
        end
        
        l2 = length(inds);

        if it==1
            l1=length(inds);
            Yout=nan(l1,Nt);
            Ys=nan(l1,Nt);

            inds_pre5= inds-5;
            inds_pre4= inds-4;
            inds_pre3= inds-3;
            inds_pre2= inds-2;
            inds_pre1= inds-1;

            Yout(1:l2,it)=y(inds_pre5);
            Yout(1:l2,it+1)=y(inds_pre4);
            Yout(1:l2,it+2)=y(inds_pre3);
            Yout(1:l2,it+3)=y(inds_pre2);
            Yout(1:l2,it+4)=y(inds_pre1);
            Yout(1:l2,it+5)=y(inds);
        else
            Yout(1:l2,it+5)=y(inds);
        end
   end
            

   %Ys(:,1:6)= Yout(:,1:6);

    
   for is=1:35
      Ys(:,is)=nanmean(Yout(:,is:is+flw(is)),2);
   end

    %Mn=nanmean(Yout);
    Mn=nanmean(Ys);
    Mn(1:5) = movmean(Mn(1:5),3);
    SE=nanstd(Ys)./sqrt(l1);
    subplot(4,2,6)
    plot(X,Mn(X),'Color',ColStim1(k,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
    shadedErrorBar(X,Mn(X),SE(X),{'color',ColStim2(k,:)},1)

    set(gca,'tickdir','out','xlim',[X(1) X(end)],'ylim',[.3 .6],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)
    xticks([1 6 15 25 35])
    xticklabels({'-5','0', '10', '20', '30'})
    
    yticks([0.3 0.4 0.5])
    yticklabels({'300', '400', '500'})
    
    xlabel('Trials since block switch')
    ylabel('Exploratory Sampling (s)')
    title('Monkey I - Gain 2 Blocks')
end


%G: L3 for Fr
figure(1)
hold on;
for k=1:3
    for it=X
        if  k == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.trialInBlock == it & TrialDATA.monkey == 1 & TrialDATA.LossCond == -3);
        else
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock == it & TrialDATA.monkey == 1 & TrialDATA.LossCond == -3);
        end
        
        l2 = length(inds);

        if it==1
            l1=length(inds);
            Yout=nan(l1,Nt);
            Ys=nan(l1,Nt);

            inds_pre5= inds-5;
            inds_pre4= inds-4;
            inds_pre3= inds-3;
            inds_pre2= inds-2;
            inds_pre1= inds-1;

            Yout(1:l2,it)=y(inds_pre5);
            Yout(1:l2,it+1)=y(inds_pre4);
            Yout(1:l2,it+2)=y(inds_pre3);
            Yout(1:l2,it+3)=y(inds_pre2);
            Yout(1:l2,it+4)=y(inds_pre1);
            Yout(1:l2,it+5)=y(inds);
        else
            Yout(1:l2,it+5)=y(inds);
        end
   end
            

   %Ys(:,1:6)= Yout(:,1:6);

    
   for is=1:35
      Ys(:,is)=nanmean(Yout(:,is:is+flw(is)),2);
   end

    %Mn=nanmean(Yout);
    Mn=nanmean(Ys);
    Mn(1:5) = movmean(Mn(1:5),3);
    SE=nanstd(Ys)./sqrt(l1);
    subplot(4,2,7)
    plot(X,Mn(X),'Color',ColStim1(k,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
    shadedErrorBar(X,Mn(X),SE(X),{'color',ColStim2(k,:)},1)

    set(gca,'tickdir','out','xlim',[X(1) X(end)],'ylim',[.3 .6],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)
    xticks([1 6 15 25 35])
    xticklabels({'-5','0', '10', '20', '30'})
    
    yticks([0.3 0.4 0.5])
    yticklabels({'300', '400', '500'})
    
    xlabel('Trials since block switch')
    ylabel('Exploratory Sampling (s)')
    title('Monkey F - Loss 3 Blocks')
end


%H: L3 for Ig
figure(1)
hold on;
for k=1:3
    for it=X
        if  k == 1
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.trialInBlock == it & TrialDATA.monkey == 2 & TrialDATA.LossCond == -3);
        else
            inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd5==k & TrialDATA.BlockNum >= 7  & TrialDATA.StimCount >= 2 & TrialDATA.trialInBlock == it & TrialDATA.monkey == 2 & TrialDATA.LossCond == -3);
        end
        
        l2 = length(inds);

        if it==1
            l1=length(inds);
            Yout=nan(l1,Nt);
            Ys=nan(l1,Nt);

            inds_pre5= inds-5;
            inds_pre4= inds-4;
            inds_pre3= inds-3;
            inds_pre2= inds-2;
            inds_pre1= inds-1;

            Yout(1:l2,it)=y(inds_pre5);
            Yout(1:l2,it+1)=y(inds_pre4);
            Yout(1:l2,it+2)=y(inds_pre3);
            Yout(1:l2,it+3)=y(inds_pre2);
            Yout(1:l2,it+4)=y(inds_pre1);
            Yout(1:l2,it+5)=y(inds);
        else
            Yout(1:l2,it+5)=y(inds);
        end
   end
            

   %Ys(:,1:6)= Yout(:,1:6);

    
   for is=1:35
      Ys(:,is)=nanmean(Yout(:,is:is+flw(is)),2);
   end

    %Mn=nanmean(Yout);
    Mn=nanmean(Ys);
    Mn(1:5) = movmean(Mn(1:5),3);
    SE=nanstd(Ys)./sqrt(l1);
    subplot(4,2,8)
    plot(X,Mn(X),'Color',ColStim1(k,:),'linewidth',2,'linestyle',Linestyles(dim));hold on;
    shadedErrorBar(X,Mn(X),SE(X),{'color',ColStim2(k,:)},1)

    set(gca,'tickdir','out','xlim',[X(1) X(end)],'ylim',[.3 .6],'box', 'off','fontname','Helvetica Neue', 'FontSize', fs)
    xticks([1 6 15 25 35])
    xticklabels({'-5','0', '10', '20', '30'})
    
    yticks([0.3 0.4 0.5])
    yticklabels({'300', '400', '500'})
    
    xlabel('Trials since block switch')
    ylabel('Exploratory Sampling (s)')
    title('Monkey I - Loss 3 Blocks')
end



%%  Supplemental Figure  - Session temporal analysi: LPs at 1/3 periods
clf;

%%%%%%%%%%%%%% Sr+ vs Sr- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Col_A = [];
Col_A(1,:,:) = [0.8000    0.8000    0.8000;0.8000    0.8000    0.8000; 0.7804    0.6    0.1961];
Col_A(2,:,:) = [0.6510    0.6510    0.6510;0.6510    0.6510    0.6510; 0.7804    0.4    0.1961];
Col_A(3,:,:) = [0.5000    0.5000    0.5000;0.5000    0.5000    0.5000; 0.7804    0.2    0.1961];


%ylims=[0.8 1; 0.8 1; 0.8 1]; 
ylims=[0 30; 0 30; 0 30]; 
Marker={'o','o','o'};
Linestyles={':','--','-'};
Vec{1}=BlockDATA.LP;
% Vec{2}=BlockDATA.Asymp;
% %Vec{3}=Rt;
% Vec{4}=EOD;
% Vec{5}=EON;
% Vec{6}=BlockDATA.Accuracy;
% Vec{7}=BlockDATA.learnedblock;
mot_context = [2,3,-1,-3];

mot_titles = {'Gain 2','Gain 3','Loss 1', 'Loss 3'};
Mnk_Label = {'Fr','Ig','Both'};
Title={'1','2','3'};
FUSCnd_Label={'Sham','Sr-', 'Sr+'};
test_Label={'Sr-', 'Sr+'};
YLabel={'1D','2D','3D'};

close all

figure(1)
% grid on
% grid minor

NCond=3;
NPar=4;

i = 1;
BlockNum_lim = 6;
LP_lim = 1;
pp = [3 4 7 8];

% block window
ses_pos = [7 16
           17 26
           27 36];

figure(1)
for sess_window = 1:3
    for dim = 1:3
        for Mnk = 1:3 % for stim condition
            if Mnk <=2
                Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= ses_pos(sess_window,1) & BlockDATA.BlockNum <= ses_pos(sess_window,2) & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim);
                Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= ses_pos(sess_window,1) & BlockDATA.BlockNum <= ses_pos(sess_window,2) & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= ses_pos(sess_window,1) & BlockDATA.BlockNum <= ses_pos(sess_window,2) & BlockDATA.monkey == Mnk  & BlockDATA.cndLoad == dim);
                    
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));
        
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1+(0.1*sess_window) 2+(0.1*sess_window) 3+(0.1*sess_window)];
                    Mn = [Mn1 Mn2 Mn3];
                    error = [sd1 sd2 sd3];
        
                    %subplot(2,4, [1 2 5 6])
                    errorbar(x,Mn,error, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
                    plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
    
            elseif Mnk ==3
                Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= ses_pos(sess_window,1) & BlockDATA.BlockNum <= ses_pos(sess_window,2)  & BlockDATA.cndLoad == dim);
                Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= ses_pos(sess_window,1) & BlockDATA.BlockNum <= ses_pos(sess_window,2)  & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
                Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= ses_pos(sess_window,1) & BlockDATA.BlockNum <= ses_pos(sess_window,2)  & BlockDATA.cndLoad == dim);
                    
                    %Mn = nanmedian(Y1);
                    Mn1 = nanmean(Y1);
                    sd1 = nanstd(Y1)/sqrt(length(Y1));
        
                    Mn2 = nanmean(Y2);
                    sd2 = nanstd(Y2)/sqrt(length(Y2));
        
                    Mn3 = nanmean(Y3);
                    sd3 = nanstd(Y3)/sqrt(length(Y3));
        
                    y1  = [Mn1-sd1 Mn1+sd1];
                    y2  = [Mn2-sd2 Mn2+sd2];
                    y3  = [Mn3-sd3 Mn3+sd3];
                    %y  = [Md-sd Md+sd];
                    
                    lCol=squeeze(Col_A(dim,Mnk,:));
                    x = [1+(0.1*sess_window) 2+(0.1*sess_window) 3+(0.1*sess_window)];
                    Mn = [Mn1 Mn2 Mn3];
                    xx = [1+(0.1*sess_window) 1+(0.1*sess_window) 2+(0.1*sess_window)  2+(0.1*sess_window)  3+(0.1*sess_window)  3+(0.1*sess_window)];
                    y = [y1 y2 y3];
        
                    %subplot(2,4, [1 2 5 6])
                    plot(x,Mn, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on; 
                    errorbar(x,Mn,error, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on;
                    scatter(x,Mn ,40,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
    
            end
            xticks([1.2 2.2 3.2])
            xtickangle(45)
              ylabel('Trials-to-Criterion')
              xlabel('Stim Conditions')
             
            set(gca,'xlim',[0.7 3.7],'ylim',ylims(dim,:),'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 18)
        end
    end
end
% 
% %Mot conditions
% figure(1)
% for dim = 1:3
%     for mot = 1:4
%         q = mot_context(mot);
%         for Mnk = 1:3 % for stim condition
%             if Mnk <=2
%                 if mot <=2
%                     Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
%                     Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
%                     Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim)
%                 elseif mot >= 3
%                     Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
%                     Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
%                     Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim & BlockDATA.monkey == Mnk  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
%                 end
%                         
%                     %Mn = nanmedian(Y1);
%                     Mn1 = nanmean(Y1);
%                     sd1 = nanstd(Y1)/sqrt(length(Y1));
%         
%                     Mn2 = nanmean(Y2);
%                     sd2 = nanstd(Y2)/sqrt(length(Y2));
%         
%                     Mn3 = nanmean(Y3);
%                     sd3 = nanstd(Y3)/sqrt(length(Y3));
%         
%                     lCol=squeeze(Col_A(dim,Mnk,:));
%                     x = [1 2 3];
%                     Mn = [Mn1 Mn2 Mn3];
%                     error = [sd1 sd2 sd3];
%         
%                     subplot(2,4,pp(mot))
%                     errorbar(x,Mn,error, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on;
%                     scatter(x,Mn ,30,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
%                     plot(x,Mn, 'color',lCol,'linewidth',2,'linestyle',Linestyles{Mnk}); hold on; 
%                     title(mot_titles(mot))
%     
%             elseif Mnk ==3
%                 if mot <=2
%                     Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
%                     Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
%                     Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.GainCond == q & BlockDATA.cndLoad == dim);
%                 elseif mot >= 3
%                     Y1=Vec{i}(BlockDATA.StimCnd5==1 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
%                     Y2=Vec{i}(BlockDATA.StimCnd5==3 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim & BlockDATA.StimCount >= 2);
%                     Y3=Vec{i}(BlockDATA.StimCnd5==2 & BlockDATA.StimArea==Area & BlockDATA.BlockNum >= BlockNum_lim  & BlockDATA.LossCond == q & BlockDATA.cndLoad == dim);
%                 end
%                     %Mn = nanmedian(Y1);
%                     Mn1 = nanmean(Y1);
%                     sd1 = nanstd(Y1)/sqrt(length(Y1));
%         
%                     Mn2 = nanmean(Y2);
%                     sd2 = nanstd(Y2)/sqrt(length(Y2));
%         
%                     Mn3 = nanmean(Y3);
%                     sd3 = nanstd(Y3)/sqrt(length(Y3));
%         
%                     y1  = [Mn1-sd1 Mn1+sd1];
%                     y2  = [Mn2-sd2 Mn2+sd2];
%                     y3  = [Mn3-sd3 Mn3+sd3];
%                     %y  = [Md-sd Md+sd];
%                     
%                     lCol=squeeze(Col_A(dim,Mnk,:));
%                     x = [1 2 3];
%                     Mn = [Mn1 Mn2 Mn3];
%                     xx = [1 1 2 2 3 3];
%                     y = [y1 y2 y3];
%         
%                     subplot(2,4,pp(mot))
%                     plot(x,Mn, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on; 
%                     errorbar(x,Mn,error, 'color',lCol,'linewidth',3,'linestyle',Linestyles{Mnk}); hold on;
%                     scatter(x,Mn ,40,'marker', Marker{Mnk}, 'markerfacecolor',lCol,'markeredgecolor',lCol); hold on; 
%     
%             end
%             xticks([1 2 3])
%             xtickangle(45)
%             %ytickangle(45)
%             %ylabel(YLabel{dim},"Rotation",0);
%     
% %             label_h = ylabel(YLabel{mot},"Rotation",0);
% %             label_h.Position(1) = -0.1; % change horizontal position of ylabel.
% %             label_h.Position(2) = 20; % change vertical position of ylabel.
%                     
%             if mot == 1 || mot == 3
%                  ylabel('Trials-to-Criterion')
%             end
% 
%             if mot >=3
%                  xlabel('Stim Conditions')
%             end
% 
%             set(gca,'xlim',[0.5 3.5],'ylim',[0 32],'xticklabels',FUSCnd_Label,'tickdir','out','box', 'off','fontname','Helvetica Neue', 'FontSize', 18)
%         end
%     end
% end



