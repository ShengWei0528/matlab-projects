% ------------------------------------------------------------------------
% Plain-text export of hw2_file_io.mlx (MATLAB Live Editor file), generated
% so the code can be read on GitHub. Open the .mlx in MATLAB to see the
% formatted version with its embedded outputs.
% Course: MATLAB / Simulink Fundamentals Lab (電資通基礎MATLAB / Simulink實驗), YZU, Fall 2024 (homework 2)
% Submitted by: Sheng-Wei Lu (呂聖韡)
% Note: the term definitions in section 1 and the L4.1 / L4.2 callback
% sketches were adapted from a solution notebook (not included here).
% The assignment prompts were replaced with short paraphrased headings.
% ------------------------------------------------------------------------

%% 1. MATLAB 相關術語
% - GUI (Graphical User Interface): 提供用戶以圖形方式與應用程式互動的介面。
% - MATLAB App Designer: MATLAB中用來設計圖形介面應用程式的工具，透過拖放元件來建構GUI。
% - App Designer’s Components: 包含下拉選單（Dropdown）、編輯欄位（Edit Field）、單選按鈕組（Radio Button Group）、滑桿（Slider）、面板（Panel）和座標軸（Axes）等元件。
% - Design View vs. App Code View: Design View用來調整界面設計，App Code View用來撰寫後端程式碼。
% - fopen() and fclose(): 用於打開和關閉檔案的指令。
% - Format string for printing text file: 用於指定文字檔輸出格式的字串。

%% 2. 練習 L3.1 第 1-5 題

%% L3.1 .mat 檔案的用途
% MATLAB 的 .mat 檔案是一種專門用於儲存 MATLAB 工作空間變量的文件格式。其主要功用是將 MATLAB 中的變量（例如矩陣、數值、結構體等）儲存到硬碟中，以便在後續的工作中重新載入並使用，而不需要重新計算或重複設定變量。主要功能和用途
% - 儲存工作空間變量：在分析或計算過程中，若需要儲存大量變量以便日後使用，可以使用 .mat 文件將這些變量保存起來。
% - 資料共享：.mat 文件可以用於在不同 MATLAB 程式或工作間之間傳遞資料，便於資料共享。
% - 簡化處理流程：若某些變量的計算過程繁瑣或耗時，使用 .mat 檔案儲存可以省去重複計算的時間。
% - 支援壓縮：高版本的 .mat 文件（例如 -v7.3 格式）支援壓縮功能，適合儲存大型數據集。

%% L3.1 save/load 練習

%% L3.1 各指令說明

%% L3.1 其他 .mat 存取格式

%% L3.1 範例程式
% 儲存變數到 .mat 文件
A = rand(5);  % 創建一個 5x5 的隨機矩陣
save('data.mat', 'A');

% 從 .mat 文件讀取變數
load('data.mat');
disp(A);

%% 3. 練習 L3.2 第 1-5 題
% 將資料寫入文字文件
fileID = fopen('data.txt', 'w');
fprintf(fileID, 'MATLAB HW2 file I/O example.\n');
fprintf(fileID, '%d %d %d\n', 1, 2, 3);
fclose(fileID);

% 從文字文件讀取資料
fileID = fopen('data.txt', 'r');
formatSpec = '%d';
data = fscanf(fileID, formatSpec);
fclose(fileID);
disp(data);

%% 4. 練習 L3.3 第 1-5 題
% 寫入二進位文件
fileID = fopen('binaryData.bin', 'w');
fwrite(fileID, A, 'double');
fclose(fileID);

% 讀取二進位文件
fileID = fopen('binaryData.bin', 'r');
A_read = fread(fileID, [5 5], 'double');
fclose(fileID);
disp(A_read);

%% 5. 練習 L4.1：計算機 App
function CalculateButtonPushed(app, event)
    % 假設輸入框的正確名稱為 EditFieldA 和 EditFieldB
    a = str2double(app.EditFieldA.Value); % 確認名稱是否正確
    b = str2double(app.EditFieldB.Value); % 確認名稱是否正確

    % 計算結果並顯示
    app.Result_AplusB.Value = a + b;
    app.Result_AminusB.Value = a - b;
    app.Result_AxB.Value = a * b;
    if b ~= 0
        app.Result_AdivB.Value = a / b;
    else
        app.Result_AdivB.Value = 'Inf'; % 如果 b 為 0，避免除以 0 的錯誤
    end
end

%% 6. 練習 L4.2
% - 波形產生器 App 的更新函式
function updateWaveform(app)
    t = linspace(0, 2*pi, 100);
    Ax = app.Spinner_Ax.Value;
    Ay = app.Spinner_Ay.Value;
    fx = app.Slider_fx.Value;
    fy = app.Slider_fy.Value;

    x = Ax * cos(2 * pi * fx * t);
    y = Ay * sin(2 * pi * fy * t);

    plot(app.UIAxes_X, t, x);
    plot(app.UIAxes_Y, t, y);
    plot(app.UIAxes_XY, x, y);
end

% - 加入共同相位 θ（單位：度）的版本
function updateWaveformWithPhase(app)
    theta = deg2rad(app.Dropdown_Theta.Value);  % 選擇相位角 0°, 45°, 90°
    t = linspace(0, 2*pi, 100);
    Ax = app.Spinner_Ax.Value;
    Ay = app.Spinner_Ay.Value;
    fx = app.Slider_fx.Value;
    fy = app.Slider_fy.Value;

    x = Ax * cos(2 * pi * fx * t + theta);
    y = Ay * cos(2 * pi * fy * t + theta);

    plot(app.UIAxes_X, t, x);
    plot(app.UIAxes_Y, t, y);
    plot(app.UIAxes_XY, x, y);
end
