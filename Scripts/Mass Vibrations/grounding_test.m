clear
clc
clf
clf

%%  GLOBAL CONSTANTS

%%  EMPTY TUNNEL - 0M

vel = [0 10 15 20];
mass = [0 200 500 1000];
j= 1;

for i = 1:4
    
    if i == 1
       [fid, msg] = fopen('../../Data/2018-08-21 Data/Grounding test/ungrounded_0v','r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
        
    elseif i == 2
        [fid, msg] = fopen('../../Data/2018-08-21 Data/Grounding test/grounded_0v','r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
        
    elseif i == 3
        [fid, msg] = fopen('../../Data/2018-08-21 Data/Grounding test/ungrounded_15v','r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
        j=2;

        
    elseif i == 4
        [fid, msg] = fopen('../../Data/2018-08-21 Data/Grounding test/grounded_15v','r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
    end
        
        
           
            
        
        
        
        
        %   Write output to structure
        Fx = rawdata(:,1);
        Fy = rawdata(:,2);
        Fz = rawdata(:,3);
        Tx = rawdata(:,4);
        Ty = rawdata(:,5);
        Tz = rawdata(:,6);
        
        %     mean(i).F_x = mean(Fx);
        %     mean(i).F_y = mean(Fy);
        %     mean(i).F_z = mean(Fz);
        %     mean(i).T_x = mean(Tx);
        %     mean(i).T_y = mean(Ty);
        %     mean(i).T_z = mean(Tz);
        
        
        %   Sampling parameters
        N = length(Fx);
        fs = 2000;
        
        dt = 1 / fs;
        run_time = N * dt;
        time_vector = 0:dt:run_time-dt;
        time_vector = time_vector';
        
        data1 = Fx;
        data2 = Fx;
        
        windows = 200;
        [PSD,freq,d_f] = cross_psd(data1,data2,fs,windows);
        
        
        %%  PLOT DATA
        
        %  freq
        figure (j)
        
        plot(freq,(PSD), 'linewidth',1.5)
        
        hold on
      
        
        
    
end
%%  FIGURE ANNOTATIONS

figure (1)
xlabel('Frequency','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Grounded and ungrounded - v = 0')
set(gca,'xscale','log','yscale','log','fontsize',15)
leg= legend('ungrounded', 'grounded');
set(leg,'Interpreter','latex','fontsize', 20);
hold off


figure (2)
xlabel('Frequency / velocity','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Grounded and ungrounded - v = 15')
set(gca,'xscale','log','yscale','log','fontsize',15)
leg= legend('ungrounded', 'grounded');
set(leg,'Interpreter','latex','fontsize', 20);
hold off


