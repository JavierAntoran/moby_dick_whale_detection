%%
clc
close all
clear all
%
Nsample = 1;

audiofilename = sprintf('../whale_data/train/train%d.aiff', Nsample);

[x,Fs] = audioread(audiofilename);

csvfile = '../whale_data/train.csv';
labels = csvread(csvfile, 1, 1);
pos_labels = find(labels == 1);
label = labels(Nsample);

fprintf('sample %d, label %d\n', Nsample, label)
%%

soundsc(x,Fs)

NFFT = 128;

M = Fs * 0.01; %avance entre vetanas
N = Fs * 0.03; %windowsize

X = windower(x, M, N);%
% M avance entre vetanas
% N windowsize
%
W = hamming(N);
X_hamm = W .* X; % hamming window, automatic broadcasting
%
% fft default applies to first dimension -> columns
S = abs(fft(X_hamm, NFFT));
S = S(1:end/2,:);
%

f = linspace(0, Fs/2, NFFT);
nwins = 1:size(S,2);

figure
imagesc(nwins, f, S)
axis xy
ylabel('freq (Hz)')
xlabel('Nwindow')
title('Spectogram S')


%%

