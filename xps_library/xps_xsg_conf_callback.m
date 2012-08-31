myname=gcb;

[hw_sys, hw_subsys] = xps_get_hw_plat(get_param(myname,'hw_sys'));
myclksrc = get_param(gcb, [hw_sys, '_clk_src']);

switch hw_sys
    case 'ROACH'
        switch myclksrc
            case 'sys_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','on','off','on','on','on'});
                set_param(myname, 'clk_rate', '100');
                set_param(myname, 'MaskEnables', {'on','on','on','on','off','on','on'});
            % end case 'sys_clk'
            case 'sys_clk2x'
                set_param(myname, 'MaskVisibilities', {'on','off','on','off','on','on','on'});
                set_param(myname, 'clk_rate', '200');
                set_param(myname, 'MaskEnables', {'on','on','on','on','off','on','on'});
            % end case 'sys_clk'
            case 'aux_clk_0'
                set_param(myname, 'MaskVisibilities', {'on','off','on','off','on','on','on'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on'});
            % end case 'aux_clk_0'
            case 'aux_clk_1'
                set_param(myname, 'MaskVisibilities', {'on','off','on','off','on','on','on'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on'});
            % end case 'aux_clk_1'
            case 'arb_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','on','off','on','on','on'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on'});
            % end case 'arb_clk'
            otherwise
                set_param(myname, 'MaskVisibilities', {'on','off','on','off','on','on','on'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'ROACH'
    case 'ROACH2'
        switch myclksrc
            case 'sys_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','on','on','on','on'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on'});
            % end case 'sys_clk'
            case 'aux_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','on','on','on','on'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on'});
            % end case 'aux_clk'
            otherwise
                set_param(myname, 'MaskVisibilities', {'on','off','off','on','on','on','on'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'ROACH2'
end % switch get_param(myname,'hw_sys')
