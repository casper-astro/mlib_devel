%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKA Africa                                                                %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2013 Andrew Martens (andrew@ska.ac.za)                      %
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

function bus_replicate_init(blk, varargin)
  log_group = 'bus_replicate_init_debug';
  
  clog('entering bus_replicate_init', {log_group, 'trace'});
  defaults = { ...
    'replication', 8, 'latency', 4, 'misc', 'on', ...
    'implementation', 'core'}; %'core' 'behavioral'
  
  check_mask_type(blk, 'bus_replicate');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 100;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  del_w = 30; del_d = 20;
  bus_create_w = 50;

  replication     = get_var('replication', 'defaults', defaults, varargin{:});
  latency         = get_var('latency', 'defaults', defaults, varargin{:});
  misc            = get_var('misc', 'defaults', defaults, varargin{:});
  implementation  = get_var('implementation', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if replication == 0 || isempty(replication),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_replicate_init', {log_group, 'trace'});
    return;
  end

  %%%%%%%%%%%%%%%  
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos + (yinc*replication)/2;  
  reuse_block(blk, 'in', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + (replication*yinc)/2;

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end
  xpos = xpos + xinc;  

  %%%%%%%%%%%%%%%%%%%%%%%%%%% 
  % delay layer if required %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%

  if strcmp(implementation, 'behavioral'), reg_retiming_global = 'on';
  else, reg_retiming_global = 'off';
  end 

  xpos_tmp = xpos;
  rps = replication^(1/latency);
  if latency > 0,
    prev_rep_required = 1;

    for stage_index = 0:latency-1,  
      ypos_tmp = ypos;
      
      if (stage_index == 0), rep = floor(rps);
      else, rep = ceil(rps);
      end

      %force the final stage to have the full amount of replication
      if stage_index == latency-1, rep_required = replication;
      else, rep_required = min(prev_rep_required * rep, replication);
      end

      clog([num2str(rep_required), ' replication required for stage ',num2str(stage_index)], log_group);

      for rep_index = 0:rep_required-1,
        dname = ['din', num2str(stage_index), '_', num2str(rep_index)];
        % implement with behavioral HDL if we have reached the replication amount required
        % before the final delay stage to potentially save resources
        if (rep_required == replication) && (stage_index ~= latency-1), reg_retiming = 'on';
        else, reg_retiming = reg_retiming_global;
        end
        reuse_block(blk, dname, 'xbsIndex_r4/Delay', ...
          'reg_retiming', reg_retiming, 'latency', '1', ...
          'Position', [xpos_tmp-del_w/2 ypos_tmp-del_d/2 xpos_tmp+del_w/2 ypos_tmp+del_d/2]);

        if stage_index == 0, add_line(blk, 'in/1', [dname,'/1']); 
        else, add_line(blk, ['din', num2str(stage_index-1), '_', num2str(mod(rep_index, prev_rep_required)), '/1'], [dname, '/1']); 
        end

        ypos_tmp = ypos_tmp + yinc;
      end %for

      prev_rep_required = rep_required;
      xpos_tmp = xpos_tmp + xinc;
    end %for stage_index   

    ypos_tmp = ypos + (replication+1)*yinc;
    if strcmp(misc, 'on'), 
      reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
        'reg_retiming', 'on', 'latency', num2str(latency), ...
        'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
      add_line(blk, 'misci/1', 'dmisc/1');    
    end %if strcmp

    xpos = xpos + latency*xinc;
  end %if latency > 0

  %%%%%%%%%%%%%%
  % create bus %
  %%%%%%%%%%%%%%

  ypos_tmp = ypos;
  reuse_block(blk, 'bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(replication), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp xpos+bus_create_w/2 ypos_tmp+replication*yinc]);
  
  for index = 1:replication,
    if latency > 0, 
      dsrc = ['din', num2str(latency-1), '_', num2str(index-1),'/1'];
      msrc = ['dmisc/1'];
    else, 
      dsrc = 'in/1';
      msrc = 'misci/1';
    end

    add_line(blk, dsrc, ['bussify/',num2str(index)]);
  end

  %%%%%%%%%%%%%%%%% 
  % output port/s %
  %%%%%%%%%%%%%%%%%
  
  ypos_tmp = ypos + replication*yinc/2;
  xpos = xpos + xinc + bus_create_w/2;
  reuse_block(blk, 'out', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bussify/1'], ['out/1']);
  ypos_tmp = ypos_tmp + yinc + replication*yinc/2;  

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, msrc, 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_replicate_init','trace');

end %function bus_replicate_init


