clc
clear all
clf
clf

for i = 1:3
    if i ==1
        
        [fid, msg] = fopen("../Data/60az_30el_10v",'r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
        
    elseif i == 2
        %[fid, msg] = fopen("../Data/60az_30el_15v",'r');
        [fid, msg] = fopen("../Data/strutRHS_60az_30el_20v",'r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
        
    elseif i ==3
        %[fid, msg] = fopen("../Data/60az_30el_20v",'r');
        [fid, msg] = fopen("../Data/strutC_60az_30el_20v",'r');
        rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
        rawdata = cell2mat(rawdata);
        fclose(fid);
    end
    Fx = rawdata(:,1);
    Fy = rawdata(:,2);
    Fz = rawdata(:,3);
    Tx = rawdata(:,4);
    Ty = rawdata(:,5);
    Tz = rawdata(:,6);
    
    mean(Fx)
    mean(Fy)
    mean(Fz)
    mean(Tx)
    mean(Ty)
    mean(Tz)
    
    time = size(Fx);
    time = time(1);
    
    rate = 8000;
    dt = 1 / rate;
    
    final_time = time * dt;
    
    time_vector = 0:dt:final_time-dt;
    time_vector = time_vector';
    
    
    %plot(time_vector, Fx)
    
    N  = time;
    fs = rate;
    
    figure (1)
    
    segmentLength = N/100;
    noverlap = segmentLength*0.8; % default overlap 50%
    nfft = [];
    [pxx,f] = pwelch(Fx,segmentLength,noverlap, nfft, fs);
    plot(f,(pxx))
    xlabel('Frequency (Hz)')
    
    set(gca,'xscale','log')
    ylabel('Magnitude (dB)')
    hold on
    axis([10^1 10^4 0 5E-4])
    
%     figure (2)
%     
%     segmentLength = N/10;
%     noverlap = segmentLength * 0.6;%segmentLength/2; % default overlap 50%
%     nfft = 2048*8;
%     [pxx,f] = pwelch(Fx,segmentLength,noverlap, nfft, fs);
%     plot(f,(pxx), 'linewidth',1.5)
%     xlabel('Frequency (Hz)')
%     
%     set(gca,'xscale','log')
%     ylabel('Magnitude (dB)')
%     axis([10^1 10^4 0 5E-4])
% 
%     hold on
%     
end

leg= legend('Forward', 'RHS', 'Centre' );
set(leg,'Interpreter','latex','fontsize', 20);
leg= legend('Forward', 'RHS', 'Centre' );
set(leg,'Interpreter','latex','fontsize', 20);
hold off

hold off