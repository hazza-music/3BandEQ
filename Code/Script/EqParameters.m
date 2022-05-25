function [G_low,G_mid,G_high] = EqParameters(preset)

% DESCRIPTION:
% This function returns the input parameters for the function
% ParametricEqualizer_Simple.m, namely the gains of low shelf, mid peak and
% high shelf, corresponding to the preset value selected.
% 
% INPUTS:
% preset - number indicating which preset was selected
% 
% OUTPUTS:
% G_low - gain of low shelf
% G_mid - gain of mid peak
% G_high - gain of high shelf

switch(preset)
    case 0
        % Flat
        G_low = 0;
        G_mid = 0;
        G_high = 0;
    case 1
        % +10dB Low Boost
        G_low = 10;
        G_mid = 0;
        G_high = 0;
    case 2
        % +10dB Mid Boost
        G_low = 0;
        G_mid = 10;
        G_high = 0;
    case 3
        % +10dB High Boost
        G_low = 0;
        G_mid = 0;
        G_high = 10;
    case 4
        % -10dB Low Cut
        G_low = -10;
        G_mid = 0;
        G_high = 0;
    case 5
        % -10dB Mid Cut
        G_low = 0;
        G_mid = -10;
        G_high = 0;
    case 6
        % -10dB High Cut
        G_low = 0;
        G_mid = 0;
        G_high = -10;
    case 7
        % Custom
        G_low = input('\nEnter the gain for low shelf: ');
        G_mid = input('Enter the gain for mid peak: ');
        G_high = input('Enter the gain for high shelf: ');
    otherwise
        error('Invalid Input.')
end

end