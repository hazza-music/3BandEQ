function [audioOut] = LoudnessWeighting(loudnessChoice,audioIn,fs)
% Description: This function takes the input audio and provides an equalised
% loudness percieved by the human ear. It uses the common A weighting curve
% defined by Fletcher-Munsen. The choice is given for the extra filter or
% not to the user. Output is levelled by the A weighting curve relative to
% the sample rate.
%
% INPUTS
% loudnessChoice - yes/no loudness levelling
% audioIn - Audio to level
% fs - sampling frequency
%
% OUTPUT
% audioOut - Weighted/Unweighted Audio

switch(loudnessChoice)
    case 0
        % no levelling
        audioOut = audioIn;
    case 1
        % A weighting
        weightFilt = weightingFilter('A-weighting',fs);
        audioOut = weightFilt(audioIn);
    otherwise
        error('Invalid Input.')
end
end

