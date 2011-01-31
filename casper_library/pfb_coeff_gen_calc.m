%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2008 Terry Filiba                                           %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function coeff_vector = pfb_coeff_gen_calc(PFBSize,TotalTaps,WindowType,n_inputs,nput,fwidth,a)
% Calculate the bram coeffiecients for the pfb_coeff_gen block
%
% coeff_vector = pfb_coeff_gen_calc(PFBSize,n_inputs,a)
% 
% Valid varnames for this block are:
% PFBSize = Size of the FFT (2^FFTSize points).
% TotalTaps = Total number of taps in the PFB
% WindowType = The type of windowing function to use.
% n_inputs = Number of parallel input streams
% nput = Which input this is (of the n_inputs parallel).
% fwidth = The scaling of the bin width (1 is normal).
% a = Index of this rom (passing less than 0 will return all coefficients).

% Set coefficient vector
alltaps = TotalTaps*2^PFBSize;
windowval = transpose(window(WindowType, alltaps));
total_coeffs = windowval .* sinc(fwidth*([0:alltaps-1]/(2^PFBSize)-TotalTaps/2));
if a < 0
    coeff_vector = total_coeffs;
else
    for i=1:alltaps/2^n_inputs,
        buf(i)=total_coeffs((i-1)*2^n_inputs + nput + 1);
    end
    coeff_vector = buf((a-1)*2^(PFBSize-n_inputs)+1 : a*2^(PFBSize-n_inputs));
end
