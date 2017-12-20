%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function hmc_mask(blk)

myname = blk;
% get hardware platform from XSG block
try
    xsg_blk = find_system(bdroot(blk), 'SearchDepth', 1, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'xps:xsg');
    hw_sys = xps_get_hw_plat(get_param(xsg_blk{1}, 'hw_sys'));
catch
    if ~regexp(bdroot(blk), '(casper|xps)_library')
      warndlg('Could not find hardware platform for QDR configuration - is there an XSG block in this model? Defaulting platform to ROACH.');
      warning('Could not find hardware platform for QDR configuration - is there an XSG block in this model? Defaulting platform to ROACH.');
    end
    hw_sys = 'SKARAB';
end %try/catch

%clog(['Drawing QDR block for platform: ', hw_sys], 'qdr_mask_debug');

switch hw_sys
   
    case 'SKARAB'
        %data_width = 256;
        %be_width = 8;
        %n_mez = 3;
    % end case 'ROACH2'
end % end switch hw_sys

% catch incorrect mez selection
%which_mez = get_param(myname, 'which_mez');
%mez_num = str2num(which_mez(3));
%if (mez_num > (n_mez-1))
 %  set_param(myname, 'which_mez', 'mez0');
%end



gateway_outs = find_system(myname, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw, 'Name'), '(wr_en_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(wr_en_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rd_en_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_en_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rd_tag_in_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_tag_in_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(wr_address_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(wr_address_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rd_address_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_address_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(data_in_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(data_in_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));    
    elseif regexp(get_param(gw, 'Name'), '(wr_en_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(wr_en_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rd_en_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_en_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rd_tag_in_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_tag_in_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(wr_address_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(wr_address_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rd_address_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_address_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(data_in_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(data_in_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
   


    else
        error(['Unknown gateway name: ', gw]);
    end
end

gateway_ins =find_system(myname, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw, 'Name'), '(data_out_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(data_out_link2)$', 'tokens');
        new_gw_name = clear_name([myname, '_', toks{1}{1}]);
        %set_param(gw, 'n_bits', num2str(data_width));
        set_param(gw, 'Name', new_gw_name);
        gw = new_gw_name;
    elseif regexp(get_param(gw, 'Name'), '(data_out_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(data_out_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));	
    elseif regexp(get_param(gw, 'Name'), '(rd_tag_out_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_tag_out_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(post_ok)$')
        toks = regexp(get_param(gw, 'Name'), '(post_ok)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rd_ready_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_ready_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(data_valid_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(data_valid_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(init_done)$')
        toks = regexp(get_param(gw, 'Name'), '(init_done)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(wr_ready_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(wr_ready_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rd_tag_out_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_tag_out_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));   
    elseif regexp(get_param(gw, 'Name'), '(rd_ready_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(rd_ready_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(data_valid_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(data_valid_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}])); 
    elseif regexp(get_param(gw, 'Name'), '(wr_ready_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(wr_ready_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rx_crc_err_cnt_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(rx_crc_err_cnt_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(errstat_link2)$')
        toks = regexp(get_param(gw, 'Name'), '(errstat_link2)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(rx_crc_err_cnt_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(rx_crc_err_cnt_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    elseif regexp(get_param(gw, 'Name'), '(errstat_link3)$')
        toks = regexp(get_param(gw, 'Name'), '(errstat_link3)$', 'tokens');
        set_param(gw, 'Name', clear_name([myname, '_', toks{1}{1}]));
    else
        error(['Unknown gateway name: ', gw]);
    end
end

