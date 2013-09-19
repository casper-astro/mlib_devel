% Generate cos/sin
%
% cosin_init(blk, varargin)
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

%TODO logic for where conditions don't allow optimization 

function cosin_init(blk,varargin)

  clog('entering cosin_init',{'trace', 'cosin_init_debug'});
  check_mask_type(blk, 'cosin');

  defaults = { ...
    'output0',      'cos', ...     
    'output1',      '-sin', ...  
    'phase',        0, ...
    'fraction',     3, ... 
    'store',        3, ...   
    'table_bits',   5, ...  
    'n_bits',       18, ...      
    'bin_pt',       17, ...    
    'bram_latency', 2, ...
    'add_latency',  1, ... 
    'mux_latency',  1, ... 
    'neg_latency',  1, ... 
    'conv_latency', 1, ...
    'pack',         'off', ...
    'bram',         'BRAM', ... %'BRAM' or 'distributed RAM'
    'misc',         'off', ...
  };
  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  output0       = get_var('output0', 'defaults', defaults, varargin{:});
  output1       = get_var('output1', 'defaults', defaults, varargin{:});
  phase         = get_var('phase', 'defaults', defaults, varargin{:});
  fraction      = get_var('fraction', 'defaults', defaults, varargin{:});
  store         = get_var('store', 'defaults', defaults, varargin{:});
  table_bits    = get_var('table_bits', 'defaults', defaults, varargin{:});
  n_bits        = get_var('n_bits', 'defaults', defaults, varargin{:});
  bin_pt        = get_var('bin_pt', 'defaults', defaults, varargin{:});
  bram_latency  = get_var('bram_latency', 'defaults', defaults, varargin{:});
  add_latency   = get_var('add_latency', 'defaults', defaults, varargin{:});
  mux_latency   = get_var('mux_latency', 'defaults', defaults, varargin{:});
  neg_latency   = get_var('neg_latency', 'defaults', defaults, varargin{:});
  conv_latency  = get_var('conv_latency', 'defaults', defaults, varargin{:});
  pack          = get_var('pack', 'defaults', defaults, varargin{:});
  bram          = get_var('bram', 'defaults', defaults, varargin{:});         
  misc          = get_var('misc', 'defaults', defaults, varargin{:});         
 
  delete_lines(blk);

  %default case for storage in the library
  if table_bits == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting cosin_init',{'trace', 'cosin_init_debug'});
    return;
  end %if

  %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  reuse_block(blk, 'theta', 'built-in/Inport', 'Port', '1', 'Position', [10 88 40 102]);

  reuse_block(blk, 'assert', 'xbsIndex_r4/Assert', ...
          'assert_type', 'on', ...
          'type_source', 'Explicitly', ...
          'arith_type', 'Unsigned', ...
          'n_bits', num2str(table_bits), 'bin_pt', '0', ...
          'Position', [70 85 115 105]);
  add_line(blk, 'theta/1', 'assert/1');

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/Inport', 'Port', '2', 'Position', [10 238 40 252]);
  else
    reuse_block(blk, 'misci', 'xbsIndex_r4/Constant', ...
            'const', '0', 'n_bits', '1', 'arith_type', 'Unsigned', ...
            'bin_pt', '0', 'explicit_period', 'on', 'period', '1', ...
            'Position', [10 238 40 252]);
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % address manipulation logic %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %make sure not storing more than outputting and not storing too few points
  if (store < fraction) || (fraction <= 2 && store > 2), 
    clog(['need 1/',num2str(fraction),' cycle but want to store 1/',num2str(store),', forcing 1/',num2str(fraction)],{'warning','cosin_init_debug'});
    warning(['need 1/',num2str(fraction),' cycle but want to store 1/',num2str(store),', forcing 1/',num2str(fraction)]);
    store = fraction; 
  end

  full_cycle_bits = table_bits + fraction;

  %need full_cycle_bits to be at least 3 so can cut 2 above and 1 low in add_convert
  if (full_cycle_bits < 3),
    if ~(store == fraction && strcmp(pack,'on')),
      clog('forcing all values storage for small number of points',{'trace', 'cosin_init_debug'});
      warning('forcing all value storage for small number of points');
    end
    store = fraction; pack = 'on';
  end
  
  if (fraction > 2),
    if ~(store == fraction && strcmp(pack,'on')),
      clog('forcing full storage for output cycle fraction less than a quarter',{'trace', 'cosin_init_debug'});
      warning('forcing full storage for output cycle fraction less than a quarter');
    end
    store = fraction; pack = 'on';
  end

  %force separate, complete storage if we have an initial phase offset
  if phase ~= 0, 
    if ~(store == fraction && strcmp(pack,'on')),
      clog('forcing full storage for non zero initial phase',{'trace', 'cosin_init_debug'});
      warning('forcing full storage for non zero initial phase');
    end
    store = fraction; pack = 'on';
  end %if phase

  %determine optimal lookup functions if not packed
  if strcmp(pack, 'on'),
    lookup0 = output0; lookup1 = output1; %not sharing values so store as specified
  else,
    if store == 0 || store == 1, 
      lookup0 = 'cos'; lookup1 = 'cos'; 
    elseif store == 2,
      lookup0 = 'sin'; lookup1 = 'sin';  %minimise amplitude error for last sample with sin
    end %if store
  end %if strcmp(pack) 

  %lookup size depends on fraction of cycle stored
  lookup_bits = full_cycle_bits - store;

  address_bits = table_bits;
  draw_basic_partial_cycle(blk, full_cycle_bits, address_bits, lookup_bits, output0, output1, lookup0, lookup1);

  %%%%%%%%%%%%%
  % ROM setup %
  %%%%%%%%%%%%%
 
  %misc delay
  reuse_block(blk, 'Delay', 'xbsIndex_r4/Delay', ...
          'latency', 'bram_latency', ...
          'reg_retiming', 'on', ...
          'Position', [450 336 480 354]);
  add_line(blk,'add_convert1/3', 'Delay/1');

  %determine memory implementation
  if strcmp(bram, 'BRAM'),
    distributed_mem = 'Block RAM';
  elseif strcmp(bram, 'distributed RAM'),
    distributed_mem = 'Distributed memory';
  else,
    %TODO
  end

  vec_len = 2^lookup_bits;
  
  initVector = [lookup0,'((',num2str(phase),'*(2*pi))+(2*pi)/(2^',num2str(full_cycle_bits),')*(0:(2^',num2str(lookup_bits),')-1))'];

  %pack two outputs into the same word from ROM
  if strcmp(pack, 'on'),
  
    %lookup ROM
    reuse_block(blk, 'ROM', 'xbsIndex_r4/ROM', ...
            'depth', ['2^(',num2str(lookup_bits),')'], ...
            'latency', 'bram_latency', ...
            'arith_type', 'Unsigned', ...
            'n_bits', 'n_bits*2', ...
            'bin_pt', '0', ...
            'distributed_mem', distributed_mem, ...
            'Position', [435 150 490 300]);

    add_line(blk,'add_convert0/2', 'ROM/1');
    reuse_block(blk, 'Terminator4', 'built-in/Terminator', 'Position', [285 220 305 240]);
    add_line(blk,'add_convert1/2', 'Terminator4/1');

    %calculate values to be stored in ROM
    vals0 = gen_vals(output0, phase, full_cycle_bits, vec_len, n_bits, bin_pt);
    vals0 = fi(vals0, false, n_bits*3, bin_pt); %expand whole bits, ready for shift up (being stored Unsigned so must be positive)
    vals0 = bitshift(vals0,bin_pt+n_bits); %shift up 

    vals1 = gen_vals(output1, phase, full_cycle_bits, vec_len, n_bits, bin_pt);
    vals1 = fi(vals1, false, n_bits*2, bin_pt); %expand whole bits, ready for shift up (being stored Unsigned so must be positive)
    vals1 = bitshift(vals1,bin_pt); %shift up 

    set_param([blk,'/ROM'], 'initVector', ['[',num2str(double(vals0+vals1)),']']);

    %extract real and imaginary parts of vector
    reuse_block(blk, 'c_to_ri', 'casper_library_misc/c_to_ri', ...
      'n_bits', 'n_bits', 'bin_pt', 'bin_pt', ...
      'Position', [510 204 550 246]);

    add_line(blk,'ROM/1','c_to_ri/1');

  elseif strcmp(pack, 'off'),

    %lookup table
    reuse_block(blk, 'lookup', 'xbsIndex_r4/Dual Port RAM', ...
            'initVector', initVector, ...
            'depth', sprintf('2^(%s)',num2str(lookup_bits)), ...
            'latency', 'bram_latency', ...
            'distributed_mem', distributed_mem, ...
            'Position', [435 137 490 298]);
    
    add_line(blk,'add_convert0/2','lookup/1');
    add_line(blk,'add_convert1/2','lookup/4');

    %constant inputs to lookup table    
    reuse_block(blk, 'Constant', 'xbsIndex_r4/Constant', ...
            'const', '0', ...
            'n_bits', 'n_bits', ...
            'bin_pt', 'bin_pt', ...
            'Position', [380 170 400 190]);
    add_line(blk,'Constant/1','lookup/2');

    reuse_block(blk, 'Constant2', 'xbsIndex_r4/Constant', ...
            'const', '0', ...
            'arith_type', 'Boolean', ...
            'n_bits', 'n_bits', ...
            'bin_pt', 'bin_pt', ...
            'Position', [380 195 400 215]);
    add_line(blk,'Constant2/1','lookup/3');

    %add constants if using BRAM (ports don't exist when using distributed RAM)
    if strcmp(bram, 'BRAM')
      reuse_block(blk, 'Constant1', 'xbsIndex_r4/Constant', ...
              'const', '0', ...
              'n_bits', 'n_bits', ...
              'bin_pt', 'bin_pt', ...
              'Position', [380 245 400 265]);
      add_line(blk,'Constant1/1','lookup/5');

      reuse_block(blk, 'Constant3', 'xbsIndex_r4/Constant', ...
              'const', '0', ...
              'arith_type', 'Boolean', ...
              'n_bits', 'n_bits', ...
              'bin_pt', 'bin_pt', ...
              'Position', [380 270 400 290]);
      add_line(blk,'Constant3/1','lookup/6');
    end %if strcmp(bram)

  else,
    %TODO
  end %if strcmp(pack)

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % delays for negate outputs from address manipulation block % 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  reuse_block(blk, 'Delay8', 'xbsIndex_r4/Delay', ...
          'latency', 'bram_latency', ...
          'reg_retiming', 'on', ...
          'Position', [450 116 480 134]);
  add_line(blk,'add_convert1/1','Delay8/1');
  reuse_block(blk, 'Delay10', 'xbsIndex_r4/Delay', ...
          'latency', 'bram_latency', ...
          'reg_retiming', 'on', ...
          'Position', [450 81 480 99]);
  add_line(blk,'add_convert0/1','Delay10/1');

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % data manipulation before output %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if strcmp(pack, 'on'),
    src0 = 'c_to_ri/1'; src1 = 'c_to_ri/2';
  else,
    src0 = 'lookup/1'; src1 = 'lookup/2';
  end

  %data
  reuse_block(blk, 'Constant5', 'xbsIndex_r4/Constant', ...
          'const', '0', ...
          'arith_type', 'Unsigned', ...
          'n_bits', '1', ...
          'bin_pt', '0', ...
          'explicit_period', 'on', ...
          'Position', [770 122 785 138]);

  reuse_block(blk, 'invert0', 'built-in/SubSystem');
  invert_gen([blk,'/invert0']);
  set_param([blk,'/invert0'], ...
          'Position', [800 80 850 142]);
  add_line(blk,'Delay10/1','invert0/1');
  add_line(blk,'Constant5/1','invert0/3');
  add_line(blk, src0, 'invert0/2');

  reuse_block(blk, 'invert1', 'built-in/SubSystem');
  invert_gen([blk,'/invert1']);
  set_param([blk,'/invert1'], ...
          'Position', [800 160 850 222]);
  add_line(blk,'Delay8/1','invert1/1');
  add_line(blk,src1, 'invert1/2');

  reuse_block(blk, 'Terminator1', 'built-in/Terminator', ...
          'Position', [880 115 900 135]);
  add_line(blk,'invert0/2','Terminator1/1');

  %misc
  add_line(blk,'Delay/1','invert1/3');
  
  %%%%%%%%%%%%%%%%  
  % output ports %
  %%%%%%%%%%%%%%%%  
  
  reuse_block(blk, output0, 'built-in/Outport', ...
          'Port', '1', ...
          'Position', [875 88 905 102]);

  reuse_block(blk, output1, 'built-in/Outport', ...
          'Port', '2', ...
          'Position', [875 168 905 182]);

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/Outport', ...
            'Port', '3', ...
            'Position', [875 198 905 212]);
  else,
    reuse_block(blk, 'misco', 'built-in/Terminator', 'Position', [875 198 905 212]);
  end

  add_line(blk,'invert0/1',[output0,'/1']);
  add_line(blk,'invert1/2','misco/1');
  add_line(blk,'invert1/1',[output1,'/1']);

  %%%%%%%%%%%%%%%%%%%%%  
  % final cleaning up %
  %%%%%%%%%%%%%%%%%%%%%  

  clean_blocks(blk);

  fmtstr = sprintf('');
  set_param(blk, 'AttributesFormatString', fmtstr);
  %ensure that parameters we have forced reflect in mask parameters (ensure this matches varargin
  %passed by block so that hash in same_state can be compared)
  args = { ...
    'output0', output0, 'output1', output1, 'phase', phase, 'fraction', fraction, ...
    'table_bits', table_bits, 'n_bits', n_bits, 'bin_pt', bin_pt, 'bram_latency', bram_latency, ...
    'add_latency', add_latency, 'mux_latency', mux_latency, 'neg_latency', neg_latency, ...
    'conv_latency', conv_latency, 'store', store, 'pack', pack, 'bram', bram, 'misc', misc};
  save_state(blk, 'defaults', defaults, args{:});
  clog('exiting cosin_init',{'trace', 'cosin_init_debug'});

end %cosin_init

function draw_basic_partial_cycle(blk, full_cycle_bits, address_bits, lookup_bits, output0, output1, lookup_function0, lookup_function1)

  clog(sprintf('full_cycle_bits = %d, address_bits = %d, lookup_bits = %d', full_cycle_bits, address_bits, lookup_bits), {'draw_basic_partial_cycle_debug', 'cosin_init_debug'});
  
    if full_cycle_bits < 3,
      clog('parameters not sensible so returning', {'draw_basic_partial_cycle_debug', 'cosin_init_debug'});
      return;
    end

    reuse_block(blk, 'Constant4', 'xbsIndex_r4/Constant', ...
            'const', '0', ...
            'arith_type', 'Unsigned', ...
            'n_bits', '1', ...
            'bin_pt', '0', ...
            'explicit_period', 'on', ...
            'Position', [150 115 175 135]);
  
    clog(['adding ',[blk,'/add_convert0']], {'cosin_init_debug', 'draw_basic_partial_cycle_debug'});
    reuse_block(blk, 'add_convert0', 'built-in/SubSystem', 'Position', [195 80 265 140]);
    add_convert_init([blk,'/add_convert0'], full_cycle_bits, address_bits, lookup_bits, lookup_function0, output0);

    reuse_block(blk, 'Terminator', 'built-in/Terminator');
    set_param([blk,'/Terminator'], 'Position', [285 120 305 140]);

    add_line(blk,'assert/1','add_convert0/1');
    add_line(blk,'Constant4/1','add_convert0/2');
    add_line(blk,'add_convert0/3','Terminator/1');
    
    clog(['adding ',[blk,'/add_convert1']], {'cosin_init_debug', 'draw_basic_partial_cycle_debug'});
    reuse_block(blk, 'add_convert1', 'built-in/SubSystem', 'Position', [195 200 265 260]);
    add_convert_init([blk,'/add_convert1'], full_cycle_bits, address_bits, lookup_bits, lookup_function1, output1);
    
    add_line(blk,'misci/1','add_convert1/2');
    add_line(blk,'assert/1','add_convert1/1');

end %draw_basic_partial_cycle

function add_convert_init(blk, full_cycle_bits, address_bits, lookup_bits, lookup_function, output)

  clog(sprintf('full_cycle_bits = %d, address_bits = %d, lookup_bits = %d. lookup_function = %s, output = %s', full_cycle_bits, address_bits, lookup_bits, lookup_function, output), {'add_convert_init_debug', 'cosin_init_debug'});

  pad_bits = full_cycle_bits - address_bits;   %need to pad address bits in to get to full cycle 

  diff_bits = full_cycle_bits - lookup_bits;   %what fraction of a cycle are we storing 

  %reference using cos as lookup
  names = {'cos', '-sin', '-cos', 'sin'};
  
  %find how far lookup function is from our reference
  base = find(strcmp(lookup_function,names));

  %now find how far the required output is from our reference
  offset = find(strcmp(output,names));
  
  %find how many quadrants to shift address by to get to lookup function
  direction_offset = mod(offset - base,4);

  if (diff_bits == 2) && (strcmp(lookup_function, 'cos') || strcmp(lookup_function, '-cos')),
    negate_offset = mod(direction_offset + 1,4);
  else
    negate_offset = direction_offset;
  end  

  clog(sprintf('direction offset = %d, diff_bits = %d', direction_offset, diff_bits), {'add_convert_init_debug', 'cosin_init_debug'});

  reuse_block(blk, 'theta', 'built-in/Inport', 'Port', '1', 'Position', [20 213 50 227]);

  if pad_bits ~= 0,
    reuse_block(blk, 'pad', 'xbsIndex_r4/Constant', 'const', '0', ...
            'arith_type', 'Unsigned', 'n_bits', num2str(pad_bits), ...
            'bin_pt', '0', 'Position', [65 185 85 205]);

    reuse_block(blk, 'fluff', 'xbsIndex_r4/Concat', ...
            'num_inputs', '2', 'Position', [105 180 130 235]);
    add_line(blk, 'theta/1', 'fluff/2');    
    add_line(blk, 'pad/1', 'fluff/1');    
  end
  
  reuse_block(blk, 'add', 'built-in/Outport', 'Port', '2', 'Position', [840 203 870 217]);

  reuse_block(blk, 'new_add', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(lookup_bits), ...
          'mode', 'Lower Bit Location + Width', ...
          'Position', [380 242 410 268]);

  %%%%%%%%%%%%%%%%%%%%%%%
  % address translation %
  %%%%%%%%%%%%%%%%%%%%%%%

  if ~(direction_offset == 0 && diff_bits == 0),

    reuse_block(blk, 'quadrant', 'xbsIndex_r4/Slice', 'nbits', '2', 'Position', [150 172 180 198]);
    if pad_bits == 0, add_line(blk,'theta/1','quadrant/1');
    else add_line(blk, 'fluff/1', 'quadrant/1');
    end

    reuse_block(blk, 'direction_offset', 'xbsIndex_r4/Constant', ...
            'const', num2str(direction_offset), ...
            'arith_type', 'Unsigned', ...
            'n_bits', '2', ...
            'bin_pt', '0', ...
            'Position', [55 150 75 170]);

    reuse_block(blk, 'AddSub5', 'xbsIndex_r4/AddSub', ...
            'latency', '0', ...
            'precision', 'User Defined', ...
            'n_bits', '2', ...
            'bin_pt', '0', ...
            'pipelined', 'on', ...
            'Position', [240 148 285 197]);
    add_line(blk,'direction_offset/1','AddSub5/1');
    add_line(blk,'quadrant/1','AddSub5/2');

    reuse_block(blk, 'lookup', 'xbsIndex_r4/Slice', 'nbits', num2str(full_cycle_bits-2), 'mode', 'Lower Bit Location + Width', ...
            'Position', [150 252 180 278]);
    if pad_bits == 0, add_line(blk,'theta/1','lookup/1');
    else add_line(blk, 'fluff/1', 'lookup/1');
    end

    reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [320 233 345 277]);
    add_line(blk,'lookup/1','Concat/2');
    add_line(blk,'AddSub5/1','Concat/1');

    add_line(blk,'Concat/1','new_add/1');
  else, 
    if diff_bits == 0, add_line(blk,'theta/1','new_add/1');
    else add_line(blk, 'fluff/1', 'new_add/1');
    end
  end %if diff_bits == 0

  reuse_block(blk, 'Delay14', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'on', 'latency', 'add_latency', 'Position', [540 201 570 219]);    
  add_line(blk,'new_add/1','Delay14/1');

  reuse_block(blk, 'Convert2', 'xbsIndex_r4/Convert', ...
          'arith_type', 'Unsigned', ...
          'n_bits', num2str(lookup_bits), ...
          'bin_pt', '0', ...
          'overflow', 'Saturate', ...
          'latency', 'conv_latency', ...
          'pipeline', 'on', ...
          'Position', [785 201 810 219]);
  add_line(blk,'Convert2/1','add/1');

  %%%%%%%%%%%%%
  % backwards %
  %%%%%%%%%%%%%
  
  %only need backwards translation for quarter cycle operation
  if (diff_bits == 2),

    reuse_block(blk, 'backwards', 'xbsIndex_r4/Slice', ...
            'boolean_output', 'on', ...
            'mode', 'Lower Bit Location + Width', ...
            'bit0', '0', ...
            'Position', [380 166 410 184]);

    reuse_block(blk, 'Constant4', 'xbsIndex_r4/Constant', ...
            'const', num2str(2^lookup_bits), ...
            'arith_type', 'Unsigned', ...
            'n_bits', num2str(lookup_bits+1), ...
            'bin_pt', '0', ...
            'Position', [450 220 475 240]);

    reuse_block(blk, 'AddSub', 'xbsIndex_r4/AddSub', ...
            'mode', 'Subtraction', ...
            'latency', 'add_latency', ...
            'precision', 'User Defined', ...
            'n_bits',  num2str(lookup_bits+1), ...
            'bin_pt', '0', ...
            'pipelined', 'on', ...
            'Position', [530 217 575 268]);

    reuse_block(blk, 'Mux', 'xbsIndex_r4/Mux', 'latency', 'mux_latency', 'Position', [675 156 700 264]);

    reuse_block(blk, 'Delay13', 'xbsIndex_r4/Delay', ...
            'latency', 'add_latency', ...
            'reg_retiming', 'on', ...
            'Position', [540 166 570 184]);

    add_line(blk,'AddSub5/1','backwards/1');
    add_line(blk,'backwards/1','Delay13/1');
    add_line(blk,'new_add/1','AddSub/2');
    add_line(blk,'Constant4/1','AddSub/1');
    add_line(blk,'Delay13/1','Mux/1');
    add_line(blk,'Delay14/1','Mux/2');
    add_line(blk,'AddSub/1','Mux/3');
    add_line(blk,'Mux/1','Convert2/1');

  else,
    %no backwards translation so just delay and put new address through
    reuse_block(blk, 'Delay13', 'xbsIndex_r4/Delay', ...
      'reg_retiming', 'on', 'latency', 'mux_latency', 'Position', [675 201 705 219]);
    add_line(blk,'Delay14/1','Delay13/1');
    add_line(blk,'Delay13/1','Convert2/1');
  
  end %backwards translation

  %%%%%%%%%%%%%%%%%%%%%%
  % invert logic chain %
  %%%%%%%%%%%%%%%%%%%%%% 
 
  reuse_block(blk, 'negate', 'built-in/Outport', 'Port', '1', 'Position', [835 98 865 112]);

  %need inversion if not got full cycle 
  if (diff_bits ~= 0), 
   
    reuse_block(blk, 'invert', 'xbsIndex_r4/Slice', ...
        'boolean_output', 'on', ...
        'Position', [380 96 410 114]);

    %if different sized offset
    if (negate_offset ~= direction_offset), 
      reuse_block(blk, 'negate_offset', 'xbsIndex_r4/Constant', ...
              'const', num2str(negate_offset), ...
              'arith_type', 'Unsigned', ...
              'n_bits', '2', ...
              'bin_pt', '0', ...
              'Position', [55 80 75 100]);

      reuse_block(blk, 'AddSub1', 'xbsIndex_r4/AddSub', ...
              'latency', '0', ...
              'precision', 'User Defined', ...
              'n_bits', '2', ...
              'bin_pt', '0', ...
              'pipelined', 'on', ...
              'Position', [240 78 285 127]);
    
      add_line(blk,'negate_offset/1','AddSub1/1');
      add_line(blk,'quadrant/1','AddSub1/2');
      add_line(blk,'AddSub1/1','invert/1');
    else,
      add_line(blk,'AddSub5/1','invert/1');
    end
    
    reuse_block(blk, 'Delay2', 'xbsIndex_r4/Delay', ...
            'latency', 'add_latency+mux_latency+conv_latency', ...
            'reg_retiming', 'on', ...
            'Position', [675 96 705 114]);
    add_line(blk,'invert/1','Delay2/1');
    add_line(blk,'Delay2/1','negate/1');

  else, %otherwise no inversion required
      clog('no inversion required', {'add_convert_init_debug', 'cosin_init_debug'});
      reuse_block(blk, 'invert', 'xbsIndex_r4/Constant', ...
              'const', '0', ...
              'arith_type', 'Boolean', ...
              'explicit_period', 'on', ...
              'period', '1', ...
              'Position', [675 96 705 114]);
      add_line(blk, 'invert/1', 'negate/1'); 
  end

  %%%%%%%%%%%%%%
  % misc chain %
  %%%%%%%%%%%%%%
  
  reuse_block(blk, 'misci', 'built-in/Inport', ...
          'Port', '2', ...
          'Position', sprintf('[20 303 50 317]'));

  reuse_block(blk, 'Delay1', 'xbsIndex_r4/Delay', ...
          'latency', 'mux_latency+add_latency+conv_latency', ...
          'reg_retiming', 'on', ...
          'Position', [540 301 570 319]);
  add_line(blk,'misci/1','Delay1/1');

  reuse_block(blk, 'misco', 'built-in/Outport', ...
          'Port', '3', ...
          'Position', [835 303 865 317]);
  add_line(blk,'Delay1/1','misco/1');

end % add_convert_init

function[vals] = gen_vals(func, phase, table_bits, subset, n_bits, bin_pt),
    %calculate init vector
    if strcmp(func, 'sin'),
        vals = sin((phase*(2*pi))+[0:subset-1]*pi*2/(2^table_bits));
    elseif strcmp(func, 'cos'),
        vals = cos((phase*(2*pi))+[0:subset-1]*pi*2/(2^table_bits));
    elseif strcmp(func, '-sin'),
        vals = -sin((phase*(2*pi))+[0:subset-1]*pi*2/(2^table_bits));
    elseif strcmp(func, '-cos'),
        vals = -cos((phase*(2*pi))+[0:subset-1]*pi*2/(2^table_bits));
    end %if strcmp(func)
    vals = fi(vals, true, n_bits, bin_pt); %saturates at max so no overflow
    vals = fi(vals, false, n_bits, bin_pt, 'OverflowMode', 'wrap'); %wraps negative component so can get back when positive

end %gen_vals

function invert_gen(blk)

	invert_mask(blk);
	invert_init(blk);
end % invert_gen

function invert_mask(blk)

	set_param(blk, ...
		'Mask', 'on', ...
		'MaskSelfModifiable', 'off', ...
		'MaskPromptString', 'bit width|binary point|negate latency|mux latency', ...
		'MaskStyleString', 'edit,edit,edit,edit', ...
		'MaskCallbackString', '|||', ...
		'MaskEnableString', 'on,on,on,on', ...
		'MaskVisibilityString', 'on,on,on,on', ...
		'MaskToolTipString', 'on,on,on,on', ...
		'MaskVariables', 'n_bits=@1;bin_pt=@2;neg_latency=@3;mux_latency=@4;', ...
		'MaskValueString', 'n_bits|bin_pt|neg_latency|mux_latency', ...
		'BackgroundColor', 'white');

end % invert_mask

function invert_init(blk)

	reuse_block(blk, 'negate', 'built-in/Inport', ...
		'Port', '1', ...
		'Position', [15 43 45 57]);

	reuse_block(blk, 'in', 'built-in/Inport', ...
		'Port', '2', ...
		'Position', [15 83 45 97]);

	reuse_block(blk, 'misci', 'built-in/Inport', ...
		'Port', '3', ...
		'Position', [15 193 45 207]);

	reuse_block(blk, 'Delay21', 'xbsIndex_r4/Delay', ...
		'latency', 'neg_latency', ...
                'reg_retiming', 'on', ...
		'Position', [110 41 140 59]);

	reuse_block(blk, 'Delay20', 'xbsIndex_r4/Delay', ...
		'latency', 'neg_latency', ...
                'reg_retiming', 'on', ...
		'Position', [110 81 140 99]);

	reuse_block(blk, 'Negate', 'xbsIndex_r4/Negate', ...
		'precision', 'User Defined', ...
		'arith_type', 'Signed  (2''s comp)', ...
		'n_bits', 'n_bits', ...
		'bin_pt', 'bin_pt', ...
		'latency', 'neg_latency', ...
                'overflow', 'Saturate', ...
		'Position', [100 119 155 141]);

	reuse_block(blk, 'mux', 'xbsIndex_r4/Mux', ...
		'latency', 'mux_latency', ...
		'Position', [215 26 250 154]);

	reuse_block(blk, 'Delay1', 'xbsIndex_r4/Delay', ...
		'latency', 'mux_latency+neg_latency', ...
                'reg_retiming', 'on', ...
		'Position', [215 191 245 209]);

	reuse_block(blk, 'out', 'built-in/Outport', ...
		'Port', '1', ...
		'Position', [300 83 330 97]);

	reuse_block(blk, 'misco', 'built-in/Outport', ...
		'Port', '2', ...
		'Position', [300 193 330 207]);

	add_line(blk,'misci/1','Delay1/1');
	add_line(blk,'negate/1','Delay21/1');
	add_line(blk,'in/1','Negate/1');
	add_line(blk,'in/1','Delay20/1');
	add_line(blk,'Delay21/1','mux/1');
	add_line(blk,'Delay20/1','mux/2');
	add_line(blk,'Negate/1','mux/3');
	add_line(blk,'mux/1','out/1');
	add_line(blk,'Delay1/1','misco/1');
end % invert_init



