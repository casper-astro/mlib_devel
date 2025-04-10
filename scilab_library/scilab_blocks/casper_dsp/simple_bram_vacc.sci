//Create a simple custom block.
function [x, y, typ]= simple_bram_vacc(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'simple_bram_vacc';
  vector_len = 1024;
  in_bitwidth = 16;
  out_bitwidth = 32;
  out_type = 'unsigned';
  select job
    case 'set' then
      x=arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      txt = [ 'Block Name (any string)';...
              'Vector Length';...
              'Input Bit Width';...
              'Output Bit Width';...
              'Output Type (unsigned/signed)'];
      [ok, blkname, vector_len, in_bitwidth, out_bitwidth, out_type, exprs] = scicos_getvalue("Set Simple Bram Vacc block parameters",...
                        txt,...
                        list("str", 1, "str", 1, "str", 1, "str", 1, "str", 1),...
                        exprs);
      if ok then
        // convert string to decimal
        in_port_width = strtod(in_bitwidth);
        out_port_width = strtod(out_bitwidth);
        graphics.exprs = exprs;
        graphics.style = 'shape=rectangle;fillColor=green'
        graphics.in_label = ['new_acc', 'din'];
        graphics.out_label = ['valid', 'dout'];
        model.in = [1, 2];
        model.in2 = [1, in_port_width];
        model.out = [1, 2];
        model.out2 = [1, out_port_width];
        x.model = model;
        x.graphics = graphics;
      end
    case 'define' then
      model = scicos_model();
      model.sim = list('simple_bram_vacc',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 3, 4, 5, 6];
      // TODO: do we have to set in2??
      model.in = [1, 2];
      model.in2 = [1, 16];
      model.out = [1, 2];
      model.out2 = [1, 32];
      // Type : column vector of strings.
      exprs = ['simple_bram_vacc'; '1024'; '16'; '32'; 'unsigned'];
      gr_i = [];
      // we use model.label as the block tag.
      // the best place to set the tag should be graphics.gr_i/id.
      // However, I can't set graphics.gr_i/id...not sure why.
      // I tracked the code of standard_define until sciscicos_new().
      // Everything looks good, but gr_i/id is not set successfully.
      // scicos_new() looks implemented in c++, so I stopped tracking it.
      // TODO: track the source code of scicos_new() in c++.
      model.label = "dsp";
      x=standard_define([4 4],model,exprs,gr_i)
      x.graphics.style = 'shape=rectangle;fillColor=green';
      x.graphics.in_label = ['new_acc', 'din'];
      x.graphics.out_label = ['valid', 'dout']; 
      debug_info('simple bram vacc block loaded...')
  end
endfunction


