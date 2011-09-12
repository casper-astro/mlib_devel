% Polynomial.
%
% polynomial_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% n_polys = number of polynomials to implement
% degree = polynomial degree
% mult_latency = multiplier latency 
% bits_out = number of bits in output
% bin_pt_out = binary point position of output
% conv_latency = latency of convert/cast block
% quantization = rounding/quantisation strategy 
% overflow = overflow strategy

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   MeerKAT Radio Telescope Project                                           %
%   Copyright (C) 2011 Andrew Martens                                         %
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

function polynomial_init(blk,varargin)

clog('entering polynomial_init', 'trace');
check_mask_type(blk, 'polynomial');

defaults = {'n_polys', 1, 'degree', 3, 'mult_latency', 2, ...
  'bits_out', 18, 'bin_pt_out', 17, 'conv_latency', 2, ...
  'quantization', 'Truncate', 'overflow', 'Wrap', ...
  'bits_in', 8, 'bin_pt_in', 0};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('polynomial_init: post same_state', 'trace');
munge_block(blk, varargin{:});
delete_lines(blk);

n_polys = get_var('n_polys', 'defaults', defaults, varargin{:});
degree = get_var('degree', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bits_out = get_var('bits_out', 'defaults', defaults, varargin{:});
bin_pt_out = get_var('bin_pt_out', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
bits_in = get_var('bits_in', 'defaults', defaults, varargin{:});
bin_pt_in = get_var('bin_pt_in', 'defaults', defaults, varargin{:});

xinc = 50+25*degree; %adder names become larger with higher degree
yinc = 100;

% Take care of misc 
reuse_block(blk, 'misc', 'built-in/inport', 'Port', '1', 'Position', [xinc-10 yinc-8 xinc+10 yinc+8]);
reuse_block(blk, 'misc_out', 'built-in/outport', 'Port', '1' , ...
  'Position', [((degree+3+1)*xinc)-10 yinc-8 ((degree+3+1)*xinc)+10 yinc+8]);
if n_polys > 0,  
  reuse_block(blk, 'misc_delay', 'xbsIndex_r4/Delay', ...
    'latency', 'mult_latency*(degree+1)+conv_latency', ...
    'Position', [(2*xinc)-15 yinc-10 ((degree+3)*xinc)+15 yinc+10]);
  add_line(blk, 'misc/1', 'misc_delay/1');
  add_line(blk, 'misc_delay/1', 'misc_out/1');
else
  add_line(blk, 'misc/1', 'misc_out/1');
end

%set up x delay and mult chain
reuse_block(blk, 'x', 'built-in/inport', 'Port', '2', 'Position', [xinc/2-10 2*yinc-8 xinc/2+10 2*yinc+8]);

prev_del_blk = 'x';
if n_polys > 0, %don't bother if number of polynomials less than 1

  %x must be signed for MACs to be synthesised
  reuse_block(blk, 'convx', 'xbsIndex_r4/Convert', ...
    'arith_type', 'Signed', ...
    'latency', '0', 'quantization', 'Truncate', 'overflow', 'Wrap', ...
    'n_bits', 'bits_in+1', 'bin_pt', 'bin_pt_in', ...
    'Position', [xinc-15 2*yinc-8 xinc+15 2*yinc+8]);
  add_line(blk, 'x/1', 'convx/1');
  
  prev_mult_blk = 'convx';
  prev_del_blk = 'convx';
  for n = 2:degree,

    %delay block
    if n < degree,
      cur_del_blk = ['x_d',num2str(n-2)];
      latency = 'mult_latency';
      xend = n*xinc+15;
      reuse_block(blk, cur_del_blk, 'xbsIndex_r4/Delay', 'latency', latency, ...
        'Position', [n*xinc-15 2*yinc-10 xend 2*yinc+10]);
      add_line(blk, [prev_del_blk,'/1'], [cur_del_blk,'/1']);
      prev_del_blk = cur_del_blk;
    end

    %mult block
    cur_mult_blk = ['x^',num2str(n)];
    reuse_block(blk, cur_mult_blk, 'xbsIndex_r4/Mult', 'latency', 'mult_latency', ...
      'precision', 'Full', 'use_behavioral_HDL', 'on', ...
      'Position', [n*xinc-15 3*yinc-15 n*xinc+15 3*yinc+15]);
    add_line(blk, [prev_del_blk,'/1'],[cur_mult_blk,'/1']);
    add_line(blk, [prev_mult_blk,'/1'],[cur_mult_blk,'/2']);
    prev_mult_blk = cur_mult_blk;
  
  end
end

if n_polys > 0,
  %last delay block
  cur_del_blk = ['x_d',num2str(max(0,degree-2))];
  latency = [num2str(min(degree+1,3)),'*mult_latency+conv_latency'];
  xend = (degree+3)*xinc+15;
  reuse_block(blk, cur_del_blk, 'xbsIndex_r4/Delay', 'latency', latency, ...
    'Position', [max(degree,2)*xinc-15 2*yinc-10 xend 2*yinc+10]);
  add_line(blk, [prev_del_blk,'/1'], [cur_del_blk,'/1']);
  prev_del_blk = cur_del_blk;
end

reuse_block(blk, 'x_out', 'built-in/outport', 'Port', '2', ...
  'Position', [((degree+3+1)*xinc)-10 2*yinc-8 ((degree+3+1)*xinc)+10 2*yinc+8]);
add_line(blk, [prev_del_blk,'/1'], 'x_out/1');

%set up polynomial mult chain for each input
yoff=5;
poff=3;
xoff=1;
for poly = 0:n_polys-1,
  src_mult_blk = 'convx';
  base = sprintf('%c',('a'+poly)); %a, b, c etc  
  
  y_offset = yoff+(poly*(degree+1));
  p_offset = poff+(poly*(degree+1));
  port_name = [base,'0'];
  %a/b/c...0 input ports
  reuse_block(blk, port_name, 'built-in/inport', 'Port', ['',num2str(p_offset),''], ...
    'Position', [(xoff*xinc)-10 (y_offset*yinc)-8 (xoff*xinc)+10 (y_offset*yinc)+8]);
  reuse_block(blk, [port_name,'_del'], 'xbsIndex_r4/Delay', 'latency', 'mult_latency', ...
    'Position', [((xoff+1)*xinc)-15 (y_offset*yinc)-10 ((xoff+1)*xinc)+15 (y_offset*yinc)+10]);
  add_line(blk, [port_name,'/1'], [port_name,'_del/1']);
 
  add_name = port_name; %adder names starting with coefficient 0
  prev_adder = [port_name,'_del']; %input to first adder is delay
  for n = 1:degree,

    mult_name = [base,num2str(n),src_mult_blk];
    
    %adder
    add_name = [add_name,'+',mult_name]; %recursively build adder names
    reuse_block(blk, add_name, 'xbsIndex_r4/AddSub', 'latency', 'mult_latency', ...
      'use_behavioral_HDL', 'on', 'pipelined', 'on', ...
      'Position', [((xoff+n+1)*xinc)-20 (y_offset*yinc)-20 (xoff+n+1)*xinc+20 (y_offset*yinc)+20]);
    add_line(blk, [prev_adder,'/1'], [add_name,'/1']);
    prev_adder = add_name;

    %coefficient input port
    port_name = [base, num2str(n)];
    coeff_port = p_offset+n; 
    reuse_block(blk, port_name, 'built-in/inport', 'Port', ['',num2str(coeff_port),''], ...
      'Position', [xoff*xinc-10 ((y_offset+n)*yinc)-8 xoff*xinc+10 ((y_offset+n)*yinc)+8]);

    if n > 1,
      del_blk = [port_name,'_del'];
      %coefficient delay   
      reuse_block(blk, del_blk, 'xbsIndex_r4/Delay', 'latency', ['mult_latency*',num2str(n-1)], ...
        'Position', [((xoff+1)*xinc)-15 ((y_offset+n)*yinc)-10 ((xoff+n-1)*xinc)+15 ((y_offset+n)*yinc)+10]);
      add_line(blk, [port_name,'/1'], [del_blk,'/1']);
    else
      del_blk = port_name;    
    end 

    %polynomial multiplier
    reuse_block(blk, mult_name, 'xbsIndex_r4/Mult', 'latency', 'mult_latency', ...
      'precision', 'Full', 'use_behavioral_HDL', 'on', ...
      'Position', [(xoff+n)*xinc-15 ((y_offset+n)*yinc)-15 (xoff+n)*xinc+15 ((y_offset+n)*yinc)+15]);
    
    add_line(blk, [src_mult_blk,'/1'], [mult_name,'/1']);
    add_line(blk, [del_blk,'/1'], [mult_name,'/2']);
    src_mult_blk = ['x^',num2str(n+1)]; 
    add_line(blk, [mult_name,'/1'], [add_name,'/2']);

  end  

  %convert block
  conv_name = ['conv_',base,'(x)'];
  reuse_block(blk, conv_name, 'xbsIndex_r4/Convert', ...
    'n_bits', 'bits_out', 'bin_pt', 'bin_pt_out', 'pipeline', 'on', ...
    'latency', 'conv_latency', 'quantization', quantization, 'overflow', overflow, ...
    'Position', [((degree+3)*xinc)-20 ((yoff+poly*(degree+1))*yinc)-20 ((degree+3)*xinc)+20 ((yoff+poly*(degree+1))*yinc)+20]);
  add_line(blk, [prev_adder,'/1'], [conv_name,'/1']);

  %output port
  reuse_block(blk, [base,'(x)'], 'built-in/outport', 'Port', ['',num2str(3+poly),''], ...
    'Position', [((degree+3+1)*xinc)-10 ((yoff+poly*(degree+1))*yinc)-8 ((degree+3+1)*xinc)+10 ((yoff+poly*(degree+1))*yinc)+8]);
  add_line(blk, [conv_name,'/1'], [base,'(x)/1']);
  
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting polynomial_init', 'trace');
