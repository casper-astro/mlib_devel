%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function red_pitaya_dac_mask(blk)

myname = blk;
% get hardware platform from XSG block
adc_blk = find_system(myname);
bits_str=convertCharsToStrings(get_param(adc_blk{1},'bits'));

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

casts = find_system(myname, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Type Converter Block');
for i =1:length(casts)
    cst = casts{i};
    if regexp(get_param(cst, 'Name'), '(convert_dac0_data_i_in)$')
        set_param(cst, 'n_bits', bits_str); 
    elseif regexp(get_param(cst, 'Name'), '(convert_dac1_data_q_in1)$')
        set_param(cst, 'n_bits', bits_str);      
    elseif regexp(get_param(cst, 'Name'), '(convert_dac_data_valid_in)$')

    elseif regexp(get_param(cst, 'Name'), '(convert_dac_reset_in)$')
	
    else 
        error(['Unknown gateway name: ', cst]);
    end
end
