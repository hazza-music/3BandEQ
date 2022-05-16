function [b,a] = PeakingFilter(fs,G)
% DESCRIPTION:
% This function calculates the denominator and numerator coefficients of 
% the transfer function for a peak filter defined by the required sampling
% frequency and gain of the filter. The center frequency and bandwidth both
% are fixed at 1kHz. The final b & a coefficients are approximated to the
% value 1 in the case of nearly flat response so as to avoid any errors
% with the usage of invfreqz function.
% 
% INPUTS:
% fs - sampling frequency
% G - gain of the filter
% 
% OUTPUTS:
% b - numerator coefficients of transfer function of filter
% a - denominator coefficients of transfer function of filter

% Approximation taken to avoid error in determining transfer function
% coefficients of created final equalizer filter
if abs(G) <= 0.01
    b = 1;
    a = 1;
else
    K = tan(pi*1000/fs);
    V0 = 10^(G/20);
    Q=1;
    if (G>=0)
    % Boost
        b0 = (1+V0*K/Q+K^2)/(1+K/Q+K^2);
        b1 = 2*(K^2-1)/(1+K/Q+K^2);
        b2 = (1-V0*K/Q+K^2)/(1+K/Q+K^2);
        a1 = 2*(K^2-1)/(1+K/Q+K^2);
        a2 = (1-K/Q+K^2)/(1+K/Q+K^2);

    else
    % Cut
        b0 = (1+K/Q+K^2)/(1+K/(V0*Q)+K^2);
        b1 = 2*(K^2-1)/(1+K/(V0*Q)+K^2);
        b2 = (1-K/Q+K^2)/(1+K/(V0*Q)+K^2);
        a1 = 2*(K^2-1)/(1+K/(V0*Q)+K^2);
        a2 = (1-K/(V0*Q)+K^2)/(1+K/(V0*Q)+K^2);

    end
    a = [1, a1, a2];
    b = [b0, b1, b2];
end

end