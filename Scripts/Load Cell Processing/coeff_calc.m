% Plot mean values of load cell readings against telescope elevation
% Telescope azimuth held fixed
% Filenames read by file_path.m

% Data file format:
% F/T : Fx Fy Fz Tx Ty Tz   [N, Nm]
% Conds: Pd Pa V Theta      [Pa, kPa, m/s, degC]

% Written by Raghul Ravichandran on 30/08/18

% ======================================================================

%%      PREAMBLE
clear
clc



vel = [8 15 20];
azim = 0:30:180;
elev = [10 20 30 50 70 80 90];
%   7 figures for 7 azimuth angles
% fignum = 7;
%
% %   clear all open figures for new plots
% for i = 1 : fignum
%     figure (fignum)
%     clf
% end

R = 287;
counter = 1;

%%      READ F/T & CONDS DATA
for azim_num = 1:7              % new figure for each azimuth
    for elev_num = 1:7          % plot coefficient against elevation
        for vel_num = 1:3       % new line for each velocity
            
            %   Create paths to data files
            [FT.filepath, conds.filepath, test_name] = file_path(azim(azim_num), elev(elev_num), vel(vel_num));
            
            %   Label rows of data file
            coeff(counter).testname = test_name;
            mean_coeffs(counter).testname = test_name;
            
            
            %   Open F/T data
            fid = fopen(FT.filepath,'r');
            FT.rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
            FT.rawdata = cell2mat(FT.rawdata);
            fclose(fid);
            
            %   Open conds data
            fid = fopen(conds.filepath,'r');
            conds.rawdata = textscan(fid, '%f %f %f %f','Collect', 1);
            conds.rawdata = cell2mat(conds.rawdata);
            fclose(fid);
            
            %   Write FT variables
            FT.Fx = FT.rawdata(:,1); FT.Fy = FT.rawdata(:,2); FT.Fz = FT.rawdata(:,3);
            FT.Tx = FT.rawdata(:,4); FT.Ty = FT.rawdata(:,5); FT.Tz = FT.rawdata(:,6);
            
            %   Write Conds variables
            conds.Pd = conds.rawdata(:,1); conds.Pa = conds.rawdata(:,2);
            conds.v = conds.rawdata(:,3); conds.theta = conds.rawdata(:,4);
            
            %%     CALCULATIONS
            %   Compute aero coefficients based on 400 F/T readings in each sample, for each FCO reading
            
            %   Preallocation
            [FT.coeff_Fx, FT.coeff_Fy, FT.coeff_Fz, FT.coeff_Tx, FT.coeff_Ty, FT.coeff_Tz] = deal(zeros(1,length(FT.Fx)));
%             [coeff.Fx, coeff.Fy, coeff.Fz, coeff.Tx, coeff.Ty, coeff.Tz] = deal(zeros(7*7*3));
            
            %   Calculation of full set of coefficients
            for i = 1:length(conds.Pd)
                
                if conds.Pd(i) == 0
                    conds.Pd(i) = (conds.Pd(i+1) + conds.Pd(i-1))/2;
                end
                
               
                
                for j = 1:400
                    
                    FT.coeff_Fx((i-1)*400+j) = FT.Fx((i-1)*400+j) / conds.Pd(i)/ 0.2;
                    FT.coeff_Fy((i-1)*400+j) = FT.Fy((i-1)*400+j) / conds.Pd(i)/ 0.2;
                    FT.coeff_Fz((i-1)*400+j) = FT.Fz((i-1)*400+j) / conds.Pd(i)/ 0.2;
                    FT.coeff_Tx((i-1)*400+j) = FT.Tx((i-1)*400+j) / conds.Pd(i)/ 0.2;
                    FT.coeff_Ty((i-1)*400+j) = FT.Ty((i-1)*400+j) / conds.Pd(i)/ 0.2;
                    FT.coeff_Tz((i-1)*400+j) = FT.Tz((i-1)*400+j) / conds.Pd(i)/ 0.2;
                    
                    
                end
            end
            
            
            
            %%      WRITE
            
            % counter variable for indexing output - note order of loops
            % for elev and azim
            
            
            % store each run coefficients in a matrix
            coeff(counter).Fx = FT.coeff_Fx; coeff(counter).Fy = FT.coeff_Fy; coeff(counter).Fz = FT.coeff_Fz;
            coeff(counter).Tx = FT.coeff_Tx; coeff(counter).Ty = FT.coeff_Ty; coeff(counter).Tz = FT.coeff_Tz;
            
            % store each average in a cell
            mean_coeffs(counter).Fx = mean(FT.coeff_Fx); mean_coeffs(counter).Fy = mean(FT.coeff_Fy); mean_coeffs(counter).Fz = mean(FT.coeff_Fz);
            mean_coeffs(counter).Tx = mean(FT.coeff_Tx); mean_coeffs(counter).Ty = mean(FT.coeff_Ty); mean_coeffs(counter).Tz = mean(FT.coeff_Tz);
            
            
            
            counter = counter + 1;
            
            
            %   Print file type for progress
            FT.filepath
            
        end
    end
end

filename = '../../Data/2018-08-26 Data/mat Files/coeffs.mat';
save(filename, 'coeff')

filename = '../../Data/2018-08-26 Data/mat Files/mean_coeffs.mat';
save(filename, 'mean_coeffs')

