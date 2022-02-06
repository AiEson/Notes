function [fitresult, gof] = createFit1(year, population)
%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( year, population );

% Set up fittype and options.
ft = fittype( 'xm/(1+(xm/3.9-1)*exp(-r*(t-1790)))', 'independent', 't', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.678735154857773 0.743132468124916];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'population vs. year', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'year', 'Interpreter', 'none' );
ylabel( 'population', 'Interpreter', 'none' );
grid on


