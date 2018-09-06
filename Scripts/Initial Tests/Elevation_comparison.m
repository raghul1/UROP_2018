%   Compare mean force and torque values for a specified elevation and velocity
%
%   Created by Raghul Ravichandran on 16/08/2018
%   Department of Aeronautics, Imperial College London
%   =========================================================================
clear
clc
clf


%%  GLOBAL CONSTANTS
%   Elevation angles measured
elev = [10, 20, 30, 50, 70, 90];

rho = 1.2;

%%  GENERATE FIGURE

figure (1)
hold on

%%  DATA READ
%   User specified azimuth and velocity
azim = input('Enter azimuth angle: ');

for vel = 10:5:20
    
    
    %   for each elevation angle
    for i = 1:6
        
        %   Create string to locate data file using systematic naming
        filepath = elev_filename(azim, elev(i), vel);
        
        %   Open the file and read the data
        [fid, msg] = fopen(filepath,'r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
        
        %   Store values
        data(i).elev = elev(i);
        data(i).Fx = rawdata(:,1);
        data(i).Fy = rawdata(:,2);
        data(i).Fz = rawdata(:,3);
        data(i).Tx = rawdata(:,4);
        data(i).Ty = rawdata(:,5);
        data(i).Tz = rawdata(:,6);
        
        avgFx(i) = mean(data(i).Fx);
        avgTy(i) = mean(data(i).Ty);
        avgFz(i) = mean(data(i).Fz);
        
        
    end
    %   Set S = area of circular base, rho = 1.2
    
    Cd = (vel^2 * 0.5 * rho * (pi*0.2^2));
    
    plot(elev, avgFx./Cd, 'LineWidth',2)
    
    
end



%%  PLOTS


xlabel('Elevation angle (degrees)','interpreter','latex','fontsize', 15)
ylabel('$C_D$','interpreter','latex','fontsize', 15)
leg= legend('10 m/s', '15 m/s', '20m/s');
set(leg,'Interpreter','latex','fontsize', 20);


hold off
