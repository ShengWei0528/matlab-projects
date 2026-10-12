% ------------------------------------------------------------------------
% Plain-text export of the App Designer code stored in Waveform_NOW2.mlapp,
% generated so the code can be read on GitHub. Open the .mlapp in
% App Designer to edit the UI.
% Course: MATLAB / Simulink Fundamentals Lab (電資通基礎MATLAB / Simulink實驗), YZU, Fall 2024
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------

classdef Waveform_NOW2 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure           matlab.ui.Figure
        Slider             matlab.ui.control.Slider
        Label              matlab.ui.control.Label
        CheckBox           matlab.ui.control.CheckBox
        AmpSpinner_2       matlab.ui.control.Spinner
        AmpSpinner_2Label  matlab.ui.control.Label
        AmpSpinner         matlab.ui.control.Spinner
        AmpSpinnerLabel    matlab.ui.control.Label
        freqSlider_2       matlab.ui.control.Slider
        freqSlider_2Label  matlab.ui.control.Label
        freqSlider         matlab.ui.control.Slider
        freqSliderLabel    matlab.ui.control.Label
        UIAxes3            matlab.ui.control.UIAxes
        UIAxes2            matlab.ui.control.UIAxes
        UIAxes             matlab.ui.control.UIAxes
    end


 methods (Access = private)

        function updatePlots(app)
            t = linspace(0, 2*pi, 1000);

            % 取得使用者設定的 Amp、freq 值，以及θ值
            ampX = app.AmpSpinner.Value;
            freqX = app.freqSlider.Value;
            ampY = app.AmpSpinner_2.Value;
            freqY = app.freqSlider_2.Value;
            theta = deg2rad(app.Slider.Value);  % 將θ從度轉換為弧度

            % 計算 x(t) 和 y(t) 的值，加入θ的相位
            x = ampX * cos(freqX * t + theta);
            y = ampY * sin(freqY * t + theta);

            % 定義默認範圍，避免 ylim 的錯誤
            xMax = max(abs(x));
            yMax = max(abs(y));

            % 如果 xMax 或 yMax 為 0，則設置默認範圍
            if xMax == 0
                xMax = 1;
            end
            if yMax == 0
                yMax = 1;
            end

            % 設置合理的範圍限制，防止無限大的問題
            xLimit = max(10, xMax);  % 最大值限制在 10
            yLimit = max(10, yMax);

            % 繪製 x(t) 圖形
            plot(app.UIAxes, t, x, 'b');  % 使用藍色線
            app.UIAxes.Title.String = 'x(t)';
            app.UIAxes.XLabel.String = 'Samples';
            app.UIAxes.YLabel.String = 'Amplitude';
            ylim(app.UIAxes, [-xLimit, xLimit]); % 自動調整 y 軸範圍

            % 繪製 y(t) 圖形
            plot(app.UIAxes2, t, y, 'r');  % 使用紅色線
            app.UIAxes2.Title.String = 'y(t)';
            app.UIAxes2.XLabel.String = 'Samples';
            app.UIAxes2.YLabel.String = 'Amplitude';
            ylim(app.UIAxes2, [-yLimit, yLimit]); % 自動調整 y 軸範圍

            % 繪製 XY Plot，顯示 y(t) 對 x(t) 的關係
            plot(app.UIAxes3, x, y, 'g');  % 使用綠色線
            app.UIAxes3.Title.String = 'XY Plot: y(t) vs. x(t)';
            app.UIAxes3.XLabel.String = 'x(t)';
            app.UIAxes3.YLabel.String = 'y(t)';

            % 設定 XY Plot 的比例，使 x 和 y 軸的比例相同
            pbaspect(app.UIAxes3, [1 1 1]);
            daspect(app.UIAxes3, [1 1 1]);
            xlim(app.UIAxes3, [-xLimit, xLimit]);  % 設置 x 軸範圍
            ylim(app.UIAxes3, [-yLimit, yLimit]);  % 設置 y 軸範圍
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Function to update plots based on current Amp, freq, and noise variance

        end

        % Value changed function: AmpSpinner
        function AmpSpinnerValueChanged(app, event)
            value = app.AmpSpinner.Value;
              updatePlots(app);
        end

        % Value changed function: AmpSpinner_2
        function AmpSpinner_2ValueChanged(app, event)
            value = app.AmpSpinner_2.Value;
             updatePlots(app);
        end

        % Value changed function: freqSlider
        function freqSliderValueChanged(app, event)
            value = app.freqSlider.Value;
            updatePlots(app);
        end

        % Value changed function: freqSlider_2
        function freqSlider_2ValueChanged(app, event)
            value = app.freqSlider_2.Value;
            updatePlots(app);
        end

        % Callback function
        function NoisevarianceEditFieldValueChanged(app, event)
            value = app.NoisevarianceEditField.Value;
            updatePlots(app);
        end

        % Button down function: UIAxes3
        function UIAxes3ButtonDown(app, event)

        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)

        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            delete(app)

        end

        % Value changing function: freqSlider
        function freqSliderValueChanging(app, event)
            changingValue = event.Value;

        end

        % Value changed function: Slider
        function SliderValueChanged(app, event)
            value = app.Slider.Value;
            updatePlots(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1106 574];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'x(t)')
            xlabel(app.UIAxes, 'Samples')
            ylabel(app.UIAxes, 'Amplitude')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Position = [169 421 376 97];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'y(t)')
            xlabel(app.UIAxes2, 'Samples')
            ylabel(app.UIAxes2, 'Amplitude')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [169 158 376 84];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'XY Plot')
            xlabel(app.UIAxes3, 'x(t)')
            ylabel(app.UIAxes3, 'y(t)')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.ButtonDownFcn = createCallbackFcn(app, @UIAxes3ButtonDown, true);
            app.UIAxes3.Position = [628 46 465 500];

            % Create freqSliderLabel
            app.freqSliderLabel = uilabel(app.UIFigure);
            app.freqSliderLabel.HorizontalAlignment = 'right';
            app.freqSliderLabel.Position = [334 375 29 22];
            app.freqSliderLabel.Text = 'freq.';

            % Create freqSlider
            app.freqSlider = uislider(app.UIFigure);
            app.freqSlider.Limits = [0 10];
            app.freqSlider.ValueChangedFcn = createCallbackFcn(app, @freqSliderValueChanged, true);
            app.freqSlider.ValueChangingFcn = createCallbackFcn(app, @freqSliderValueChanging, true);
            app.freqSlider.MinorTicks = [0 1 2 3 4 5 6 7 8 9 10];
            app.freqSlider.Position = [384 384 150 3];

            % Create freqSlider_2Label
            app.freqSlider_2Label = uilabel(app.UIFigure);
            app.freqSlider_2Label.HorizontalAlignment = 'right';
            app.freqSlider_2Label.Position = [334 115 29 22];
            app.freqSlider_2Label.Text = 'freq.';

            % Create freqSlider_2
            app.freqSlider_2 = uislider(app.UIFigure);
            app.freqSlider_2.Limits = [0 10];
            app.freqSlider_2.ValueChangedFcn = createCallbackFcn(app, @freqSlider_2ValueChanged, true);
            app.freqSlider_2.MinorTicks = [0 1 2 3 4 5 6 7 8 9 10];
            app.freqSlider_2.Position = [384 124 150 3];

            % Create AmpSpinnerLabel
            app.AmpSpinnerLabel = uilabel(app.UIFigure);
            app.AmpSpinnerLabel.HorizontalAlignment = 'right';
            app.AmpSpinnerLabel.Position = [80 524 33 22];
            app.AmpSpinnerLabel.Text = 'Amp.';

            % Create AmpSpinner
            app.AmpSpinner = uispinner(app.UIFigure);
            app.AmpSpinner.ValueChangedFcn = createCallbackFcn(app, @AmpSpinnerValueChanged, true);
            app.AmpSpinner.Position = [128 524 42 22];

            % Create AmpSpinner_2Label
            app.AmpSpinner_2Label = uilabel(app.UIFigure);
            app.AmpSpinner_2Label.HorizontalAlignment = 'right';
            app.AmpSpinner_2Label.Position = [82 262 33 22];
            app.AmpSpinner_2Label.Text = 'Amp.';

            % Create AmpSpinner_2
            app.AmpSpinner_2 = uispinner(app.UIFigure);
            app.AmpSpinner_2.ValueChangedFcn = createCallbackFcn(app, @AmpSpinner_2ValueChanged, true);
            app.AmpSpinner_2.Position = [130 262 40 22];

            % Create CheckBox
            app.CheckBox = uicheckbox(app.UIFigure);
            app.CheckBox.Position = [-9 572 80 22];

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [44 68 25 22];
            app.Label.Text = 'θ';

            % Create Slider
            app.Slider = uislider(app.UIFigure);
            app.Slider.Limits = [0 90];
            app.Slider.MajorTicks = [0 45 90];
            app.Slider.ValueChangedFcn = createCallbackFcn(app, @SliderValueChanged, true);
            app.Slider.MinorTicks = [0 45 90];
            app.Slider.Position = [90 77 150 3];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Waveform_NOW2

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
