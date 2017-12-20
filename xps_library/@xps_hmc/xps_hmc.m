
function b = xps_hmc(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_HMC class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_hmc')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj  = get(blk_obj,'xsg_obj');

s.hw_sys   = get(xsg_obj,'hw_sys');
s.clk_src  = get(xsg_obj,'clk_src');
s.clk_rate = get(xsg_obj,'clk_rate');

s.hw_qdr      = get_param(blk_name,'which_qdr');
s.use_sniffer = num2str(strcmp(get_param(blk_name, 'use_sniffer'), 'on')); 

switch s.hw_sys
  
    case 'ROACH2'
        s.addr_width = '21';
        s.data_width = '36';
        s.bw_width = '4';
    % end case 'ROACH2'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_hmc',blk_obj);

b = set(b, 'opb0_devices', 2); %sniffer and controller
