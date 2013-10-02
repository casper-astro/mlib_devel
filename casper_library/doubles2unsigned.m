% doubles2unsigned(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telesope                                                      %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2013 Andrew Martens                                         %
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

function[dout, result] = doubles2unsigned(din, n_bits, bin_pt),
  log_group = 'doubles2unsigned_debug';
  dout = [];
  result = -1;

  [r,c] = size(din);  

  if c*n_bits > 64,
    clog('We can''t process a combined bit width greater than 64 bits',{'error', log_group});
    error('We can''t process a combined bit width greater than 64 bits');
  end

  step    = 2^(-1*bin_pt);

  %max, min and step values representable with specified output
  top_bits = n_bits;
  top     = 2^(top_bits-bin_pt-1) - step;
  bottom = -1*2^(top_bits-bin_pt-1);  

  clog(['bottom: ', num2str(bottom), ' step: ', num2str(step), ' top: ', num2str(top)], log_group);

  %quantise
  din_quantised = round(din./step).*step;

  %saturate max values to prevent wrapping
  smax_i = find(din_quantised > top);
  smin_i = find(din_quantised < bottom);
  din_saturated = din_quantised;
  
  din_saturated(smax_i) = top;
  din_saturated(smin_i) = bottom;

%  din_saturated_ref = fi(din, true, n_bits, bin_pt);

  din_wrapped = din_saturated;
 
  %wrap negative values 
  ni = find(din_wrapped < 0);

  for n = 1:length(ni),
    din_wrapped(ni(n)) = (top + step)*2 + din_wrapped(ni(n)); 
  end %for
 
  %wraps negative component so can get back when positive
%  din_wrapped_ref = fi(din_saturated_ref, false, n_bits, bin_pt, 'OverflowMode', 'wrap');

  din_shifted = din_wrapped;

  %shift vectors up 
  for vi = 1:c,
    base = (vi-1) * n_bits;                             % initial shift
    shift = base + bin_pt;                             % shift including binary point    
    din_shifted(:,c-vi+1) = 2^shift.*din_shifted(:,c-vi+1); 

%    temp = fi(din_wrapped_ref(:,c-vi+1), false, n_bits*(1+vi), bin_pt);
%    temp = bitshift(temp, shift);
%    din_shifted_ref(:,c-vi+1) = double(temp);
  end %for  

  if c > 1, dout = sum(din_shifted'); % add them all to concatenate
  else, dout = din_shifted;
  end
 
  result = 0;

end %function
