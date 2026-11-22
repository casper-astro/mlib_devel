// one_gbe: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- port list confirmed against the real
// xps_library/xps_models/IO/one_gbe.slx standalone model's own top-level
// Inport/Outport blocks (names + the block's own "Ports" attribute, which
// matches this count exactly), NOT a best-effort guess.
function [x, y, typ] = one_gbe(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = one_gbe_update_ports(x, bconfig);
    case 'define' then
        tag = 'one_gbe';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2, 3, 4, 5, 6, 7, 8];
        model.in2 = [1, 1, 8, 1, 32, 16, 1, 1];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
        model.out2 = [1, 1, 8, 1, 32, 16, 1, 1, 1, 8, 1];
        model.label = tag;
        x=standard_define([15.6 31.2],model,exprs,gr_i)
        x.graphics.in_label = ['tx_rst', 'rx_rst', 'tx_data', 'tx_val', 'tx_destip', 'tx_destport', 'tx_eof', 'rx_ack'];
        x.graphics.out_label = ['tx_afull', 'tx_overrun', 'rx_data', 'rx_val', 'rx_srcip', 'rx_srcport', 'rx_eof', 'rx_badframe', 'rx_overrun', 'dbg_data', 'dbg_data_val'];
        x = init_exprs(x);
        x.graphics.style = one_gbe_build_style(x.graphics.exprs(1));
        debug_info('one_gbe block loaded...')
    end
endfunction

function [style] = one_gbe_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction


function [x] = one_gbe_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1, 2, 3, 4, 5, 6, 7, 8];
    model.in2 = [1, 1, 8, 1, 32, 16, 1, 1];
    model.out = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    model.out2 = [1, 1, 8, 1, 32, 16, 1, 1, 1, 8, 1];
    graphics.in_label = ['tx_rst', 'rx_rst', 'tx_data', 'tx_val', 'tx_destip', 'tx_destport', 'tx_eof', 'rx_ack'];
    graphics.out_label = ['tx_afull', 'tx_overrun', 'rx_data', 'rx_val', 'rx_srcip', 'rx_srcport', 'rx_eof', 'rx_badframe', 'rx_overrun', 'dbg_data', 'dbg_data_val'];
    graphics.style = one_gbe_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
