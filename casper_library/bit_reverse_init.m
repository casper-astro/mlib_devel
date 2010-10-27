% Initialize and populate a bit_reverse block.
%
% bit_reverse_init(blk, varargin)
%
% blk = The block to initialize.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% n_bits = The number of input bits to reverse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
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

function bit_reverse_init(blk,varargin)

check_mask_type(blk, 'bit_reverse');
if same_state(blk, varargin{:}), return, end
munge_block(blk, varargin{:});
n_bits = get_var('n_bits',varargin{:});

% When dynamically drawing blocks, first delete all lines in a system.
delete_lines(blk);

% Draw blocks and lines, using 'reuse_block' to efficiently instantiate blocks.
if n_bits <= 1,
    add_line(blk,'in/1','out/1');
else
    % Always propagate variables by value (num2str)
    reuse_block(blk, 'concat', 'xbsIndex_r4/Concat', ...
        'Position',[450 100 500 100+n_bits*20],'num_inputs',num2str(n_bits));
    for i=n_bits-1:-1:0,
        bitname=['bit' num2str(i)];
        reuse_block(blk, bitname, 'xbsIndex_r4/Slice', ...
            'Position',[100 100+i*40 140 120+i*40], ...
            'mode','Lower Bit Location + Width', ...
            'nbits', '1', 'bit0', num2str(i));
        add_line(blk,'in/1',[bitname,'/1'],'autorouting','on');
        add_line(blk,[bitname,'/1'],['concat/',num2str(i+1)],'autorouting','on');
    end
    add_line(blk,'concat/1','out/1','autorouting','on');
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('%d bits',n_bits);
set_param(blk,'AttributesFormatString',annotation);

save_state(blk,varargin{:});              % Save and back-populate mask parameter values

