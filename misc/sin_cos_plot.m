% ------------------------------------------------------------------------
% Plain-text export of sin_cos_plot.mlx (MATLAB Live Editor file), generated
% so the code can be read on GitHub. Open the .mlx in MATLAB to see the
% formatted version with its embedded outputs.
% Warm-up exercise, saved September 2024
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------

% 定義變量
t = 0:0.1:12;  % 時間從 0 到 12，間隔為 0.1
y1 = sin(t);   % 正弦函數
y2 = cos(t);   % 餘弦函數

% 繪製圖形
plot(t, y1, 'b', 'LineWidth', 2);  % 繪製正弦波，藍色
hold on;                           % 保持圖形，繼續繪製
plot(t, y2, 'r', 'LineWidth', 2);  % 繪製餘弦波，紅色
hold off;

% 設置圖形標題和軸標籤
title('test plot of two functions');
xlabel('time in sec');
ylabel('Volts');

% 添加網格
grid on;
