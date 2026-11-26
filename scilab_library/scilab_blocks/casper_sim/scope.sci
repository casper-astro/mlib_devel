//Create a simple custom block.
function [x, y, typ]= scope(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'scope';
  select job
    case 'set' then
      x = arg1;
      // a block saved before scope.json got its current keys may lack
      // fullpath/tag or newer parameters; template_exprs fills them in
      x.graphics.exprs = template_exprs(x);
      export_exprs_to_tmpdir(x);
      bconfig = run_mask(x);
      x = update_exprs_from_tmpdir(x);
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
      debug_info('scope block loaded...')
  end
endfunction


