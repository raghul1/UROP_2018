% Plot spectra of vibrations measured by load cell at 3 speeds
% Telescope azimuth held fixed, scope for fixing elevation instead
% Aerodynamic forces read from raw data files
% Torques require additional division by length scale - not factored in original script
%
% Plot 3 elevations to begin with for clearer graphs

% Data file format:
% F/T : Fx Fy Fz Tx Ty Tz   [N, Nm]
% Conds: Pd Pa V Theta      [Pa, kPa, m/s, degC]

% Written by Raghul Ravichandran on 30/08/18

% ======================================================================

%%      PREAMBLE AND GLOBAL CONSTANTS
clear
clc
clf


vel = [8 15 20];
azim = 0:30:180;
elev = [10 50 90];



%   coefficient name
coeff_name = 'Fx';      % CHANGE FOR FT    (1/3)

azim_num = 1;

%   sampling parameters
fs = 2000;
windows = 500;
dt = 1 / fs;


%%     SET UP PLOTS
%   Create two figures, freq spectra and freq/vel spectra
for i = 1:2
    figure (i)
    clf
    
    
    for elev_num = 1:3              % new subplot for each azimuth
        for vel_num = 1:3           % new line for each velocity
            
            %%      READ EACH DATA FILE
            
            % read raw data files, path specified by file_path
            [filepath.FT, filepath.conds, filepath.name] = file_path(azim(azim_num), elev(elev_num), vel(vel_num));
            [fid, msg] = fopen(filepath.FT,'r');
            rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
            rawdata = cell2mat(rawdata);
            fclose(fid);
            
            %%      CALCULATE PSD
            %   calculate for Fx only (most significant axis)
            DATA = rawdata(:,1);            % CHANGE FOR FT (2/2)
            N = length(DATA);
            
            %   Welch method 
            window = N/20;
            noverlap = []; % default overlap 50%
            nfft = window;
            %[PSD,freq] = pwelch(DATA,window,noverlap, nfft, fs);
            
            % from: https://stackoverflow.com/questions/22661758/how-to-improve-the-resolution-of-the-psd-using-matlab
            [PSD,freq] = pwelch(DATA,hann(nfft),nfft/2, nfft, fs); 
            %PSD = 10*log10(PSD);
            %%     PLOT DATA
            %   for each velocity on same subplot
            
            subaxis(3,1, elev_num, 'Spacing', 0.05, 'Padding', 0.00, 'Margin', 0.07)
            
            %       Plot relevent data depending on figure
            if i == 1
                plot(freq,(PSD), 'linewidth',1.5)
                xlim([1E1 1E3])
                
            elseif i ==2
                plot(freq/vel(vel_num),(PSD), 'linewidth',1.5)
                xlim([1 1E2])
                
                
            end
            hold on
            
            
        end
        
        %%      SUBPLOT FORMATTING
        hold off
        subplot_title = sprintf('%d%c Elevation', elev(elev_num), char(176));
        
        title(subplot_title, 'interpreter', 'latex', 'fontsize', 14)
        grid on
        set(gca,'xscale','log','yscale','log','fontsize',15)
        
        
        %         % insert legend into empty subplot
        %         subplot(3,1,8)
        %         plot(0,0,  0,0,  0,0 )      % create shell plot
        %         axis off
        %         leg= legend('$v$ = 8', '$v$ = 15', '$v$ = 20');
        %         set(leg,'Interpreter','latex','fontsize', 20, 'location', 'west');
        
    end
    
    %%      FIGURE FORMATTING AND SAVING
    
    if i == 1
        graph_title = sprintf('Magnitude vs Frequency, Azimuth = %d', azim(azim_num));
        figure_name = sprintf("../../Data/2018-08-26 Data/Figs/Spectra/Fixed azimuth/Azimuth_%d_freq_welch.png", azim(azim_num));
        
    elseif i == 2
        graph_title = sprintf('Magnitude vs Frequency / Velocity, Azimuth = %d', azim(azim_num));
        figure_name = sprintf("../../Data/2018-08-26 Data/Figs/Spectra/Fixed azimuth/Azimuth_%d_freqvel_welch.png", azim(azim_num));
        
    end
    
    suptitle(graph_title)
    
    % save figure as png
    %saveas(gcf, figure_name)
end






