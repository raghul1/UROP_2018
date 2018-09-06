% Plot mean values of load cell readings in a contour plot of elevation vs azimuth at a fixed velocity
% Averaged aerodynamic coeefficients read from .mat file 
% Torques require additional division by length scale - not factored in original script
% Coefficients agree for different velocities, only one is shown

% Data file format:
% F/T : Fx Fy Fz Tx Ty Tz   [N, Nm]
% Conds: Pd Pa V Theta      [Pa, kPa, m/s, degC]

% Written by Raghul Ravichandran on 05/09/18

% ======================================================================

%%      PREAMBLE
clear
clc
clf

% global variables
azim = 0:30:180;
elev = [10 20 30 50 70 80 90];

%   load calculated data into workspace 
load("../../Data/2018-08-26 Data/mat Files/mean_coeffs.mat")

%   specify data set to examine 
%   coefficient name
coeff_name = 'Tz';      % CHANGE FOR FT    (1/2)
vel = 20;

% matrices for contour plot 
coeff = zeros(7);
[E, A] = meshgrid(azim, elev);


%%     PLOT DATA
for elev_num = 1:7              % new figure for each azimuth
    for azim_num = 1:7
        
        % selection of coeff specific to data collection order 
        coeff(elev_num, azim_num) = mean_coeffs( 3 + (elev_num-1)*3 + (azim_num-1)*21 ).Tz;     % CHANGE FOR FT    (2/2)
                                                                                                % CHANGE FOR VEL
        % ADDITIONAL MOMENT CALCULATION (need moment arm / variation)
        % -----------------------------------------------------------
        % moment arm - length and angle
        % moment_arm = 0.1; coeff(elev_num) = coeff(elev_num) / moment_arm;
        % coeff(elev_num) = coeff(elev_num) / (sind( elev(elev_num) ));
        
    end
end
    
%%      CONTOUR PLOT



%%      FIGURE FORMATTING
for i = 1:2
    figure (i)
     % save figure as png                                             
    if i == 1
        figure_name = sprintf("../../Data/2018-08-26 Data/Figs/Contour plots/%s.png", coeff_name);
        [C, h] = contour(E, A, coeff, 15,'showtext','on','linewidth',1.5, 'labelspacing', 1500); 
        colormap jet
    elseif i== 2
        figure_name = sprintf("../../Data/2018-08-26 Data/Figs/Contour plots/%s (filled).png", coeff_name);
        [C, h] = contourf(E, A, coeff, 15,'showtext','on','linewidth',1.5, 'labelspacing', 1500); 
        colormap parula
    
    end
    %   figure title
    graph_title = sprintf('Aerodynamic Coefficient, C_{%s}', coeff_name);
    title(graph_title,'fontsize', 35)
    
    clabel(C,h,'Fontsize', 14)
    axis([0 180 10 90])
    y_label = sprintf('Elevation (%c)', char(176));
    x_label = sprintf('Azimuth (%c)', char(176));
    xlabel(x_label,'interpreter','latex','fontsize', 30)
    ylabel(y_label, 'interpreter','latex','fontsize', 30)
    set(gca, 'fontsize', 15)
    grid on
    
   

    saveas(gcf, figure_name) 
        
    
end
