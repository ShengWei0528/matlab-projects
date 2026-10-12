% ------------------------------------------------------------------------
% Plain-text export of myplot_demo.mlx (MATLAB Live Editor file), generated
% so the code can be read on GitHub. Open the .mlx in MATLAB to see the
% formatted version with its embedded outputs.
% Warm-up exercise, saved September 2024
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------

% 生成測試數據
x = linspace(0, 2*pi, 100);  % 生成從 0 到 2π 的 100 個點
y = sin(x);                  % 計算 y = sin(x)

% 調用 myPlot 函數
myPlot(x, y);                % 繪製 sin(x) 的圖形
