//Create a simple custom block.
function [x, y, typ]= logic_not(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'logic_not';
  delay_val = 0;
  select job
    case 'set' then
      x=arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      txt = [ 'Block Name (any string)';...
              'Delay(>0)'];
      [ok, blkname, delay_val, exprs] = scicos_getvalue("Set logic_not block parameters",...
                        txt,...
                        list("str", 1, "str", 1),...
                        exprs);
      if ok then
        // convert string to decimal
        in_port_width = 1;
        out_port_width = 1;
        graphics.exprs = exprs;
        graphics.style = 'shape=rectangle;fillColor=green'
        graphics.in_label = ['in'];
        graphics.out_label = ['out'];
        model.in = [1];
        model.in2 = [in_port_width];
        model.out = [1];
        model.out2 = [out_port_width];
        x.model = model;
        x.graphics = graphics;
      end
    case 'define' then
      model = scicos_model();
      model.sim = list('logic_not',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 3];
      model.in = [1];
      model.in2 = [1];
      model.out = [1];
      model.out2 = [1];
      // Type : column vector of strings.
      exprs = ['logic_not'; '1'];
      gr_i = [];
      // we use model.label as the block tag.
      // the best place to set the tag should be graphics.gr_i/id.
      // However, I can't set graphics.gr_i/id...not sure why.
      // I tracked the code of standard_define until sciscicos_new().
      // Everything looks good, but gr_i/id is not set successfully.
      // scicos_new() looks implemented in c++, so I stopped tracking it.
      // TODO: track the source code of scicos_new() in c++.
      model.label = "dsp";
      x=standard_define([4 1],model,exprs,gr_i)
      x.graphics.style = 'shape=rectangle;fillColor=green';
      x.graphics.in_label = ['in'];
      x.graphics.out_label = ['out'];
      debug_info('logic_not block loaded...')
  end
endfunction


