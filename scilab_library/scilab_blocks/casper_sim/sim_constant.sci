//Create a simple custom block.
function [x, y, typ]= sim_constant(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'constant';
  select job
    case 'set' then
      x = arg1;
      // a block saved before sim_constant.json got its current keys may lack
      // fullpath/tag or newer parameters; template_exprs fills them in
      x.graphics.exprs = template_exprs(x);
      export_exprs_to_tmpdir(x);
      bconfig = run_mask(x);
      x = update_exprs_from_tmpdir(x);
      x.graphics.style = sim_constant_build_style(x.graphics.exprs(1));
      x = sim_constant_update_ports(x, bconfig);
    case 'define' then
      model = scicos_model();
      model.sim = list('constant',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 3, 4, 5];
      // TODO: do we have to set in2??
      model.in = [];
      model.in2 = [];
      model.out = [1];
      model.out2 = [32];
      // the parameters come from sim_constant.json, see init_exprs below
      exprs = [];
      gr_i = [];
      // model.label doubles as the on-diagram display text (Scicos
      // aliases it with graphics.id); category is derived separately
      // by get_block_type.sci via file-probe, so this is free to be
      // the block's own name.
      model.label = blkname;
      x=standard_define([2.4 2.4],model,exprs,gr_i)
      x = init_exprs(x);
      x.graphics.style = sim_constant_build_style(x.graphics.exprs(1));
      debug_info('constant block loaded...')
  end
endfunction

/* the output port width follows the bitwidth parameter */
function [x] = sim_constant_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    model = x.model;
    model.out = [1];
    model.out2 = strtod(p('bitwidth'));
    x.model = model;
endfunction

function [style] = sim_constant_build_style(name)
    // same scheme as the casper_dsp/casper_xps blocks: a flat fill color
    // (#00B0F0 for casper_sim) with the block name below it.
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    // rounded / gradientColor / strokeWidth are set explicitly: Scilab
    // 2025.1 merges this style onto Xcos-style.xml's 'block' style, which
    // has rounded=1, gradientColor=white and strokeWidth=0.5.
    style = 'shape=rectangle;rounded=0;gradientColor=none;strokeWidth=1;fillColor=#00B0F0;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction
