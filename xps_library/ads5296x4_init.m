%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2013 David MacMahon
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


function ads5296x4_init(blk, varargin)

try
  clog('ads5296x4_init: pre same_state','trace');

  defaults = { ...
    'block_name', blk, ...
    'board_count', '1' ...
  };
  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  clog('ads5296x4_init: post same_state','trace');

  check_mask_type(blk, 'ADS5296x4');
  munge_block(blk, varargin{:});
  delete_lines(blk);

  gw_name = clear_name(blk);

  board_count = get_var('board_count', 'defaults', defaults, varargin{:});

  chips = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p'};

  x =  0;
  y = 20;

  for chip=1:4*board_count
    for channel=1:4
      port_num = num2str((chip-1)*4 + channel);
      inport_name  = sprintf('%s%d_sim', chips{chip}, channel);
      gateway_name = sprintf('%s_%s%d', gw_name, chips{chip}, channel);
      outport_name = sprintf('%s%d', chips{chip}, channel);

      inport_pos  = [x+ 20, y,   x+ 20+30, y+14];
      gateway_pos = [x+100, y-3, x+100+70, y+17];
      outport_pos = [x+210, y,   x+210+30, y+14];
      y = y + 50;

      reuse_block(blk, inport_name, 'built-in/inport', ...
        'Port', port_num, ...
        'Position', inport_pos);

      reuse_block(blk, gateway_name, 'xbsIndex_r4/Gateway In', ...
        'arith_type', 'Signed', ...
        'n_bits', '10', ...
        'bin_pt', '9', ...
        'Position', gateway_pos);

      reuse_block(blk, outport_name, 'built-in/outport', ...
        'Port', port_num, ...
        'Position', outport_pos);


      add_line(blk, [inport_name,  '/1'], [gateway_name, '/1']);
      h=add_line(blk, [gateway_name, '/1'], [outport_name, '/1']);
      set_param(h, 'Name', outport_name);
    end
    if mod(chip, 4) == 0
      % Next column
      x = x + 210+30+50;
      y = 20;
    end
  end
  
  % sync input
  
  gateway_name = sprintf('%s_adc_sync', gw_name);
  port_num = num2str(4*board_count*4 + 1);
  inport_pos  = [x+ 20, y,   x+ 20+30, y+14];
  gateway_pos = [x+100, y-3, x+100+70, y+17];
  term_pos = [x+190, y-3, x+200, y+17];
  y = y + 50;
  reuse_block(blk, 'sync', 'built-in/inport', ...
        'Port', port_num, ...
        'Position', inport_pos);
  reuse_block(blk, gateway_name, 'xbsIndex_r4/Gateway Out', ...
        'Position', gateway_pos);
  reuse_block(blk, 'sync_term', 'built-in/terminator', ...
        'Position', term_pos);
  add_line(blk, ['sync',  '/1'], [gateway_name, '/1']);
  add_line(blk, [gateway_name,  '/1'], ['sync_term', '/1']);

  % reset input

  gateway_name = sprintf('%s_adc_rst', gw_name);
  port_num = num2str(4*board_count*4 + 2);
  inport_pos  = [x+ 20, y,   x+ 20+30, y+14];
  gateway_pos = [x+100, y-3, x+100+70, y+17];
  term_pos = [x+190, y-3, x+200, y+17];
  y = y + 50;
  reuse_block(blk, 'rst', 'built-in/inport', ...
        'Port', port_num, ...
        'Position', inport_pos);
  reuse_block(blk, gateway_name, 'xbsIndex_r4/Gateway Out', ...
        'Position', gateway_pos);
  reuse_block(blk, 'rst_term', 'built-in/terminator', ...
        'Position', term_pos);

  add_line(blk, ['rst',  '/1'], [gateway_name, '/1']);
  add_line(blk, [gateway_name,  '/1'], ['rst_term', '/1']);
  
  % snapshot trigger input

  gateway_name = sprintf('%s_snapshot_ext_trigger', gw_name);
  port_num = num2str(4*board_count*4 + 2);
  inport_pos  = [x+ 20, y,   x+ 20+30, y+14];
  gateway_pos = [x+100, y-3, x+100+70, y+17];
  term_pos = [x+190, y-3, x+200, y+17];
  y = y + 50;
  reuse_block(blk, 'snapshot_trig', 'built-in/inport', ...
        'Port', port_num, ...
        'Position', inport_pos);
  reuse_block(blk, gateway_name, 'xbsIndex_r4/Gateway Out', ...
        'Position', gateway_pos);
  reuse_block(blk, 'snapshot_trig_term', 'built-in/terminator', ...
        'Position', term_pos);

  add_line(blk, ['snapshot_trig',  '/1'], [gateway_name, '/1']);
  add_line(blk, [gateway_name,  '/1'], ['snapshot_trig_term', '/1']);
  
  % sync out
  
  gateway_name = sprintf('%s_adc_sync_out', gw_name);
  port_num = num2str(4*board_count*4 + 3);
  inport_pos  = [x+ 20, y,   x+ 20+30, y+14];
  gateway_pos = [x+100, y-3, x+100+70, y+17];
  outport_pos = [x+190, y-3, x+200, y+17];
  y = y + 50;
  reuse_block(blk, 'sim_sync_out', 'built-in/inport', ...
        'Port', port_num, ...
        'Position', inport_pos);
  reuse_block(blk, gateway_name, 'xbsIndex_r4/Gateway In', ...
        'arith_type', 'Boolean', ...
        'Position', gateway_pos);
  reuse_block(blk, 'sync_out', 'built-in/outport', ...
        'Position', outport_pos);

  add_line(blk, ['sim_sync_out',  '/1'], [gateway_name, '/1']);
  add_line(blk, [gateway_name,  '/1'], ['sync_out', '/1']);

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});

  clog('ads5296x4_init: exiting','trace');

catch ex
  dump_and_rethrow(ex);
end % try/catch
end % function
