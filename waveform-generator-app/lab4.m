% ------------------------------------------------------------------------
% Plain-text export of the App Designer code stored in lab4.mlapp,
% generated so the code can be read on GitHub. Open the .mlapp in
% App Designer to edit the UI.
% Course: MATLAB / Simulink Fundamentals Lab (電資通基礎MATLAB / Simulink實驗), YZU, Fall 2024
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------

classdef lab4 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        MATLABSimulinkL4Label  matlab.ui.control.Label
        TabGroup               matlab.ui.container.TabGroup
        Tab                    matlab.ui.container.Tab
        outputLabel            matlab.ui.control.Label
        inputLabel             matlab.ui.control.Label
        CalculateButton        matlab.ui.control.Button
        bEditField             matlab.ui.control.NumericEditField
        bEditFieldLabel        matlab.ui.control.Label
        aEditField             matlab.ui.control.NumericEditField
        aEditFieldLabel        matlab.ui.control.Label
        abEditField_4          matlab.ui.control.NumericEditField
        abEditField_4Label     matlab.ui.control.Label
        abEditField_3          matlab.ui.control.NumericEditField
        abEditField_3Label     matlab.ui.control.Label
        abEditField_2          matlab.ui.control.NumericEditField
        abEditField_2Label     matlab.ui.control.Label
        abEditField            matlab.ui.control.NumericEditField
        abEditFieldLabel       matlab.ui.control.Label
        Tab2                   matlab.ui.container.Tab
        freqSlider             matlab.ui.control.Slider
        freqSliderLabel        matlab.ui.control.Label
        AmpSpinner             matlab.ui.control.Spinner
        AmpSpinnerLabel        matlab.ui.control.Label
        UIAxes                 matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: CalculateButton
        function CalculateButtonPushed(app, event)
            app.abEditField.Value = app.aEditField.Value + app.bEditField.Value
            app.abEditField_2.Value = app.aEditField.Value - app.bEditField.Value
            app.abEditField_3.Value = app.aEditField.Value * app.bEditField.Value
            app.abEditField_4.Value = app.aEditField.Value / app.bEditField.Value
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 845 666];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [36 53 734 485];

            % Create Tab
            app.Tab = uitab(app.TabGroup);
            app.Tab.Title = 'Tab';

            % Create abEditFieldLabel
            app.abEditFieldLabel = uilabel(app.Tab);
            app.abEditFieldLabel.HorizontalAlignment = 'right';
            app.abEditFieldLabel.FontSize = 20;
            app.abEditFieldLabel.Position = [493 313 39 26];
            app.abEditFieldLabel.Text = 'a+b';

            % Create abEditField
            app.abEditField = uieditfield(app.Tab, 'numeric');
            app.abEditField.FontSize = 20;
            app.abEditField.Position = [547 312 100 27];

            % Create abEditField_2Label
            app.abEditField_2Label = uilabel(app.Tab);
            app.abEditField_2Label.HorizontalAlignment = 'right';
            app.abEditField_2Label.FontSize = 20;
            app.abEditField_2Label.Position = [498 239 34 26];
            app.abEditField_2Label.Text = 'a-b';

            % Create abEditField_2
            app.abEditField_2 = uieditfield(app.Tab, 'numeric');
            app.abEditField_2.FontSize = 20;
            app.abEditField_2.Position = [547 238 100 27];

            % Create abEditField_3Label
            app.abEditField_3Label = uilabel(app.Tab);
            app.abEditField_3Label.HorizontalAlignment = 'right';
            app.abEditField_3Label.FontSize = 20;
            app.abEditField_3Label.Position = [495 153 35 26];
            app.abEditField_3Label.Text = 'a*b';

            % Create abEditField_3
            app.abEditField_3 = uieditfield(app.Tab, 'numeric');
            app.abEditField_3.FontSize = 20;
            app.abEditField_3.Position = [545 152 100 27];

            % Create abEditField_4Label
            app.abEditField_4Label = uilabel(app.Tab);
            app.abEditField_4Label.HorizontalAlignment = 'right';
            app.abEditField_4Label.FontSize = 20;
            app.abEditField_4Label.Position = [493 68 33 26];
            app.abEditField_4Label.Text = 'a/b';

            % Create abEditField_4
            app.abEditField_4 = uieditfield(app.Tab, 'numeric');
            app.abEditField_4.FontSize = 20;
            app.abEditField_4.Position = [541 67 100 27];

            % Create aEditFieldLabel
            app.aEditFieldLabel = uilabel(app.Tab);
            app.aEditFieldLabel.HorizontalAlignment = 'right';
            app.aEditFieldLabel.FontSize = 20;
            app.aEditFieldLabel.Position = [101 287 25 26];
            app.aEditFieldLabel.Text = 'a';

            % Create aEditField
            app.aEditField = uieditfield(app.Tab, 'numeric');
            app.aEditField.FontSize = 20;
            app.aEditField.Position = [141 286 100 27];
            app.aEditField.Value = 20;

            % Create bEditFieldLabel
            app.bEditFieldLabel = uilabel(app.Tab);
            app.bEditFieldLabel.HorizontalAlignment = 'right';
            app.bEditFieldLabel.FontSize = 20;
            app.bEditFieldLabel.Position = [101 203 25 26];
            app.bEditFieldLabel.Text = 'b';

            % Create bEditField
            app.bEditField = uieditfield(app.Tab, 'numeric');
            app.bEditField.FontSize = 20;
            app.bEditField.Position = [141 202 100 27];
            app.bEditField.Value = 40;

            % Create CalculateButton
            app.CalculateButton = uibutton(app.Tab, 'push');
            app.CalculateButton.ButtonPushedFcn = createCallbackFcn(app, @CalculateButtonPushed, true);
            app.CalculateButton.Position = [122 109 138 45];
            app.CalculateButton.Text = 'Calculate';

            % Create inputLabel
            app.inputLabel = uilabel(app.Tab);
            app.inputLabel.FontSize = 40;
            app.inputLabel.FontWeight = 'bold';
            app.inputLabel.Position = [113 365 116 52];
            app.inputLabel.Text = 'input:';

            % Create outputLabel
            app.outputLabel = uilabel(app.Tab);
            app.outputLabel.FontSize = 40;
            app.outputLabel.FontWeight = 'bold';
            app.outputLabel.Position = [498 365 143 52];
            app.outputLabel.Text = 'output:';

            % Create Tab2
            app.Tab2 = uitab(app.TabGroup);
            app.Tab2.Title = 'Tab2';

            % Create UIAxes
            app.UIAxes = uiaxes(app.Tab2);
            title(app.UIAxes, 'XY')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [303 105 396 221];

            % Create AmpSpinnerLabel
            app.AmpSpinnerLabel = uilabel(app.Tab2);
            app.AmpSpinnerLabel.HorizontalAlignment = 'right';
            app.AmpSpinnerLabel.Position = [126 265 30 22];
            app.AmpSpinnerLabel.Text = 'Amp';

            % Create AmpSpinner
            app.AmpSpinner = uispinner(app.Tab2);
            app.AmpSpinner.Position = [171 265 44 22];

            % Create freqSliderLabel
            app.freqSliderLabel = uilabel(app.Tab2);
            app.freqSliderLabel.HorizontalAlignment = 'right';
            app.freqSliderLabel.Position = [57 84 26 22];
            app.freqSliderLabel.Text = 'freq';

            % Create freqSlider
            app.freqSlider = uislider(app.Tab2);
            app.freqSlider.Limits = [0 6];
            app.freqSlider.Position = [104 93 150 3];

            % Create MATLABSimulinkL4Label
            app.MATLABSimulinkL4Label = uilabel(app.UIFigure);
            app.MATLABSimulinkL4Label.BackgroundColor = [0.149 0.149 0.149];
            app.MATLABSimulinkL4Label.FontSize = 48;
            app.MATLABSimulinkL4Label.FontColor = [1 1 1];
            app.MATLABSimulinkL4Label.Position = [15 562 817 62];
            app.MATLABSimulinkL4Label.Text = '電資通基礎MATLAB / Simulink實驗 L4';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = lab4

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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
