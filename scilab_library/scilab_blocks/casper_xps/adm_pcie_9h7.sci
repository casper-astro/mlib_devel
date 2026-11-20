// adm_pcie_9h7: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- every xps_library Platforms-group board
// config block (xps_xsg_*_conf_mask.m) is a pure design-wide settings
// marker with mask parameters but no signal path at all: confirmed by
// grepping every xps_xsg_*_conf_mask.m in this session for
// reuse_block/add_block/delete_lines/clean_blocks -- zero hits across
// all 21 boards. Per casper_xps_from_simulink/SKILL.md's "zero ports"
// case: model.in/model.out are simply never set, and the 'set' job's
// update function only ever refreshes graphics, never port topology.
function [x, y, typ] = adm_pcie_9h7(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = adm_pcie_9h7_refresh(x, bconfig);
    case 'define' then
        tag = 'adm_pcie_9h7';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.label = tag;
        model.rpar = [];
        gr_i = [];
        exprs = [];
        x=standard_define([6 4.8],model,exprs,gr_i)
        // vector text drawn directly on the fill color via mxGraph's
        // displayedLabel (see Xcos-style.xml / XcosDiagram.getCellStyle)
        // instead of a fixed-pixel image -- reflows/recenters when the
        // block is resized, rather than staying a fixed bitmap size.
        x.graphics.style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;fontStyle=1;align=center;verticalAlign=middle;noLabel=0;displayedLabel=ADM-PCIE-9H7;whiteSpace=wrap;html=1;';
        x = init_exprs(x);
        debug_info('adm_pcie_9h7 block loaded...')
    end
endfunction

function [x] = adm_pcie_9h7_refresh(obj, bconfigfn)
    // zero-port block -- nothing to resize/rewire, just keep the fill
    // style consistent (mirrors every other casper_xps block's 'set' path).
    x = obj;
    graphics = x.graphics;
    graphics.style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;fontStyle=1;align=center;verticalAlign=middle;noLabel=0;displayedLabel=ADM-PCIE-9H7;whiteSpace=wrap;html=1;';
    x.graphics = graphics;
endfunction
