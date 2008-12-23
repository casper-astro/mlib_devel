myname=gcb;
myclksrc = get_param(gcb, [get_param(gcb, 'hw_sys'), '_clk_src']);

switch get_param(myname,'hw_sys')
    case 'iBOB'
        switch myclksrc
            case 'sys_clk'
                set_param(myname, 'MaskVisibilities', {'on','on','off','on','off','off','off','off','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '100');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk'
            case 'sys_clk2x'
            	set_param(myname, 'MaskVisibilities', {'on','on','off','on','off','off','off','off','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '200');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk2x'
            case 'usr_clk'
                set_param(myname, 'MaskVisibilities', {'on','on','off','on','off','off','off','off','on','on','on','on','on','off'});
            	set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'usr_clk'
            case 'usr_clk2x'
                set_param(myname, 'MaskVisibilities', {'on','on','off','on','off','off','off','off','on','on','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'usr_clk2x'
            otherwise
                set_param(myname, 'MaskVisibilities', {'on','on','off','on','off','off','off','off','off','off','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'iBOB'
    case 'BEE2_ctrl'
        switch myclksrc
            case 'sys_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','on','off','off','off','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '100');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk'
            case 'sys_clk2x'
            	set_param(myname, 'MaskVisibilities', {'on','off','off','off','on','off','off','off','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '200');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk2x'
            case 'usr_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','on','off','off','off','off','off','on','on','on','off'});
            	set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'usr_clk'
            case 'usr_clk2x'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','on','off','off','off','off','off','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'usr_clk2x'
            otherwise
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','on','off','off','off','off','off','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'BEE2_ctrl'
    case 'BEE2_usr'
        switch myclksrc
            case 'sys_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','on','off','off','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '100');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk'
            case 'sys_clk2x'
            	set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','on','off','off','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '200');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk2x'
            case 'usr_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','on','off','off','off','off','on','on','on','off'});
            	set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'usr_clk'
            case 'usr_clk2x'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','on','off','off','off','off','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'usr_clk2x'
            otherwise
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','on','off','off','off','off','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'BEE2_usr'
    case 'ROACH'
        switch myclksrc
            case 'sys_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','on','off','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '100');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk'
            case 'aux_clk_0'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','on','off','off','off','on','on','on','off'});
            	set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'aux_clk_0'
            case 'aux_clk_1'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','on','off','off','off','on','on','on','off'});
            	set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'aux_clk_1'
            otherwise
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','on','off','off','off','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'ROACH'
    case 'CORR'
        switch myclksrc
            case 'sys_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','off','on','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '100');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk'
            case 'sys_clk2x'
            	set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','off','on','off','off','on','on','on','off'});
                set_param(myname, 'clk_rate', '200');
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','off','on','on','on'});
            % end case 'sys_clk2x'
            case 'usr_clk'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','off','on','off','off','on','on','on','off'});
            	set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'usr_clk'
            case 'usr_clk2x'
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','off','on','off','off','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end case 'usr_clk2x'
            otherwise
                set_param(myname, 'MaskVisibilities', {'on','off','off','off','off','off','off','on','off','off','on','on','on','off'});
                set_param(myname, 'MaskEnables', {'on','on','on','on','on','on','on','on','on','on','on','on','on','on'});
            % end otherwise
        end % switch myclksrc
    % end case 'CORR'
end % switch get_param(myname,'hw_sys')
