%FFTDEMO Demonstrate use of FFT for spectral analysis.

%   Copyright (c) 1984-98 by The MathWorks, Inc.
%   $Revision: 5.3 $  $Date: 1997/11/21 23:25:42 $
%   Mod by sb, 11/21/99, 04/19/14

%load z.txt
if (~exist('z'))
disp 'First, create vector z, which contains 4096 values from your exercise 935'
disp 'If your data file is z.txt, type: load z.txt'
  return
end

N=length(z)
x=z;
dt=.25/(N-1);
t=[0:dt:.25]';
fHz=1/dt;

%   Plot the signal x(t)
figure(1)
plot(t,x)
xlabel('Time (sec)')
ylabel('Magnitude')
title('Signal x(t) = three sinusoids with noise')
disp 'Strike any key to continue.'
pause 


%   Finding the discrete Fourier transform of the noisy signal 
%   is easy; we just take the fast-Fourier transform (FFT) :

X = fft(x,N);


%   The power spectral density, a measurement of the energy at
%   various frequencies, is found with:

Pxx = X.*conj(X)/(N/2);

%   To plot the power spectral density, we must first form a 
%   frequency axis:

f = (fHz/N)*[0:(N/2 -1)];

%   which we do for the first 127 points. (The remainder of the 256
%   points are symmetric.)  We can now plot the power spectral
%   density:


figure(2)
plot(f,Pxx(1:(N/2) )), title('Power spectral density'), ...
xlabel('Frequency (Hz)'),
clc

%   Let's zoom in and plot only up to some frequency:
%   Fmax=input('Replot up to some max-f.  max-f (Hz) = ');
Fmax=140;
if Fmax==[]
  Fmax=140;
end

NN=round(Fmax/4);
ff=f(1:NN);
pp=Pxx(1:NN);
plot(ff,pp), title('Power spectral density'),
grid
xlabel('Frequency (Hz)')

clc
echo off

disp('End')
