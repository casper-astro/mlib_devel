//Create a simple custom block.
function [x, y, typ]= scope(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'scope';
  select job
    case 'set' then
      x = arg1;
      // a block saved before scope.json got its current keys may lack
      // fullpath/tag or newer parameters; template_exprs fills them in
      x = scope_upgrade_exprs(x);
      x.graphics.exprs = template_exprs(x);
      export_exprs_to_tmpdir(x);
      bconfig = run_mask(x);
      x = update_exprs_from_tmpdir(x);
      x.graphics.style = scope_build_style(x.graphics.exprs(1));
    case 'define' then
      model = scicos_model();
      model.sim = list('scope',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 3, 4];
      // TODO: do we have to set in2??
      model.in = [1];
      model.in2 = [1];
      model.out = [];
      model.out2 = [];
      // the parameters come from scope.json, see init_exprs below
      exprs = [];
      gr_i = [];
      // model.label doubles as the on-diagram display text (Scicos
      // aliases it with graphics.id); category is derived separately
      // by get_block_type.sci via file-probe, so this is free to be
      // the block's own name.
      model.label = blkname;
      x=standard_define([2.4 2.4],model,exprs,gr_i)
      x = init_exprs(x);
      x.graphics.style = scope_build_style(x.graphics.exprs(1));
      debug_info('scope block loaded...')
  end
endfunction

function [style] = scope_build_style(name)
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

/* drop the 'channels' parameter (one signal per scope block now) from the
   exprs of a scope block saved before it was removed: [name; channels;
   dtype] in the old scicos_getvalue layout, [name; fullpath; tag;
   channels; dtype] in the template layout */
function [x] = scope_upgrade_exprs(obj)
    x = obj;
    e = x.graphics.exprs;
    if typeof(e) == 'list' then
        n = size(e);
    else
        n = size(e, '*');
    end
    if n == 3 then
        debug_info('removing channels from the exprs of scope block ' + string(e(1)));
        x.graphics.exprs = [string(e(1)); ''; 'sim:scope'; string(e(3))];
    elseif n == 5 then
        debug_info('removing channels from the exprs of scope block ' + string(e(1)));
        x.graphics.exprs = [string(e(1)); string(e(2)); string(e(3)); string(e(5))];
    end
endfunction
