%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function red_pitaya_dac_mask(blk)

myname = blk;
% get hardware platform from XSG block

gateway_outs = find_system(myname, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw, 'Name'), '(dac_reset_in)$')
        toks = regexp(get_param(gw, 'Name'), '(dac_reset_in)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(dac_data_valid_in)$')
        toks = regexp(get_param(gw, 'Name'), '(dac_data_valid_in)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(dac0_data_i_in)$')
        toks = regexp(get_param(gw, 'Name'), '(dac0_data_i_in)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}])); 
    elseif regexp(get_param(gw, 'Name'), '(dac1_data_q_in)$')
        toks = regexp(get_param(gw, 'Name'), '(dac1_data_q_in)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));          
    else
        error(['Unknown gateway name: ', gw]);
    end
end

gateway_ins =find_system(myname, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};       
end

