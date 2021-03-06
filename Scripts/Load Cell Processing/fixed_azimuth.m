% Plot mean values of load cell readings against telescope elevation
% Telescope azimuth held fixed
% Averaged aerodynamic coeefficients read from .mat file 
% Torques require additional division by length scale - not factored in original script

% Data file format:
% F/T : Fx Fy Fz Tx Ty Tz   [N, Nm]
% Conds: Pd Pa V Theta      [Pa, kPa, m/s, degC]

% Written by Raghul Ravichandran on 30/08/18

% ======================================================================

%%      PREAMBLE
clear
clc
clf


vel = [8 15 20];
azim = 0:30:180;
elev = [10 20 30 50 70 80 90];

R = 287;
counter = 1;

%   load calculated data into workspace 
load("../../Data/2018-08-26 Data/mat Files/mean_coeffs.mat")

%   coefficient name
coeff_name = 'Tz';      % CHANGE FOR FT    (1/3)


%%     PLOT DATA
for azim_num = 1:7              % new figure for each azimuth
    for vel_num = 1:3           % new line for each velocity
        
           %    loop through elevations to form temporary coeff vector to plot
           coeff = zeros(1,7);
           
           for elev_num = 1:7
            
            % selection of coeff specific to data collection order
            coeff(elev_num) = mean_coeffs( 1 + (elev_num-1)*3 + (vel_num-1) + (azim_num-1)*21 ).Tz;     % CHANGE FOR FT    (2/3)

            % ADDITIONAL MOMENT CALCULATION (need moment arm / variation)
            % moment arm - length and angle 
            % moment_arm = 0.1; coeff(elev_num) = coeff(elev_num) / moment_arm;   
            % coeff(elev_num) = coeff(elev_num) / (sind( elev(elev_num) ));
            
           end

           figure (1)
%          subplot(2,4, azim_num) - alternative function available for formatting
           subaxis(2,4, azim_num, 'Spacing', 0.05, 'Padding', 0.00, 'Margin', 0.07)
           
           plot(elev, coeff, 'linewidth',1.5) 
           hold on
           
          
           
    end
    
    %%  SUBPLOT FORMATTING
    
    hold off
    %axis([10 90 0.09 0.136])          % Fx         % CHANGE FOR FT (3/3)
    %axis([10 90 -11E-3 11E-3])        % Fy
    %axis([10 90 -0.025 0.025])        % Fz
    %axis([10 90 -0.0002 0.009])       % Ty (pitch)
    axis([10 90 -1.55E-3 1.5E-3])     % Tz (yaw) 
    

    subplot_title = sprintf('%d%c Azimuth', azim(azim_num), char(176));
    title(subplot_title, 'interpreter', 'latex')
    grid on
end

%%      FIGURE FORMATTING

%   figure title
graph_title = sprintf('Aerodynamic Coefficient (C_{%s}) vs Elevation (%s)', coeff_name, char(176));
suptitle(graph_title)

% insert legend into empty subplot
subplot(2,4,8)
plot(0,0,  0,0,  0,0 )      % create shell plot
axis off 
leg= legend('$v$ = 8', '$v$ = 15', '$v$ = 20');
set(leg,'Interpreter','latex','fontsize', 20, 'location', 'eastoutside');


% save figure as png                                             
figure_name = sprintf("../../Data/2018-08-26 Data/Figs/Fixed azimuth/%s (no moment arm).png", coeff_name);
saveas(gcf, figure_name) 