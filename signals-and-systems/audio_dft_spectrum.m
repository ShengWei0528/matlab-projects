% ------------------------------------------------------------------------
% audio_dft_spectrum.m
% DFT magnitude spectrum (linear and dB) of a short audio recording.
% Run from this folder: reads audio_sample.wav.
% Course: Signals and Systems (訊號與系統), YZU, Spring 2024
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
[s,fs]=audioread('audio_sample.wav')
xt=s(1:8000,1);
N=8000
xf=fft(xt);
f=fs*(0:(N/2))/N;
n=(N/2)+1;
clf()
subplot(3,1,1), plot(xt), title('Fig. 2 (a) Time signal xt[n] vs time index n');
subplot(3,1,2), plot(f,abs(xf(1:n))),title('Fig. 2 (b) DFT Magnitude spectrum xf vs f (Hz) ');
subplot(3,1,3), plot(f, 20*log10(abs(xf(1:n)))), title('Fig. 2 (c) DFT Magnitude Spectrum xf (dB) vs f(Hz) ');
