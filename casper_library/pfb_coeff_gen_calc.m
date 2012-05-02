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

function coeff_vector = pfb_coeff_gen_calc(window_function, pfb_bits, pfb_taps, tap_num, par_bits, input_num, bin_scaling, debug)
% Calculate the bram coeffiecients for the pfb_coeff_gen block
% 
% Valid varnames for this block are:
% window_function = the type of windowing function to use
% pfb_bits = 2^pfb_bits = size of the FFT (2^FFTSize points)
% pfb_taps = total number of taps in the PFB
% tap_num = ZERO-indexed - index of this tap coeff rom (<0 will return all coefficients)
% par_bits = 2^par_bits = number of parallel input streams
% input_num = ZERO-indexed - which input this is, of par_bits parallel inputs
% bin_scaling = the scaling of the bin width (1 is normal)
% debug = return debug coefficients, just a ramp distributed over all the taps, 1 : alltaps

% set the coefficient vector
alltaps = pfb_taps * 2^pfb_bits;
windowval = transpose(window(window_function, alltaps));
total_coeffs = windowval .* sinc(bin_scaling * ((0:alltaps - 1) / (2^pfb_bits) - pfb_taps / 2));
if tap_num < 0
    coeff_vector = total_coeffs;
else
    if debug == 1
        buf = input_num + 1 : 2^par_bits : alltaps;
    else
        buf = total_coeffs(input_num + 1 : 2^par_bits : alltaps);
    end
    s_index = (tap_num * 2^(pfb_bits - par_bits)) + 1;
    e_index = (tap_num + 1) * 2^(pfb_bits - par_bits);
    coeff_vector = buf(s_index : e_index);
end
