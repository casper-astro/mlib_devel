xsgblk=gcb;
set_param(gcb, 'LinkStatus', 'inactive');
[hw_sys, hw_subsys] = xps_get_hw_plat(get_param(xsgblk,'hw_sys'));
%myclksrc = get_param(gcb, [hw_sys, '_clk_src']);
myclksrc = get_param(gcb, 'clk_src');

switch hw_sys
    case 'ROACH'
        maskobj = get_param(gcb, 'MaskObject');
        params = maskobj.Parameters(2);
        params.TypeOptions = {'sys_clk', 'sys_clk2x', 'arb_clk', 'aux0_clk', 'aux0_clk2x', 'aux1_clk', 'aux1_clk2x', 'adc0_clk', 'adc1_clk', 'dac0_clk', 'dac1_clk'};
        switch myclksrc
            case 'sys_clk'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'clk_rate', '100');
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'sys_clk'
            case 'sys_clk2x'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'clk_rate', '200');
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'sys_clk'
            case 'aux_clk_0'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'aux_clk_0'
            case 'aux_clk_1'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'aux_clk_1'
            case 'arb_clk'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'arb_clk'
            otherwise
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'ROACH'
    case 'ROACH2'
        maskobj = get_param(gcb, 'MaskObject');
        params = maskobj.Parameters(2);
        params.TypeOptions = {'sys_clk', 'sys_clk2x', 'arb_clk', 'aux0_clk', 'aux0_clk2x', 'aux1_clk', 'aux1_clk2x', 'adc0_clk', 'adc1_clk', 'dac0_clk', 'dac1_clk'};
        switch myclksrc
            case 'sys_clk'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'sys_clk'
            case 'aux_clk'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'aux_clk'
            otherwise
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'ROACH2'
    case 'SNAP'
        maskobj = get_param(gcb, 'MaskObject');
        params = maskobj.Parameters(2);
        params.TypeOptions = {'sys_clk', 'sys_clk2x', 'arb_clk', 'aux0_clk', 'aux0_clk2x', 'aux1_clk', 'aux1_clk2x', 'adc0_clk', 'adc1_clk', 'dac0_clk', 'dac1_clk'};
        switch myclksrc
            case 'sys_clk'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'sys_clk'
            otherwise
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','off'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','off'});
            % end otherwise
        end % switch myclksrc
    % end case 'SNAP'
    case 'KC705'
        maskobj = get_param(gcb, 'MaskObject');
        params = maskobj.Parameters(2);
        params.TypeOptions = {'sys_clk', 'sys_clk2x', 'arb_clk', 'aux0_clk', 'aux0_clk2x', 'aux1_clk', 'aux1_clk2x', 'adc0_clk', 'adc1_clk', 'dac0_clk', 'dac1_clk'};
        switch myclksrc
            case 'sys_clk'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'sys_clk'
            otherwise
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'KC705'
    case 'SKARAB'
        maskobj = get_param(gcb, 'MaskObject');
        params = maskobj.Parameters(2);
        params.TypeOptions = {'sys_clk', 'aux_clk'};
        switch myclksrc
            case 'sys_clk'
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end case 'sys_clk'
            otherwise
                set_param(xsgblk, 'MaskVisibilities', {'on','on','on','on','on'});
                set_param(xsgblk, 'MaskEnables', {'on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'SNAP'
end % switch get_param(xsgblk,'hw_sys')
