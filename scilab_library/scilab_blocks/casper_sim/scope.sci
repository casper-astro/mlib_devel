//Create a simple custom block.
function [x, y, typ]= scope(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'scope';
  n_channels = 1;
  select job
    case 'set' then
      x=arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      txt = [ 'Block Name (any string)';...
              'Channels'; ];
      [ok, blkname, n_channels, exprs] = scicos_getvalue("Set scope block parameters",...
                        txt,...
                        list("str", 1, "str",1),...
                        exprs);
      if ok then
        graphics.exprs = exprs;
        x.graphics = graphics;
        x.model = model;
      end
    case 'define' then
      model = scicos_model();
      model.sim = list('scope',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 3];
      // TODO: do we have to set in2??
      model.in = [1];
      model.in2 = [];
      model.out = [];
      model.out2 = [];
      // Type : column vector of strings.
      exprs = ['scope'; '1'];
      gr_i = [];
      // we use model.label as the block tag.
      // the best place to set the tag should be graphics.gr_i/id.
      // However, I can't set graphics.gr_i/id...not sure why.
      // I tracked the code of standard_define until sciscicos_new().
      // Everything looks good, but gr_i/id is not set successfully.
      // scicos_new() looks implemented in c++, so I stopped tracking it.
      // TODO: track the source code of scicos_new() in c++.
      model.label = "sim";
      x=standard_define([2 2],model,exprs,gr_i)
      debug_info('scope block loaded...')
  end
endfunction


