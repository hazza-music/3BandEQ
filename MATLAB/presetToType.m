function [outputText] = presetToType(preset)
%PRESETTOTYPE Naming The Presets for File Outputting
%   This function takes each preset type to give the outputted file a new
%   name. This saves the user from manually naming each outputted file.
%   Very similar to EqParameters.m - Future work should combine the two
%   functions
switch(preset)
    case 0
        outputText = 'Flat';
    case 1
        outputText = '+10dB_Low_Boost';
    case 2
        outputText = '+10dB_Mid_Boost';
    case 3
        outputText = '+10dB_High_Boost';
    case 4
        outputText = '-10dB_Low_Cut';
    case 5
        outputText = '-10dB_Mid_Cut';
    case 6
        outputText = '-10dB_High_Cut';
    case 7
        outputText = 'Custom';
    otherwise
        error('Invalid Input.')
end

