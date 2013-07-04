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

% Set default vararg values.
defaults = { ...
    'n_inputs', 1, ...
    'FFTSize', 3,  ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18, ...
    'map_tail', 'on', ...
    'LargerFFTSize', 6, ...
    'StartStage', 4, ...
    'async', 'on', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'coeffs_bit_limit', 8,  ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'on', ...
    'coeff_generation', 'on', ...
    'cal_bits', 1, ...
    'n_bits_rotation', 25, ...
    'max_fanout', 4, ...
    'mult_spec', [2], ...
    'bitgrowth', 'off', ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1], ...
    'dsp48_adders', 'off', ...
};

xtick = 300;
ytick = 100;

%if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_direct_init post same_state','trace');
check_mask_type(blk, 'fft_direct');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_inputs          = get_var('n_inputs', 'defaults', defaults, varargin{:});
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
hardcode_shifts   = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule    = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders      = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

if FFTSize == 0 | n_inputs == 0,
  delete_lines(blk);
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fft_direct_init','trace');
  return;
end
% check the per-stage multiplier specification
stage_mult_spec = multiplier_specification(mult_spec, FFTSize, blk);

current_stages = find_system(blk, ...
    'lookUnderMasks', 'all', ...
    'FollowLinks', 'on', ...
    'SearchDepth', 1, ...
    'masktype', 'butterfly_direct');
prev_stages = length(current_stages);

delete_lines(blk);
% Add ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 0 60 15], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [30 45 60 60], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [xtick*FFTSize+150 0 xtick*FFTSize+180 15], 'Port', '1');
for i=0:2^FFTSize-1,
    reuse_block(blk, ['in',num2str(i)], 'built-in/inport', ...
      'Port', num2str(i+3), 'Position', [30 ytick*i+100 60 ytick*i+115]);
    reuse_block(blk, ['out',num2str(i)], 'built-in/outport', ...
      'Port', num2str(i+2), 'Position', [xtick*FFTSize+150 ytick*i+100 xtick*FFTSize+180 ytick*i+115]);
end
reuse_block(blk, 'of', 'built-in/outport', 'Port', num2str((2^FFTSize)+2), ...
    'Position', [xtick*FFTSize+200 ytick*(2^FFTSize)+100 xtick*FFTSize+230 ytick*(2^FFTSize)+115]);

if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/inport', ...
    'Port', num2str(2^FFTSize+3), 'Position', [30 ytick*(2^FFTSize+1)+100 60 ytick*(2^FFTSize+1)+115]);
  reuse_block(blk, 'dvalid', 'built-in/outport', 'Port', num2str((2^FFTSize)+2), ...
    'Position', [xtick*FFTSize+150 ytick*(2^FFTSize+1)+100 xtick*FFTSize+180 ytick*(2^FFTSize+1)+115]);
end

%FFTSize == 1 implies 1 input or block which generates an error
if (FFTSize ~= 1),
    pos = [xtick*FFTSize+150 ytick*(2^FFTSize)+100 xtick*FFTSize+180 ytick*(2^FFTSize)+115+(FFTSize*10)];
    reuse_block(blk, 'of_or', 'xbsIndex_r4/Logical', ...
        'Position', pos, ...
        'logical_function', 'OR', ...
        'inputs', num2str(FFTSize), ...
        'latency', '1');
    add_line(blk, 'of_or/1', 'of/1');
end

%create bus on entry to the first stage
inputs = ['a','b'];
multiple = 2^(FFTSize-1);
for i = 0:1,
  name = [inputs(i+1), 'bus'];
  clog(['adding ',name], 'fft_direct_init_debug');
  pos = [90 (ytick*(i*multiple))+100 120 ytick*((i+1)*multiple-1)+130];
  reuse_block(blk, name, 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(multiple), 'Position', pos);
end

% join input ports to create busses
for i = 0:2^FFTSize-1,
  input = inputs(floor(i/multiple)+1);
  add_line(blk, ['in',num2str(i),'/1'], [input,'bus/', num2str(mod(i,multiple)+1)]);
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
        pos = [xtick*(stage+1)+90 ytick*(2^FFTSize)+100+(stage*15) xtick*(stage+1)+120 120+ytick*(2^FFTSize)+(FFTSize*5)+(stage*15)];
        
        if stage == 0, %first stage has only one output
          reuse_block(blk, ['of_', num2str(stage)], 'xbsIndex_r4/Delay', ...
              'Position', pos, 'latency', '0');
        else          %other stages must have of outputs concatenated
          reuse_block(blk, ['of_', num2str(stage)], 'xbsIndex_r4/Concat', ...
              'Position', pos, 'num_inputs', num2str(n_unique));
        end %if
        add_line(blk, ['of_',num2str(stage),'/1'], ['of_or/',num2str(stage+1)]);
    end %if

    for i = 0:2^(FFTSize-1)-1,
      input = inputs(mod(floor(i/multiple),2)+1);

      %into next set of unique coefficients so add new butterfly
      if mod(i, multiple) == 0,
        % Implement a normal FFT or the tail end of a larger FFT
        if strcmp(map_tail, 'off'),
            coeffs = ['[',num2str(floor(i/2^(FFTSize-(stage+1)))),']'];
            actual_fft_size = FFTSize;
            num_coeffs = 1;
        else
            redundancy = 2^(LargerFFTSize - FFTSize);
            coeffs = '[';
            for r=0:redundancy-1,
                n = bit_reverse(r, LargerFFTSize - FFTSize);
                coeffs = [coeffs,' ',num2str(floor((i+n*2^(FFTSize-1))/2^(LargerFFTSize-(StartStage+stage))))];
            end
            coeffs = [coeffs, ']'];
            actual_fft_size = LargerFFTSize;
            num_coeffs = redundancy;
        end

        butterfly = ['butterfly', num2str(stage), '_', num2str(floor(i/multiple))];
        clog(['adding ',butterfly], 'fft_direct_init_debug');
        pos = [(xtick*stage)+220 (ytick*i*2)+100 (xtick*stage)+300 (ytick*((i*2)+multiple-1))+175];

        %TODO calculate bit width in for bitgrowth FFT
        reuse_block(blk, butterfly, 'casper_library_ffts/butterfly_direct', ...
            'Position', pos, ...
            'n_inputs', num2str(n_inputs), ...
            'biplex', 'off', ...
            'FFTSize', num2str(actual_fft_size), ...
            'Coeffs', coeffs, ...
            'StepPeriod', '0', ...
            'coeff_bit_width', num2str(coeff_bit_width), ...
            'input_bit_width', num2str(input_bit_width), ...
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
            'bitgrowth', bitgrowth, ...
            'hardcode_shifts', hardcode_shifts, ...
            'dsp48_adders', dsp48_adders);

        %sync inputs to butterfly
        if (stage == 0), add_line(blk, 'sync/1', [butterfly,'/3']);
        else add_line(blk, ['butterfly',num2str(stage-1),'_',num2str(floor(i/(multiple*2))),'/4'], [butterfly,'/3']);
        end
        if stage == (FFTSize-1),
          if i == 0, 
            add_line(blk, [butterfly,'/4'], 'sync_out/1');
          else,
            tname = ['synct',num2str(floor(i/multiple))];
            reuse_block(blk, tname, 'built-in/Terminator', 'NamePlacement', 'alternate', ...
              'Position',  [xtick*FFTSize+135 (ytick*i*2)+145 xtick*FFTSize+155 (ytick*i*2)+160]);
            add_line(blk, [butterfly,'/4'], [tname,'/1']);
          end
        end
        add_line(blk, ['slice',num2str(stage),'/1'], [butterfly, '/4']);

        %en inputs
        if strcmp(async, 'on'),
          if (stage == 0), 
            add_line(blk, 'en/1', [butterfly,'/5']);
          else 
            add_line(blk, ['butterfly', num2str(stage-1),'_',num2str(floor(i/(multiple*2))),'/5'], [butterfly,'/5']);
          end
          if stage == (FFTSize-1), 
            if i == 0,
              add_line(blk, [butterfly,'/5'], 'dvalid/1');
            else
              tname = ['en',num2str(floor(i/multiple))];
              reuse_block(blk, tname, 'built-in/Terminator', ...
               'Position',  [xtick*FFTSize+135 (ytick*i*2)+162 xtick*FFTSize+155 (ytick*i*2)+177]);
              add_line(blk, [butterfly,'/5'], [tname,'/1']);
            end
          end
        end

        %data inputs
        if (stage == 0),          %first stage
          add_line(blk, 'abus/1', [butterfly,'/1']); 
          add_line(blk, 'bbus/1', [butterfly,'/2']); 
        else, %intermediate stages
          src = inputs(mod(floor(i/(multiple)),2)+1);
          add_line(blk, [src,'debus',num2str(stage-1),'_',num2str(floor(i/(multiple*2))),'/1'], [butterfly,'/1']);
          add_line(blk, [src,'debus',num2str(stage-1),'_',num2str(floor(i/(multiple*2))),'/2'], [butterfly,'/2']);
        end

        %add lines for overflow logic
        if (FFTSize ~= 1), add_line(blk, [butterfly,'/3'], ['of_',num2str(stage),'/',num2str(floor(i/multiple)+1)]);
        else add_line(blk, [butterfly,'/3'], 'of/1')
        end
      end %if   
      
      %time to add debus
      if stage < (FFTSize-1) && mod(i, multiple/2) == 0,
        src = num2str(inputs(mod(floor(i/(multiple/2)),2)+1));
        debus = [src, 'debus', num2str(stage), '_', num2str(floor(i/multiple))];
        clog(['adding ',debus], 'fft_direct_init_debug');
        pos = [90+(xtick*(stage+1)) (ytick*i*2)+100 120+(xtick*(stage+1)) (ytick*((i*2)+multiple/2-1))+130];
        reuse_block(blk, debus, 'casper_library_flow_control/bus_expand', ...
          'mode', 'divisions of equal size', 'outputNum', '2', ...
          'outputWidth', mat2str(n_bits*multiple, 2, 1), 'outputBinaryPt', mat2str(zeros(1,2)), ... 
          'outputArithmeticType', mat2str(zeros(1,2)), 'Position', pos);

        add_line(blk, [butterfly,'/',num2str(mod(floor(i/(multiple/2)),2)+1)], [debus,'/1']);
      end %if
    end %for
end %for

%outputs
for i = 0:2^FFTSize-1,
  output_index = num2str(bit_rev(i, FFTSize));
  src_index = num2str(floor(i/2));
  port_index = num2str(mod(i,2)+1);
  add_line(blk, ['butterfly',num2str(FFTSize-1),'_',src_index, '/',port_index], ['out',output_index,'/1']);
end


% Add butterflies
%for stage = 1 : FFTSize,
%    if (strcmp(hardcode_shifts, 'on') && (shift_schedule(stage) == 1)), downshift = 'on';
%    else, downshift = 'off';
%    end
%
%    %add overflow logic
%    if (FFTSize ~= 1),
%        pos = [xtick*stage+90 ytick*(2^FFTSize)+100+(stage*15) xtick*stage+120 120+ytick*(2^FFTSize)+(FFTSize*5)+(stage*15)];
%        reuse_block(blk, ['of_', num2str(stage)], 'xbsIndex_r4/Logical', ...
%            'Position', pos, ...
%            'logical_function', 'OR', ...
%            'inputs', num2str(2^(FFTSize-1)), ...
%            'latency', '1');
%        add_line(blk, ['of_',num2str(stage),'/1'], ['of_or/',num2str(stage)]);
%    end
%
%    for i=0:2^(FFTSize-1)-1,
%        % Implement a normal FFT or the tail end of a larger FFT
%        if strcmp(map_tail, 'off'),
%            coeffs = ['[',num2str(floor(i/2^(FFTSize-stage))),']'];
%            actual_fft_size = FFTSize;
%            num_coeffs = 1;
%        else
%            redundancy = 2^(LargerFFTSize - FFTSize);
%            coeffs = '[';
%            for r=0:redundancy-1,
%                n = bit_reverse(r, LargerFFTSize - FFTSize);
%                coeffs = [coeffs,' ',num2str(floor((i+n*2^(FFTSize-1))/2^(LargerFFTSize-(StartStage+stage-1))))];
%            end
%            coeffs = [coeffs, ']'];
%            actual_fft_size = LargerFFTSize;
%            num_coeffs = redundancy;
%        end
%
%        % calculate if we must use BRAM for coeffs
%        if ((num_coeffs * coeff_bit_width * 2) > 2^coeffs_bit_limit), coeffs_bram = 'on';
%        else, coeffs_bram = 'off';
%        end
%
%        name = ['butterfly', num2str(stage), '_', num2str(i)];
%        pos = [xtick*(stage-1)+220 2*ytick*i+100 xtick*(stage-1)+300 2*ytick*i+175];
%        biplex = get_var('biplex', 'defaults', defaults, varargin{:});
%
%        %TODO calculate bit width in for bitgrowth FFT
%        %TODO work out identical coeffs 
%        reuse_block(blk, name, 'casper_library_ffts/butterfly_direct', ...
%            'Position', pos, ...
%            'n_inputs', num2str(n_inputs), ...
%            'biplex', 'off', ...
%            'FFTSize', num2str(actual_fft_size), ...
%            'Coeffs', coeffs, ...
%            'StepPeriod', '0', ...
%            'coeff_bit_width', num2str(coeff_bit_width), ...
%            'input_bit_width', num2str(input_bit_width), ...
%            'bin_pt_in', num2str(bin_pt_in), ...
%            'downshift', downshift, ...
%            'async', async, ...
%            'bram_latency', num2str(bram_latency), ...
%            'add_latency', num2str(add_latency), ...
%            'mult_latency', num2str(mult_latency), ...
%            'conv_latency', num2str(conv_latency), ...
%            'quantization', quantization, ...
%            'overflow', overflow, ...
%            'coeffs_bram', coeffs_bram, ...
%            'coeff_sharing', coeff_sharing, ...
%            'coeff_decimation', coeff_decimation, ...
%            'coeff_generation', coeff_generation, ...
%            'cal_bits', 'cal_bits', ...
%            'n_bits_rotation', 'n_bits_rotation', ...
%            'max_fanout', 'max_fanout', ...
%            'use_hdl', stage_mult_spec(stage).use_hdl, ...
%            'use_embedded', stage_mult_spec(stage).use_embedded, ...
%            'bitgrowth', bitgrowth, ...
%            'hardcode_shifts', hardcode_shifts, ...
%            'dsp48_adders', dsp48_adders);
%
%        node_one_num = 2^(FFTSize-stage+1)*floor(i/2^(FFTSize-stage)) + mod(i, 2^(FFTSize-stage));
%        node_two_num = node_one_num+2^(FFTSize-stage);
%        input_one = ['node',num2str(stage-1),'_',num2str(node_one_num),'/1'];
%        input_two = ['node',num2str(stage-1),'_',num2str(node_two_num),'/1'];
%        output_one = ['node',num2str(stage),'_',num2str(node_one_num),'/1'];
%        output_two = ['node',num2str(stage),'_',num2str(node_two_num),'/1'];
%        add_line(blk, input_one, [name,'/1']);
%        add_line(blk, input_two, [name,'/2']);
%        add_line(blk, [name,'/1'], output_one);
%        add_line(blk, [name,'/2'], output_two);
%        
%        %sync inputs to butterfly
%        if (stage == 1), add_line(blk, 'sync/1', [name,'/3']);
%        else add_line(blk, ['butterfly',num2str(stage-1),'_',num2str(i),'/4'], [name,'/3']);
%       end
%       if ((stage == FFTSize) && (i == 0)),
%           add_line(blk, [name,'/4'], 'sync_out/1');
%       end
%       add_line(blk, ['slice',num2str(stage-1),'/1'], [name, '/4']);
%
%       %en inputs
%       if strcmp(async, 'on'),
%         if (stage == 1), add_line(blk, 'en/1', [name,'/5']);
%         else add_line(blk, ['butterfly', num2str(stage-1),'_',num2str(i), '/5'], [name,'/5']);
%         end
%         if ((stage == FFTSize) && (i == 0)),
%           add_line(blk, [name,'/5'], 'dvalid/1');
%         end
%       end
%
%        %add lines for overflow logic
%        if (FFTSize ~= 1), add_line(blk, [name,'/3'], ['of_',num2str(stage),'/',num2str(i+1)])
%        else add_line(blk, [name,'/3'], 'of/1')
%        end
%    end %for
%end %for stage

%clean_blocks(blk);

fmtstr = sprintf('stages [%s] of %d\n[%d,%d]\n%s\n%s', num2str([StartStage:1:StartStage+FFTSize-1]), ...
    actual_fft_size,  input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_direct_init','trace');
