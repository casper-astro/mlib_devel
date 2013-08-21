function fft_direct_init(blk, varargin)
% Initialize and configure an fft_direct block.
%
% fft_direct_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% FFTSize = Size of the FFT (2^FFTSize points).
% input_bit_width = Bitwidth of input and output data.
% coeff_bit_width = Bitwidth of coefficients
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% map_tail =
% LargerFFTSize = Size of the entire FFT.
% StartStage = First stage in this FFT.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
%                                                                             %
%   SKASA radio telescope project                                             %
%   www.kat.ac.za                                                             %
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

clog('entering fft_direct_init','trace');

% If we are in a library, do nothing
if is_library_block(blk)
  clog('exiting fft_direct_init (block in library)','trace');
  return
end

% If FFTSize is passed as 0, do nothing
if get_var('FFTSize', varargin{:}) == 0
  clog('exiting fft_direct_init (FFTSize==0)','trace');
  return
end

% Make sure block is not too old for current init script
try
    get_param(blk, 'n_streams');
catch
    errmsg = sprintf(['Block %s is too old for current init script.\n', ...
                      'Please run "update_casper_block(%s)".\n'], ...
                      blk, blk);
    % We are not initializing the block because it is too old.  Make sure the
    % user knows this by using a modal error dialog.  Using a modal error
    % dialog is a drastic step, but the situation really needs user attention.
    errordlg(errmsg, 'FFT Block Too Old', 'modal');
    try
      ex = MException('casper:blockTooOldError', errmsg);
      throw(ex);
    catch ex
      clog('throwing from fft_direct_init', 'trace');
      % We really want to dump this exception, even if its a duplicate of the
      % previously dumped exception, so reset dump_exception before dumping.
      dump_exception([]);
      dump_and_rethrow(ex);
    end
end

% Set default vararg values.
defaults = { ...
    'n_streams', 1, ...
    'FFTSize', 2,  ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18, ...
    'map_tail', 'on', ...
    'LargerFFTSize', 12, ...
    'StartStage', 10, ...
    'async', 'off', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'coeffs_bit_limit', 9,  ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'on', ...
    'coeff_generation', 'on', ...
    'cal_bits', 1, ...
    'n_bits_rotation', 25, ...
    'max_fanout', 4, ...
    'mult_spec', [2], ...
    'bitgrowth', 'off', ...
    'max_bits', 19, ...
    'hardcode_shifts', 'on', ...
    'shift_schedule', [1 1 0], ...
    'dsp48_adders', 'off', ...
};

xtick = 300;
ytick = 100;

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_direct_init post same_state','trace');
check_mask_type(blk, 'fft_direct');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_streams         = get_var('n_streams', 'defaults', defaults, varargin{:});
FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width   = get_var('input_bit_width', 'defaults', defaults, varargin{:});
bin_pt_in         = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
biplex            = get_var('biplex', 'defaults', defaults, varargin{:});
coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
map_tail          = get_var('map_tail', 'defaults', defaults, varargin{:});
LargerFFTSize     = get_var('LargerFFTSize', 'defaults', defaults, varargin{:});
StartStage        = get_var('StartStage', 'defaults', defaults, varargin{:});
async             = get_var('async', 'defaults', defaults, varargin{:});
add_latency       = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency      = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency      = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization      = get_var('quantization', 'defaults', defaults, varargin{:});
overflow          = get_var('overflow', 'defaults', defaults, varargin{:});
coeffs_bit_limit  = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
coeff_sharing     = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
coeff_decimation  = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
coeff_generation  = get_var('coeff_generation', 'defaults', defaults, varargin{:});
cal_bits          = get_var('cal_bits', 'defaults', defaults, varargin{:});
n_bits_rotation   = get_var('n_bits_rotation', 'defaults', defaults, varargin{:});
max_fanout        = get_var('max_fanout', 'defaults', defaults, varargin{:});
mult_spec         = get_var('mult_spec', 'defaults', defaults, varargin{:});
bitgrowth         = get_var('bitgrowth', 'defaults', defaults, varargin{:});
max_bits          = get_var('max_bits', 'defaults', defaults, varargin{:});
hardcode_shifts   = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule    = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders      = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

% bin_pt_in == -1 is a special case for backwards compatibility
if bin_pt_in == -1
  bin_pt_in = input_bit_width - 1;
  set_mask_params(blk, 'bin_pt_in', num2str(bin_pt_in));
end

% check the per-stage multiplier specification
stage_mult_spec = multiplier_specification(mult_spec, FFTSize, blk);

delete_lines(blk);
% Add ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 0 60 15], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [30 45 60 60], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [xtick*FFTSize+150 0 xtick*FFTSize+180 15], 'Port', '1');

n_dports = n_streams*2^FFTSize;
reuse_block(blk, 'of', 'built-in/outport', 'Port', num2str((2^FFTSize*n_streams)+2), ...
    'Position', [xtick*(FFTSize+1/4)+280 ytick*n_dports+110 xtick*(FFTSize+1/4)+315 ytick*n_dports+125]);

if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/inport', ...
    'Port', num2str(n_dports+3), 'Position', [90 ytick*(n_dports+1)+100 120 ytick*(n_dports+1)+115]);
  reuse_block(blk, 'dvalid', 'built-in/outport', 'Port', num2str(n_dports+3), ...
    'Position', [xtick*FFTSize+150 ytick*(n_dports+1)+100 xtick*FFTSize+180 ytick*(n_dports+1)+115]);
end

inputs = ['a','b'];
%create bus on entry to the first stage
multiple = 2^(FFTSize-1)*n_streams;
for n = 0:1,
  name = [inputs(n+1), 'bus'];
  clog(['adding ',name], 'fft_direct_init_debug');
  pos = [90 (ytick*(n*multiple))+100 120 ytick*((n+1)*multiple-1)+130];
  reuse_block(blk, name, 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(multiple), 'Position', pos);
end

%debus outputs of final stage
for n=0:2^FFTSize-1,
  if strcmp(bitgrowth, 'on'), n_bits = min(max_bits, input_bit_width*FFTSize);
  else, n_bits = input_bit_width;
  end

  src = inputs(mod(n,2)+1);
  debus = [src, 'debus', num2str(FFTSize-1), '_', num2str(floor(n/2))];
  clog(['adding ',debus], 'fft_direct_init_debug');
  pos = [150+(xtick*FFTSize) (ytick*n*n_streams)+100 200+(xtick*FFTSize) (ytick*n*n_streams)+(n_streams/2*ytick)+130];
  reuse_block(blk, debus, 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(n_streams), ...
    'outputWidth', mat2str(repmat(n_bits*2, 1, n_streams)), 'outputBinaryPt', mat2str(zeros(1,n_streams)), ... 
    'outputArithmeticType', mat2str(zeros(1,n_streams)), 'Position', pos);
end %for n

%input and output ports
for s = 0:n_streams-1,
  for n = 0:2^FFTSize-1,
    off_base = n*n_streams;
    port_base = s*2^FFTSize;
  
    %input data ports
    reuse_block(blk, ['in',num2str(s), num2str(n)], 'built-in/inport', ...
      'Port', num2str(port_base+n+3), 'Position', [30 100+ytick*(off_base+s) 60 115+ytick*(off_base+s)]);
    input = inputs(floor((off_base+s)/multiple)+1);
    add_line(blk, ['in',num2str(s), num2str(n),'/1'], [input,'bus/', num2str(mod(s+off_base,multiple)+1)]);
    
    %output data ports
    output_index = bit_rev(n, FFTSize);
    off_base = output_index*n_streams;
    reuse_block(blk, ['out',num2str(s),num2str(n)], 'built-in/outport', ...
      'Port', num2str(port_base+n+2), 'Position', [xtick*(FFTSize+1/4)+150 100+ytick*(off_base+s) xtick*(FFTSize+1/4)+180 115+ytick*(off_base+s)]);

    %connect debus to output 
    src = inputs(mod(output_index,2)+1);
    debus = [src, 'debus', num2str(FFTSize-1), '_', num2str(floor(output_index/2))];
    add_line(blk, [debus, '/',num2str(s+1)], ['out',num2str(s), num2str(n),'/1']);
  end %for n
end %for s 

% overflow logic

%FFTSize == 1 implies 1 input or block which generates an error
if (FFTSize ~= 1),
  pos = [xtick*FFTSize+150 ytick*n_dports+100 xtick*FFTSize+180 ytick*n_dports+115+(FFTSize*10)];
  reuse_block(blk, 'of_or', 'xbsIndex_r4/Logical', ...
      'Position', pos, ...
      'logical_function', 'OR', ...
      'inputs', num2str(FFTSize), ...
      'latency', '1');
  
  reuse_block(blk, 'of_expand', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', ...
    'outputNum', num2str(2^(FFTSize-1)), 'outputWidth', num2str(n_streams), ...
    'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
    'Position', [xtick*FFTSize+215 ytick*n_dports+93 xtick*FFTSize+245 ytick*n_dports+122+(FFTSize*10)]);
  add_line(blk, 'of_or/1', 'of_expand/1');

  reuse_block(blk, 'combine', 'xbsIndex_r4/Logical', ...
      'Position', [xtick*FFTSize+280 ytick*n_dports+93 xtick*FFTSize+310 ytick*n_dports+122+(FFTSize*10)], ...
      'logical_function', 'OR', 'inputs', num2str(2^(FFTSize-1)), 'latency', '1');
  for port = 1:2^(FFTSize-1),
    add_line(blk, ['of_expand/',num2str(port)], ['combine/',num2str(port)]);
  end

  add_line(blk, 'combine/1', 'of/1');
end

%shift connection for each stage
for stage = 0:FFTSize-1
  % slice bits for shift
  name = ['slice',num2str(stage)];
  pos = [xtick*stage+90 70 xtick*stage+120 85];
  reuse_block(blk, name, 'xbsIndex_r4/Slice', ...
      'Position', pos, ...
      'mode', 'Lower Bit Location + Width', ...
      'nbits', '1', ...
      'bit0', num2str(stage), ...
      'boolean_output', 'on');
  add_line(blk,'shift/1', [name,'/1']);
end %for

% debus outputs of butterflies
for stage=0:FFTSize-1,

  if strcmp(bitgrowth, 'off'), n_bits = input_bit_width;
  else, %TODO
  end

  if (strcmp(hardcode_shifts, 'on') && (shift_schedule(stage+1) == 1)), downshift = 'on';
  else, downshift = 'off';
  end

  %twiddle factors can be shared depending on stages 
  n_unique = 2^stage;
  multiple = 2^(FFTSize-stage-1);

  clog(['Processing stage ',num2str(stage), ' with ',num2str(n_unique), ' twiddle sets each unique to ',num2str(multiple),' inputs'], {'fft_direct_init_debug'});

  %add overflow logic
  if (FFTSize ~= 1),
      pos = [xtick*(stage+1)+90 ytick*(2^FFTSize*n_streams)+100+(stage*15) xtick*(stage+1)+120 120+ytick*(2^FFTSize*n_streams)+(FFTSize*5)+(stage*15)];
      
      if stage == 0, %first stage has only one output
        reuse_block(blk, ['of_', num2str(stage)], 'xbsIndex_r4/Delay', ...
            'Position', pos, 'latency', '0');
      else          %other stages must have of outputs concatenated
        reuse_block(blk, ['of_', num2str(stage)], 'xbsIndex_r4/Concat', ...
            'Position', pos, 'num_inputs', num2str(n_unique));
      end %if
      add_line(blk, ['of_',num2str(stage),'/1'], ['of_or/',num2str(stage+1)]);
  end %if

  for n = 0:2^(FFTSize-1)-1,
    input = inputs(mod(floor(n/multiple),2)+1);

    %into next set of unique coefficients so add new butterfly
    if mod(n, multiple) == 0,
      % Implement a normal FFT or the tail end of a larger FFT
      if strcmp(map_tail, 'off'),
          coeffs = ['[',num2str(floor(n/2^(FFTSize-(stage+1)))),']'];
          actual_fft_size = FFTSize;
          num_coeffs = 1;
      else
          redundancy = 2^(LargerFFTSize - FFTSize);
          coeffs = '[';
          for r=0:redundancy-1,
              m = bit_reverse(r, LargerFFTSize - FFTSize);
              coeffs = [coeffs,' ',num2str(floor((n+m*2^(FFTSize-1))/2^(LargerFFTSize-(StartStage+stage))))];
          end
          coeffs = [coeffs, ']'];
          actual_fft_size = LargerFFTSize;
          num_coeffs = redundancy;
      end

      butterfly = ['butterfly', num2str(stage), '_', num2str(floor(n/multiple))];
      clog(['adding ',butterfly], 'fft_direct_init_debug');

      %if growing bits pre-calculate for every stage
      if strcmp(bitgrowth, 'on'), 
        n_bits_stage_in = min(max_bits, input_bit_width + stage);
        %if we are going to go above the max limit stop growing and revert to shifting
        if (n_bits_stage_in+1) > max_bits, bitgrowth_stage = 'off';
        else, bitgrowth_stage = 'on';
        end
      else, 
        n_bits_stage_in = input_bit_width; 
        bitgrowth_stage = bitgrowth; 
      end

      pos = [(xtick*stage)+220 (ytick*n*n_streams*2)+100 (xtick*stage)+300 (ytick*((n*2*n_streams)+multiple-1))+175];
      reuse_block(blk, butterfly, 'casper_library_ffts/butterfly_direct', ...
          'Position', pos, ...
          'n_inputs', num2str(n_streams*multiple), ...
          'biplex', 'off', ...
          'FFTSize', num2str(actual_fft_size), ...
          'Coeffs', coeffs, ...
          'StepPeriod', '0', ...
          'coeff_bit_width', num2str(coeff_bit_width), ...
          'input_bit_width', num2str(n_bits_stage_in), ...
          'bin_pt_in', num2str(bin_pt_in), ...
          'downshift', downshift, ...
          'async', async, ...
          'bram_latency', num2str(bram_latency), ...
          'add_latency', num2str(add_latency), ...
          'mult_latency', num2str(mult_latency), ...
          'conv_latency', num2str(conv_latency), ...
          'quantization', quantization, ...
          'overflow', overflow, ...
          'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
          'coeff_sharing', coeff_sharing, ...
          'coeff_decimation', coeff_decimation, ...
          'coeff_generation', coeff_generation, ...
          'cal_bits', 'cal_bits', ...
          'n_bits_rotation', 'n_bits_rotation', ...
          'max_fanout', 'max_fanout', ...
          'use_hdl', stage_mult_spec(stage+1).use_hdl, ...
          'use_embedded', stage_mult_spec(stage+1).use_embedded, ...
          'bitgrowth', bitgrowth_stage, ...
          'hardcode_shifts', hardcode_shifts, ...
          'dsp48_adders', dsp48_adders);

      %sync inputs to butterfly
      if (stage == 0), add_line(blk, 'sync/1', [butterfly,'/3']);
      else add_line(blk, ['butterfly',num2str(stage-1),'_',num2str(floor(n/(multiple*2))),'/4'], [butterfly,'/3']);
      end
      if stage == (FFTSize-1),
        if n == 0, 
          add_line(blk, [butterfly,'/4'], 'sync_out/1');
        else,
          tname = ['synct',num2str(floor(n/multiple))];
          reuse_block(blk, tname, 'built-in/Terminator', 'NamePlacement', 'alternate', ...
            'Position',  [xtick*FFTSize+80 (ytick*n*2*n_streams)+145 xtick*FFTSize+95 (ytick*n*2*n_streams)+160]);
          add_line(blk, [butterfly,'/4'], [tname,'/1']);
        end
      end
      add_line(blk, ['slice',num2str(stage),'/1'], [butterfly, '/4']);

      %en inputs
      if strcmp(async, 'on'),
        if (stage == 0), 
          add_line(blk, 'en/1', [butterfly,'/5']);
        else 
          add_line(blk, ['butterfly', num2str(stage-1),'_',num2str(floor(n/(multiple*2))),'/5'], [butterfly,'/5']);
        end
        if stage == (FFTSize-1), 
          if n == 0,
            add_line(blk, [butterfly,'/5'], 'dvalid/1');
          else
            tname = ['en',num2str(floor(n/multiple))];
            reuse_block(blk, tname, 'built-in/Terminator', ...
             'Position',  [xtick*FFTSize+80 (ytick*n*2*n_streams)+162 xtick*FFTSize+95 (ytick*n*2*n_streams)+177]);
            add_line(blk, [butterfly,'/5'], [tname,'/1']);
          end
        end
      end

      %data inputs
      if (stage == 0),          %first stage
        add_line(blk, 'abus/1', [butterfly,'/1']); 
        add_line(blk, 'bbus/1', [butterfly,'/2']); 
      else, %intermediate stages
        src = inputs(mod(floor(n/(multiple)),2)+1);
        add_line(blk, [src,'debus',num2str(stage-1),'_',num2str(floor(n/(multiple*2))),'/1'], [butterfly,'/1']);
        add_line(blk, [src,'debus',num2str(stage-1),'_',num2str(floor(n/(multiple*2))),'/2'], [butterfly,'/2']);
      end

      %add lines for overflow logic
      if (FFTSize ~= 1), add_line(blk, [butterfly,'/3'], ['of_',num2str(stage),'/',num2str(floor(n/multiple)+1)]);
      else add_line(blk, [butterfly,'/3'], 'of/1')
      end
    end %if   
    
    %time to split output of current stage
    if stage < (FFTSize-1) && mod(n, multiple/2) == 0,
      if strcmp(bitgrowth, 'on'), n_bits_debus = min(max_bits, n_bits_stage_in+1)*2*multiple/2;
      else, n_bits_debus = n_bits_stage_in*2*multiple/2;
      end

      src = num2str(inputs(mod(floor(n/(multiple/2)),2)+1));
      debus = [src, 'debus', num2str(stage), '_', num2str(floor(n/multiple))];
      clog(['adding ',debus], 'fft_direct_init_debug');
      pos = [90+(xtick*(stage+1)) (ytick*n*2*n_streams)+100 120+(xtick*(stage+1)) (ytick*(n_streams*(n*2)+multiple/2-1))+130];
      reuse_block(blk, debus, 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', 'outputNum', '2', ...
        'outputWidth', mat2str(repmat(n_bits_debus*n_streams, 1, 2)), 'outputBinaryPt', mat2str(zeros(1,2)), ... 
        'outputArithmeticType', mat2str(zeros(1,2)), 'Position', pos);

      add_line(blk, [butterfly,'/',num2str(mod(floor(n/(multiple/2)),2)+1)], [debus,'/1']);
    end %if
    
  end %for
end %for

%outputs
for n = 0:2^FFTSize-1,
  %connect final butterfly stage to debus 
  butterfly = ['butterfly',num2str(FFTSize-1),'_',num2str(floor(n/2))];
  src = inputs(mod(n,2)+1);
  debus = [src, 'debus', num2str(FFTSize-1), '_', num2str(floor(n/2))];
  add_line(blk, [butterfly,'/',num2str(mod(n,2)+1)], [debus,'/1']); 
end %for n

clean_blocks(blk);

if strcmp(map_tail, 'on'), stages = [num2str(StartStage),':',num2str(StartStage+FFTSize-1)];
else stages = ['0:',num2str(FFTSize-1)];
end

fmtstr = sprintf('stages [%s] of %d\n[%d,%d]\n%s\n%s', stages, ...
  actual_fft_size,  input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_direct_init','trace');
