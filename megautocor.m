%    EPILEPTIC MEG AUTOCORRELATION
clear all;
close all;
clc;
display('EPILEPTIC MEG autocorrelation estimation');

pkg load signal;

% load MEG data
a = load('rfot27.flt');

% sampling frequency
fs = 256;

% signal length and starting sample
N = 1024;
shift = 1000;

% signal
y = a(shift+1:shift+N);

% remove mean value
y = y - mean(y);

% time values
t = (0:N-1)/fs;

 %    PLOT SIGNAL
figure(1);
plot(t,y);
axis([0 (N-1)/fs min(y) max(y)]);
xlabel('TIME (sec)');
ylabel('MEG (pT)');
title('EPILEPTIC MEG SIGNAL');

%  ESTIMATE AND PLOT AUTO_CORRELATION

figure(2);
cr = xcorr(y, y, 'coeff');
plot((-(N-1):(N-1))/fs, cr, 'r');
axis([-(N-1)/fs (N-1)/fs min(cr) max(cr)]);
xlabel('TIME(sec)');
ylabel('AUTOCORRELATION COEFICIENT');
title('EPILEPTIC MEG AUTOCORRELATION ESTIMATION');


% track first zero-crossing
i = N;
do
  i++;
until (cr(i) < 0)
fprintf('first zero of autocorrelation coefficient at %d\n', i- N-1);

k=[1, i-N-1];
% LAG PLOT 
figure(3);

for j=1:numel(k)
  subplot(1,numel(k),j)
  scatter(y(2+k(j):end),y(1:end-1-k(j)))
  xlabel(['y(i-',num2str(k(j)),')']);
  ylabel('y(i)');
  title(['EPILEPTIC MEG PHASE PLOT FOR tau=',num2str(k(j))]);
endfor

