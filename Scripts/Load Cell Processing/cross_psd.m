function [PSD,freq,d_f] = cross_psd(data1,data2,sf,windows)
% =========================================================================
% Cross power density spectra, by Eduardo Rodriguez December 2014
% Imperial College
%
% It calculates the cross power density spectra of 2 signals, data1 and
% data2 sampled at sf with windows number of windows (default=1)
%
%If data1=data2 it gives the traditional PSD
 
%% DECLARE SETTINGS FOR TRANSFORM
if length(data1)~=length(data2)
    error('samples are not the same length')
end
 
% Number of points in each window used
if isempty(windows)
    Points = length(data1);
else
    Points  = length(data1)/windows;
end
 
% Number of overlap samples
N_ovlap = Points*0.5;
 
% Calculating number of intervals
N_intervals = floor((length(data1)-N_ovlap)/(Points-N_ovlap));
 
avg1=mean(data1);
avg2=mean(data2);
 
%% INITIALISE MATRICES
AUTO_SPEC = zeros(ceil(Points/2),1);
AUTO_PHASE_SPEC = 0;
 
index = 1:Points;
 
%% THE TRANSFORM
for i = 1:N_intervals
     
    % Subtract the mean from the data
    dat_part1 = data1(index) - avg1;
    dat_part2 = data2(index) - avg2;
     
    % Advancing index through the windows - this is separate because we
    % want to apply the overlap, hence why i is not used
    index = index+(Points-N_ovlap);
     
    % Apply Hanning filter to data
    dat_part1 = dat_part1.*hann(Points,'periodic');
    dat_part2 = dat_part2.*hann(Points,'periodic');
     
    % Do the transform
    spec1 = fft(dat_part1)/Points;
    spec2 = fft(dat_part2)/Points;
%     phase_spec1 = fftshift(spec1);
%     phase_spec2 = fftshift(spec2);
%     
    cross_spec = (spec1(1:ceil(Points/2)).*conj(spec2(1:ceil(Points/2))))/N_intervals;
     
    % Average the power spectra for the number of windows
    AUTO_SPEC = AUTO_SPEC + cross_spec;
%     AUTO_PHASE_SPEC = AUTO_PHASE_SPEC + phase_spec;
     
end
 
%% APPLY CORRECTIONS AND NORMALISATIONS
% Correction for the filter
AUTO_SPEC = (1/mean(hann(Points,'periodic').^2))*AUTO_SPEC;
% Phase = unwrap(angle(AUTO_PHASE_SPEC));
 
 
% Frequency vector and spacing
freq = sf*(0:ceil(Points/2)-1)'/Points;     % frequency vector
d_f = sf/Points;                            % delta f of frequency
PSD = (2*AUTO_SPEC)/d_f;                      % One sided Power Spectrum Density
 
end