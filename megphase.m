% EPILEPTIC MEG phase space trajectory 
clear all;
close all;
clc;
display('EPILEPTIC MEG phase space reconstruction');

% load MEG data
a = load('rfot27.flt');

% signal length, starting sample and reconstruction parameter tau
N = 512;
shift = 0;
tau = 1;

% phase space reconstruction vectors
x2 = zeros(N-tau,2);
x3 = zeros(N-2*tau,3);
fs = 256;

for i = 1:N-tau
   x2(i, 1:2) = [a(shift+i), a(shift+i+tau)];
end


for i = 1:N-2*tau
   x3(i, 1:3) = [a(shift+i), a(shift+i+tau), a(shift+i+2*tau)];
end

% plot signal
figure(1);
plot((0:N-1)/fs, a(shift+1:shift+N));
axis([0 N/fs min(a(shift+1:shift+N)) max(a(shift+1:shift+N))]);
xlabel('TIME (sec)');
ylabel('MEG AMPLITUDE (pT)');
title('EPILEPTIC MEG SIGNAL');

% 2-D phase space reconstruction

figure(2);
plot(x2(:,1), x2(:,2));
xlabel('X');
ylabel('Y');
title('EPILEPTIC MEG 2-D PHASE SPACE RECONSTRUCTION');

% 3-D phase space reconstruction

figure(3);
plot3(x3(:,1), x3(:,2), x3(:,3));
xlabel('X');
ylabel('Y');
zlabel('Z');
title('EPILEPTIC MEG 3-D PHASE SPACE RECONSTRUCTION');
view(45,10);

