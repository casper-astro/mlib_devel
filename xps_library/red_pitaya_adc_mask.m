%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function red_pitaya_adc_mask(blk)

myname = blk;
% get hardware platform from XSG block
adc_blk = find_system(myname);
bits_str=convertCharsToStrings(get_param(adc_blk{1},'bits'));

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
    if regexp(get_param(gw, 'Name'), '(adc_data_val_out)$')
        toks = regexp(get_param(gw, 'Name'), '(adc_data_val_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(adc0_data_i_out)$')
        set_param(gw, 'n_bits', bits_str);
        toks = regexp(get_param(gw, 'Name'), '(adc0_data_i_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(adc1_data_q_out)$')
        set_param(gw, 'n_bits', bits_str);
        toks = regexp(get_param(gw, 'Name'), '(adc1_data_q_out)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    else
        error(['Unknown gateway name: ', gw]);
    end
end

casts = find_system(myname, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Type Converter Block');
for i =1:length(casts)
    cst = casts{i};
    if regexp(get_param(cst, 'Name'), '(Convert6)$')
        set_param(cst, 'n_bits', bits_str); 
    elseif regexp(get_param(cst, 'Name'), '(Convert18)$')
        set_param(cst, 'n_bits', bits_str);      
    elseif regexp(get_param(cst, 'Name'), '(Convert2)$')

    elseif regexp(get_param(cst, 'Name'), '(convert_adc_reset_in)$')
	
    else 
        error(['Unknown gateway name: ', cst]);
    end
end

