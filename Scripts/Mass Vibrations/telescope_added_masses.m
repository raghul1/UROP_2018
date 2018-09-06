clear
clc
clf
clf

%%  GLOBAL CONSTANTS

%%  EMPTY TUNNEL - 0M

vel = [0 10 15 20];
mass = [0 200 500 1000];


for i = 1:4
    for j = 1:4
        
        
        %   Read data file
        filepath = file_path_1(mass(j), vel(i));
        
        if filepath == "../../Data/2018-08-21 Data/500m_0v" % file missing
            continue
        end
            
        [fid, msg] = fopen(filepath,'r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
        
        
        
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
        figure (i*2-1)
        
        plot(freq,(PSD), 'linewidth',1.5)
        
        hold on
        
        
        %  freq / vel
        
        figure (i*2)
        
        plot(freq/vel(i),(PSD), 'linewidth',1.5)
        
        hold on
        
        
    end
end
%%  FIGURE ANNOTATIONS

figure (1)
xlabel('Frequency','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Spec vs freq - v = 0')
leg= legend('$m$ = 0', '$m$ = 200', '$m$ = 500', '$m$ = 1000');
set(leg,'Interpreter','latex','fontsize', 20);
set(gca,'xscale','log','yscale','log','fontsize',15)
hold off


figure (2)
xlabel('Frequency / velocity','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Spec vs freq / vel - v = 0')
leg= legend('$m$ = 0', '$m$ = 200', '$m$ = 500', '$m$ = 1000');
set(leg,'Interpreter','latex','fontsize', 20);
set(gca,'xscale','log','yscale','log','fontsize',15)
hold off


figure (3)
xlabel('Frequency','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Spec vs freq - v = 10')
leg= legend('$m$ = 0', '$m$ = 200', '$m$ = 500', '$m$ = 1000');
set(leg,'Interpreter','latex','fontsize', 20);
set(gca,'xscale','log','yscale','log','fontsize',15)
hold off


figure (4)
xlabel('Frequency / velocity','interpreter','latex','fontsize',20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Spec vs freq / vel - v = 10')
leg= legend('$m$ = 0', '$m$ = 200', '$m$ = 500', '$m$ = 1000');
set(leg,'Interpreter','latex','fontsize', 20);
set(gca,'xscale','log','yscale','log','fontsize',15)
hold off

figure (5)
xlabel('Frequency','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Spec vs freq - v = 15')
leg= legend('$m$ = 0', '$m$ = 200', '$m$ = 500', '$m$ = 1000');
set(leg,'Interpreter','latex','fontsize', 20);
set(gca,'xscale','log','yscale','log','fontsize',15)
hold off


figure (6)
xlabel('Frequency / velocity','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Spec vs freq / vel - v = 15')
leg= legend('$m$ = 0', '$m$ = 200', '$m$ = 500', '$m$ = 1000');
set(leg,'Interpreter','latex','fontsize', 20);
set(gca,'xscale','log','yscale','log','fontsize',15)
hold off

figure (7)
xlabel('Frequency','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Spec vs freq - v = 20')
leg= legend('$m$ = 0', '$m$ = 200', '$m$ = 500', '$m$ = 1000');
set(leg,'Interpreter','latex','fontsize', 20);
set(gca,'xscale','log','yscale','log','fontsize',15)
hold off


figure (8)
xlabel('Frequency / velocity','interpreter','latex','fontsize', 20)
ylabel('Magnitude','interpreter','latex','fontsize', 20)
title('Spec vs freq - v = 20')
leg= legend('$m$ = 0', '$m$ = 200', '$m$ = 500', '$m$ = 1000');
set(leg,'Interpreter','latex','fontsize', 20);
set(gca,'xscale','log','yscale','log','fontsize',15)
hold off




