%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
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

function [max_gain bit_growth adder_n_bits_out adder_bin_pt_out] = pfb_bitgrowth_calcs(window_type, pfb_bits, total_taps, par_input_bits, bin_scaling, data_bitwidth, coeff_bitwidth)

% Compute the maximum gain through all of the 2^PFBSize sub-filters.  This is
% used to determine how much bit growth is really needed.  The gain of each
% filter is the sum of the absolute values of its coefficients.  The maximum of
% these gains sets the upper bound on bit growth through the pfb_fir.  The
% products, partial sums, and final sum throughout the pfb_fir (including the
% adder tree) need not accomodate any more bit growth than the absolute maximum
% gain requires, provided that any "overflow" is ignored (i.e. set to "Wrap").
% This works thanks to the wonders of modulo math.  Note that the "gain" for
% typical signals will be different (less) than the absolute maximum gain of
% each filter.  For Gaussian noise, the gain of a filter is the square root of
% the sum of the squares of the coefficients (aka root-sum-squares or RSS).

% Get all coefficients of the pfb_fir in one vector (by passing -1 for the tap index)
all_coeffs = pfb_coeff_gen_calc(window_type, pfb_bits, total_taps, -1, par_input_bits, 0, bin_scaling, 0, false);
% Rearrange into matrix with 2^PFBSize rows and TotalTaps columns.
% Each row contains coefficients for one sub-filter.
all_filters = reshape(all_coeffs, 2^pfb_bits, total_taps);
% Compute max gain (make sure it is at least 1).
% NB: sum rows, not columns!
max_gain = max(sum(abs(all_filters), 2));
if max_gain < 1
    max_gain = 1;
end
% Compute bit growth
bit_growth = nextpow2(max_gain);
% Compute adder output width and binary point.  We know that the adders in the
% adder tree need to have (bit_growth+1) non-fractional bits to accommodate the
% maximum gain.  The products from the taps will have
% (BitWidthIn+CoeffBitWidth-2) fractional bits.  We will preserve them through
% the adder tree.
adder_bin_pt_out = data_bitwidth + coeff_bitwidth - 2;
adder_n_bits_out = bit_growth + 1 + adder_bin_pt_out;

%end