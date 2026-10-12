% ------------------------------------------------------------------------
% Plain-text export of xy_circle_plot.mlx (MATLAB Live Editor file), generated
% so the code can be read on GitHub. Open the .mlx in MATLAB to see the
% formatted version with its embedded outputs.
% Warm-up exercise, saved September 2024
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------

% 定義角度範圍
theta = linspace(0, 2*pi, 100);  % 從 0 到 2π 的等間隔角度

% 圓的參數方程
x = cos(theta);
y = sin(theta);

% 繪製圖形
plot(x, y, 'b', 'LineWidth', 2);  % 繪製藍色圓圈，線寬為 2
axis equal;  % 使 x 軸和 y 軸等長

% 添加標題和軸標籤
title('XY plot of two functions');
xlabel('fx1');
ylabel('fx2');

% 添加網格
grid on;
