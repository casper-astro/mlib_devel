% generic adc initialisation script 
%
% function generic_adc_init(blk, varargin) 
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% interleaved = simulate interleaved adcs
% in = number of inputs
% out = number of outputs per input (ADC demux factor)
% bits = simulated ADC resolution
% or_spport = simulate ADC over-range detection
% sync_support = simulate ADC with sync line
% dv_support = ADC with data valid output

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telescope Project                                             %
%   www.ska.ac.za                                                             %
%   Copyright (C) 2010 Andrew Martens SKA/SA                                  %
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

function generic_adc_init(blk, varargin)

  clog('generic_adc_init: pre same_state','trace');

  defaults = { 'in', 2, 'out', 4, 'bits', 8, 'interleaved', 'off', ...
    'or_support', 'off', 'sync_support', 'off', 'dv_support', 'off'};
  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  clog('generic_adc_init: post same_state','trace');

  check_mask_type(blk, 'generic_adc');
  munge_block(blk, varargin{:});
  delete_lines(blk);

  interleaved = get_var('interleaved', 'defaults', defaults, varargin{:});
  in = get_var('in', 'defaults', defaults, varargin{:});
  out = get_var('out', 'defaults', defaults, varargin{:});
  bits = get_var('bits', 'defaults', defaults, varargin{:});
  or_support = get_var('or_support', 'defaults', defaults, varargin{:});
  sync_support = get_var('sync_support', 'defaults', defaults, varargin{:});
  dv_support = get_var('dv_support', 'defaults', defaults, varargin{:});
  
  or_per_input = 1;
 
  clog('generic_adc_init: drawing common adc','trace');
  xtick = 120; 
  if strcmp(or_support,'on'), or = 1; else, or = 0; end
  ytick = 40+5*out*or; 
  
  yoff = adc_common(blk, 'in', in, 'out', out, 'bits', bits, 'or_per_input', or_per_input, ...
    'xoff', 0, 'xtick', xtick, 'yoff', 0, 'ytick', ytick, ...
    'adc_interleave', interleaved, 'or_support', ...
    or_support, 'sync_support', sync_support, 'dv_support', dv_support);
  
  clog('generic_adc_init: done drawing common adc','trace');

  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('generic_adc_init: exiting','trace');

end
