clear all
clc
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
    
    data1 = Fx;
    data2 = Fx;
    sf = fs;
    windows = 100;
    [PSD,freq,d_f] = cross_psd(data1,data2,sf,windows);
    
    windows = 50;
    [PSD2,freq2,d_f2] = cross_psd(data1,data2,sf,windows);
    
    figure (1)
    
    plot(freq,(PSD))
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')    
    set(gca,'xscale','log')

    hold on
    
    figure (2)
   
    plot(freq2,(PSD2), 'linewidth',1.5)
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')    
    set(gca,'xscale','log')

    
    hold on
    
end

leg= legend('Forward', 'RHS', 'Centre' );
set(leg,'Interpreter','latex','fontsize', 20);
leg= legend('Forward', 'RHS', 'Centre' );
set(leg,'Interpreter','latex','fontsize', 20);
hold off

hold off
    


