%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function red_pitaya_adc_mask(blk)

myname = blk;
% get hardware platform from XSG block

gateway_outs = find_system(myname, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw, 'Name'), '(adc_reset_in)$')
        toks = regexp(get_param(gw, 'Name'), '(adc_reset_in)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    else
        error(['Unknown gateway name: ', gw]);
    end
end

gateway_ins =find_system(myname, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw, 'Name'), '(adc0_data_val_out)$')
        toks = regexp(get_param(gw, 'Name'), '(adc0_data_val_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(adc0_data_i_out)$')
        toks = regexp(get_param(gw, 'Name'), '(adc0_data_i_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(adc0_data_q_out)$')
        toks = regexp(get_param(gw, 'Name'), '(adc0_data_q_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));        
    elseif regexp(get_param(gw, 'Name'), '(adc1_data_val_out)$')
        toks = regexp(get_param(gw, 'Name'), '(adc1_data_val_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(adc1_data_i_out)$')
        toks = regexp(get_param(gw, 'Name'), '(adc1_data_i_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));	 
    elseif regexp(get_param(gw, 'Name'), '(adc1_data_q_out)$')
        toks = regexp(get_param(gw, 'Name'), '(adc1_data_q_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));        
    else
        error(['Unknown gateway name: ', gw]);
    end
end

