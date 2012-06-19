function cmult_dsp48e_init (blk, varargin)
% Initialize and configure a cmult_dsp48e block.
%
% cmult_dsp48e_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs.
%
% Valid varnames:
% * n_bits_a
% * bin_pt_a
% * n_bits_b
% * bin_pt_b
% * conjugated
% * full_precision
% * n_bits_c
% * bin_pt_c
% * quantization
% * overflow
% * cast_latency

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2010 William Mallard                                        %
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

% Set default vararg values.
defaults = { ...
  'n_bits_a', 18, ...
  'bin_pt_a', 17, ...
  'n_bits_b', 18, ...
  'bin_pt_b', 17, ...
  'conjugated', 'off', ...
  'full_precision', 'on', ...
  'n_bits_c', 37, ...
  'bin_pt_c', 34, ...
  'quantization', 'Truncate', ...
  'overflow', 'Wrap', ...
  'cast_latency', 0, ...
};

% Skip init script if mask state has not changed.
if same_state(blk, 'defaults', defaults, varargin{:}),
  return
end

% Verify that this is the right mask for the block.
check_mask_type(blk, 'cmult_dsp48e');

% Disable link if state changes from default.
munge_block(blk, varargin{:});

% Retrieve input fields.
n_bits_a = get_var('n_bits_a', 'defaults', defaults, varargin{:});
bin_pt_a = get_var('bin_pt_a', 'defaults', defaults, varargin{:});
n_bits_b = get_var('n_bits_b', 'defaults', defaults, varargin{:});
bin_pt_b = get_var('bin_pt_b', 'defaults', defaults, varargin{:});
conjugated = get_var('conjugated', 'defaults', defaults, varargin{:});
full_precision = get_var('full_precision', 'defaults', defaults, varargin{:});
n_bits_c = get_var('n_bits_c', 'defaults', defaults, varargin{:});
bin_pt_c = get_var('bin_pt_c', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
cast_latency = get_var('cast_latency', 'defaults', defaults, varargin{:});

% Validate input fields.

if (n_bits_a < 1),
	errordlg([blk, ': Input ''a'' bit width must be greater than 0.']);
	return
end

if (n_bits_b < 1),
	errordlg([blk, ': Input ''b'' bit width must be greater than 0.']);
	return
end

if (n_bits_c < 1),
	errordlg([blk, ': Output ''c'' bit width must be greater than 0.']);
	return
end

if (n_bits_a > 25),
	errordlg([blk, ': Input ''a'' bit width cannot exceed 25.']);
	return
end

if (n_bits_b > 18),
	errordlg([blk, ': Input ''b'' bit width cannot exceed 18.']);
	return
end

if (bin_pt_a < 0),
	errordlg([blk, ': Input ''a'' binary point must be greater than 0.']);
	return
end

if (bin_pt_b < 0),
	errordlg([blk, ': Input ''b'' binary point must be greater than 0.']);
	return
end

if (bin_pt_c < 0),
	errordlg([blk, ': Output ''c'' binary point must be greater than 0.']);
	return
end

if (bin_pt_a > n_bits_a),
  errordlg([blk, ': Input ''a'' binary point cannot exceed bit width.']);
  return
end

if (bin_pt_b > n_bits_b),
  errordlg([blk, ': Input ''b'' binary point cannot exceed bit width.']);
  return
end

if (bin_pt_c > n_bits_c),
  errordlg([blk, ': Output ''c'' binary point cannot exceed bit width.']);
  return
end

% Calculate bit widths and binary points.
bin_pt_reinterp = bin_pt_a + bin_pt_b;
if strcmp(full_precision, 'on'),
  n_bits_out = n_bits_a + n_bits_b + 1;
  bin_pt_out = bin_pt_a + bin_pt_b;
else,
  n_bits_out = n_bits_c;
  bin_pt_out = bin_pt_c;
end

% Update sub-block parameters.

set_param([blk, '/realign_a_re'], ...
    'n_bits', num2str(n_bits_a), ...
    'bin_pt', num2str(bin_pt_a));
set_param([blk, '/realign_a_im'], ...
    'n_bits', num2str(n_bits_a), ...
    'bin_pt', num2str(bin_pt_a));
set_param([blk, '/realign_b_re'], ...
    'n_bits', num2str(n_bits_b), ...
    'bin_pt', num2str(bin_pt_b));
set_param([blk, '/realign_b_im'], ...
    'n_bits', num2str(n_bits_b), ...
    'bin_pt', num2str(bin_pt_b));

set_param([blk, '/reinterp_c_re'], ...
    'bin_pt', num2str(bin_pt_reinterp));
set_param([blk, '/reinterp_c_im'], ...
    'bin_pt', num2str(bin_pt_reinterp));

set_param([blk, '/cast_c_re'], ...
    'n_bits', num2str(n_bits_out), ...
    'bin_pt', num2str(bin_pt_out), ...
    'latency', num2str(cast_latency));
set_param([blk, '/cast_c_im'], ...
    'n_bits', num2str(n_bits_out), ...
    'bin_pt', num2str(bin_pt_out), ...
    'latency', num2str(cast_latency));

% Set conjugation mode.

if strcmp(conjugated, 'on'),
    set_param([blk, '/alumode0'], 'const', '3');
    set_param([blk, '/alumode3'], 'const', '0');
else,
    set_param([blk, '/alumode0'], 'const', '0');
    set_param([blk, '/alumode3'], 'const', '3');
end

% Set attribute format string (block annotation).
annotation_fmt = '%d_%d * %d_%d ==> %d_%d\nLatency=%d';
annotation = sprintf(annotation_fmt, ...
  n_bits_a, bin_pt_a, ...
  n_bits_b, bin_pt_b, ...
  n_bits_out, bin_pt_out, ...
  4+cast_latency);
set_param(blk, 'AttributesFormatString', annotation);

% Save block state to stop repeated init script runs.
save_state(blk, 'defaults', defaults, varargin{:});

