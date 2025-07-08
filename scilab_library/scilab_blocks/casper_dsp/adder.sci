//Create a simple custom block.
function [x, y, typ]= adder(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'adder';
  a_bitwidth = 0;
  b_bitwidth = 0;
  c_bitwidth = 0;
  select job
    case 'set' then
      x=arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
      txt = [ 'Block Name (any string)';...
              'Input bit width(a)';...
              'Input bit width(b)'; ...
              'Output bit width(c)';];
      [ok, blkname, a_bitwidth, b_bitwidth, c_bitwidth, exprs] = scicos_getvalue("Set adder block parameters",...
                        txt,...
                        list("str", 1, "str",1 ,"str",1, "str",1),...
                        exprs);
      if ok then
        // convert string to decimal
        port_a_width = strtod(a_bitwidth);
        port_b_width = strtod(b_bitwidth);
        port_c_width = strtod(c_bitwidth);
        graphics.exprs = exprs;
        graphics.style = 'shape=rectangle;fillColor=green'
        graphics.in_label = ['in0', 'in1'];
        graphics.out_label = ['out0'];
        model.in = [1, 2];
        model.in2 = [port_a_width, port_b_width];
        model.out = 1;
        model.out2 = [port_c_width];
        x.model = model;
        x.graphics = graphics;
      end
    case 'define' then
      model = scicos_model();
      model.sim = list('adder',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 3, 4, 5];
      // TODO: do we have to set in2??
      model.in = [1, 2];
      model.in2 = [64, 64];
      model.out = 1;
      model.out2 = [64];
      // Type : column vector of strings.
      exprs = ['adder'; '64'; '64'; '64'];
      gr_i = [];
      // we use model.label as the block tag.
      // the best place to set the tag should be graphics.gr_i/id.
      // However, I can't set graphics.gr_i/id...not sure why.
      // I tracked the code of standard_define until sciscicos_new().
      // Everything looks good, but gr_i/id is not set successfully.
      // scicos_new() looks implemented in c++, so I stopped tracking it.
      // TODO: track the source code of scicos_new() in c++.
      model.label = "dsp";
      x=standard_define([4 8],model,exprs,gr_i)
      x.graphics.style = 'shape=rectangle;fillColor=green';
      x.graphics.in_label = ['in0', 'in1'];
      x.graphics.out_label = ['out0'];
      debug_info('adder block loaded...')
  end
endfunction


