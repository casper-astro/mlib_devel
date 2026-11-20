//Create a simple custom block.
function [x, y, typ]= scope(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'scope';
  n_channels = 1;
  dtype = 'int16'
  select job
    case 'set' then
      x=arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      txt = [ 'Block Name (any string)';...
              'Channels'; ...
              'Dtype';];
      [ok, blkname, n_channels, dtype, exprs] = scicos_getvalue("Set scope block parameters",...
                        txt,...
                        list("str", 1, "str",1, "str", 1),...
                        exprs);
      if ok then
        graphics.exprs = exprs;
        x.graphics = graphics;
        model.in = [1];
        model.in2 = [1];
        model.out = [];
        model.out2 = [];
        x.model = model;
      end
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
      // Type : column vector of strings.
      exprs = ['scope'; '1'; 'int16' ];
      gr_i = [];
      // model.label doubles as the on-diagram display text (Scicos
      // aliases it with graphics.id); category is derived separately
      // by get_block_type.sci via file-probe, so this is free to be
      // the block's own name.
      model.label = blkname;
      x=standard_define([2.4 2.4],model,exprs,gr_i)
      debug_info('scope block loaded...')
  end
endfunction


