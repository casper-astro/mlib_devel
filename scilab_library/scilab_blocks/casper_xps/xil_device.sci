// xil_device: Xinlinx AXI4 IP-core marker block, PyQt6-mask pattern,
// hand-written (not gen_sci_block.py). Per xps_library's own description
// ("used by casper toolflow developers, not normal users") and confirmed
// by inspecting xps_library.slx's internal system XML directly: this
// SubSystem has no "Ports" property at all (unlike every other Memory-group
// block, which all show a real [in, out] Ports vector) -- i.e. it is a
// pure design-wide marker with mask parameters (BaseAddress/MemorySize/Type)
// but no signal path, the same "zero ports" shape as every Platforms-group
// block (see rfsoc4x2.sci).
function [x, y, typ] = xil_device(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = xil_device_refresh(x, bconfig);
    case 'define' then
        tag = 'xil_device';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.label = tag;
        model.rpar = [];
        gr_i = [];
        exprs = [];
        x=standard_define([7.2 6],model,exprs,gr_i)
        x = init_exprs(x);
        x.graphics.style = xil_device_build_style(x.graphics.exprs(1));
        debug_info('xil_device block loaded...')
    end
endfunction

function [style] = xil_device_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    // rounded / gradientColor / strokeWidth are set explicitly: Scilab
    // 2025.1 merges this style onto Xcos-style.xml's 'block' style, which
    // has rounded=1, gradientColor=white and strokeWidth=0.5.
    style = 'shape=rectangle;rounded=0;gradientColor=none;strokeWidth=1;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction


function [x] = xil_device_refresh(obj, bconfigfn)
    // zero-port block -- nothing to resize/rewire, just keep the fill
    // style consistent (mirrors every other casper_xps block's 'set' path).
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    graphics.style = xil_device_build_style(p('name'));
    x.graphics = graphics;
endfunction
