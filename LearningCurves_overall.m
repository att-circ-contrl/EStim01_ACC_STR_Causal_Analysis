% Main behavioral data analysis for stimulation effects script - Learning Curves

% Gaze behavioral variables for analysis
EOD=TrialDATA.durationFixationsPriorToChoice;  % Duration of viewing object
EOD(EOD>10 | EOD<0.05) = nan;
EON=TrialDATA.numFixationsPriorToChoice; % Number of viewing objects 
EON(EON>30 | EON<0) = nan;

ColStim = [0.5020 0.5020 0.5020;     0.9294    0.4549    0.4549];  % ACC
%ColStim = [0.5020 0.5020 0.5020;      0.3216    0.8196    0.2863]; % aSTR
Linestyles={':','--','-'};
Mnk_Label = {'Monkey F','Monkey I','Both Monkeys'};
mot_titles = {'Gain 2','Gain 3','Loss 1', 'Loss 3'};
legend_label = {'Dim 1','Dim 2','Dim 3','Sham','Sr+ Stim','Sr- Stim'};

Vec{1}=TrialDATA.outcomes_isCorrect; % trial accuracy 
Vec{2}=EOD;
Vec{3}=EON;

mot_context = [2,3,-1,-3]; % Motivational context (Gain/Loss)
fs = 12; % font size

close all
Nt=60;
X=1:60;  %Trial Numbers

% forward looking window
smw=([0:1:59]/40).^2;
flw=round(exp(smw));
flw=fliplr(max(flw)-flw)+1;
flw(flw > 5) = 5;

%learning curve stimulation and sham at 1D,2D,3D for the ACC
Area = 1; % ACC = 1, Str = 2
stim = [1,2];
ylabel_title = {'Proportion Correct','Duration of fixiations','Number of fixiations'};
ylims=[0.2 1.1; 0.2 2; 0.2 2]; 

points =[];
hold on;

y=Vec{1};
for Mnk = 1:2
    for d = 1:3
        dim = d;
        for kk=1:2
            k = stim(kk);
            for it=X
                if Mnk <=2
                    inds=find(TrialDATA.StimArea == 1 & TrialDATA.StimCnd3==k & TrialDATA.BlockNum >= 7 & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk );
                else
                    inds=find(TrialDATA.StimArea == 1 & TrialDATA.StimCnd3==k & TrialDATA.BlockNum >= 7 & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it);
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

            for is =7:50
                Ys(:,is)=nanmean(Yout(:,is:is+flw(is-6)),2); 
               %Ys(:,is) = movmean(Yout(:,is),5);
            end
            
            Mn=nanmean(Ys);
            SE=nanstd(Ys)./sqrt(l1);

            Mn(1:5) = movmean(Mn(1:5),3);

            %find when it passed the 70% line
            if i == 1
                point = [find(Mn(7:50) > 0.70, 1, 'first') + 6];
                points(d,kk,Mnk) = point-6;
            end
            
            figure(1)
            subplot(1,4,Mnk)
            %subplot(5,3,Mnk)
            plot(X(1:35),Mn(X(1:35)),'Color',ColStim(kk,:),'linewidth',1.5,'linestyle',Linestyles(dim));hold on;
            shadedErrorBar(X(1:35),Mn(X(1:35)),SE(X(1:35)),{'color',ColStim(kk,:)},1)
   
            set(gca,'tickdir','out','xlim',[X(1) X(35)],'ylim',ylims(i,:),'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
            %plot(get(gca,'xlim'),[.7 .7],'linestyle','--','linewidth',2,'color','k')

            xticks([1 6 15 25 35])
            xticklabels({'-5','0', '10', '20', '30'})
            
            xlabel('Trials since block switch')
            
            if Mnk == 1
                ylabel(ylabel_title(i))
            end

            if i == 1
                yticks([0.2 0.4 0.6 0.8 1])
                yticklabels({'0.2', '0.4', '0.6', '0.8', '1'})
                yline(.7,'linestyle','--','linewidth',1,'color','k')
            end
            
            %add delta lines
            if i == 1
                if dim == 1
                    plot([point; point], [0.7; 1.1],'Color',ColStim(kk,:),'linewidth',2,'linestyle','--'); hold on;
                elseif dim == 3
                    plot([point; point], [0; 0.7],'Color',ColStim(kk,:),'linewidth',2,'linestyle','--'); hold on;
                end
            end           
            %set(gca,'tickdir','out','xlim',[X(1) X(35)],'ylim',[.15 1.05],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)                
        end
    end
    
    if i == 1
        title(Mnk_Label{Mnk});
    end
end


%learning curve stimulation and sham at 1D,2D,3D for the Str
ColStim = [0.5020 0.5020 0.5020;      0.3216    0.8196    0.2863]; % aSTR
Area = 2; % ACC = 1, Str = 2
stim = [1,3];
ylabel_title = {'Proportion Correct','Number of fixiations'};
ylims=[0.2 1.1; 0.2 2]; 

points =[];
hold on;
for Mnk = 1:2
    for d = 1:3
        dim = d;
        for kk = 1:2
            k = stim(kk);
            for it=X
                if Mnk <=2
                    inds=find(TrialDATA.StimArea == Area & TrialDATA.StimCnd3==k & TrialDATA.BlockNum >= 7 & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it & TrialDATA.monkey == Mnk );
                    else
                        inds=find(TrialDATA.StimArea ==Area & TrialDATA.StimCnd3==k & TrialDATA.BlockNum >= 7 & TrialDATA.cndLOAD == dim & TrialDATA.trialInBlock==it);
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
    
                for is =7:50
                    Ys(:,is)=nanmean(Yout(:,is:is+flw(is-6)),2); 
                   %Ys(:,is) = movmean(Yout(:,is),5);
                end
                
                Mn=nanmean(Ys);
                SE=nanstd(Ys)./sqrt(l1);
    
                Mn(1:5) = movmean(Mn(1:5),3);

                %find when it passed the 70% line
                if i == 1
                    point = [find(Mn(7:50) > 0.70, 1, 'first') + 6];
                    points(d,kk,Mnk) = point-6;
                end
                
                figure(1)
                subplot(1,4,Mnk+2)
                %subplot(5,3,Mnk)
                plot(X(1:35),Mn(X(1:35)),'Color',ColStim(kk,:),'linewidth',1.5,'linestyle',Linestyles(dim));hold on;
                shadedErrorBar(X(1:35),Mn(X(1:35)),SE(X(1:35)),{'color',ColStim(kk,:)},1)
       
                set(gca,'tickdir','out','xlim',[X(1) X(35)],'ylim',ylims(i,:),'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)
                %plot(get(gca,'xlim'),[.7 .7],'linestyle','--','linewidth',2,'color','k')
    
                xticks([1 6 15 25 35])
                xticklabels({'-5','0', '10', '20', '30'})
                
                xlabel('Trials since block switch')
                
                if Mnk == 1
                    ylabel(ylabel_title(i))
                end

                if i == 1
                    yticks([0.2 0.4 0.6 0.8 1])
                    yticklabels({'0.2', '0.4', '0.6', '0.8', '1'})
                    yline(.7,'linestyle','--','linewidth',1,'color','k')
                end
                
                %add delta lines
                if i == 1
                    if dim == 1
                        plot([point; point], [0.7; 1.1],'Color',ColStim(kk,:),'linewidth',2,'linestyle','--'); hold on;
                    elseif dim == 3
                        plot([point; point], [0; 0.7],'Color',ColStim(kk,:),'linewidth',2,'linestyle','--'); hold on;
                    end
                end           
                %set(gca,'tickdir','out','xlim',[X(1) X(35)],'ylim',[.15 1.05],'box', 'off', 'fontname','Helvetica Neue', 'FontSize', fs)                
            end
        end
        
        if i == 1
            title(Mnk_Label{Mnk});
        end
    
    %     if Mnk == 3
    %         legend(legend_label, "Location",'southeast','NumColumns',2)
    %         %legend(legend_label);
    %     end
end


