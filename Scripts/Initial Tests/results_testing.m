clc
clear

[fid, msg] = fopen("/Users/Raghul/Documents/Imperial/Aeronautics - 3rd Year/UROP/Data/60az_30el_10v",'r');       
rawdata = textscan(fid, '%f %f %f %f %f %f','Collect', 1);
rawdata = cell2mat(rawdata);
fclose(fid);
rawdata = rawdata (2:end, :);

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


plot(time_vector, Fx) 

N  = time; 
fs = rate; 

figure (1)      % periodograph 
segmentLength = time;
noverlap = 0; % default overlap 50% 
nfft = 512;
[pxx,f] = pwelch(Fx,segmentLength,noverlap,[],fs);
plot(f,10*log10(pxx))

xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

figure (2)      % 24 segments, no overlap 

segmentLength = time/4;
noverlap = 0; % default overlap 50% 
nfft = 512;
[pxx,f] = pwelch(Fx,segmentLength,noverlap,[],fs);
plot(f,10*log10(pxx))
xlabel('Frequency (Hz)')

figure (3)      % 16 segments, no overlap

segmentLength = time/32;
noverlap = 0; % default overlap 50% 
nfft = 512;
[pxx,f] = pwelch(Fx,segmentLength,noverlap,[],fs);
plot(f,10*log10(pxx))
xlabel('Frequency (Hz)')

set(gca,'xscale','log')
ylabel('Magnitude (dB)')