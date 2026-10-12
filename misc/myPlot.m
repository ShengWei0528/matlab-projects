% ------------------------------------------------------------------------
% Plain-text export of myPlot.mlx (MATLAB Live Editor file), generated
% so the code can be read on GitHub. Open the .mlx in MATLAB to see the
% formatted version with its embedded outputs.
% Warm-up exercise, saved September 2024
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------

% 繪製折線圖
function myPlot(x, y)
    plot(x, y, 'LineWidth', 2);  % 設置線條寬度為 2
    title('自定義繪圖');          % 設置圖標題
    xlabel('X 軸');               % 設置 X 軸標籤
    ylabel('Y 軸');               % 設置 Y 軸標籤
    grid on;                      % 打開網格
end
