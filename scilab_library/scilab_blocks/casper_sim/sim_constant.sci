//Create a simple custom block.
function [x, y, typ]= sim_constant(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'constant';
  constant_val = 0;
  const_bitwidth = 0;
  const_bin_pt = 0;
  select job
    case 'set' then
      x=arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
      txt = [ 'Block Name (any string)';...
              'Constant value';...
              'Number of bits'; ...
              'Binary point';];
      [ok, blkname, constant_val, const_bitwidth, const_bin_pt, exprs] = scicos_getvalue("Set constant block parameters",...
                        txt,...
                        list("str", 1, "str",1 ,"str",1, "str",1),...
                        exprs);
      if ok then
        model.in = [];
        model.in2 = [];
        model.out = 1;
        model.out2 = 4;
        graphics.exprs = exprs;
        x.graphics = graphics;
        x.model = model;
      end
    case 'define' then
      model = scicos_model();
      model.sim = list('constant',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 3, 4, 5];
      // TODO: do we have to set in2??
      model.in = [];
      model.in2 = [];
      model.out = 1;
      model.out2 = 4;
      // Type : column vector of strings.
      exprs = ['constant'; '0'; '32'; '0'];
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
      debug_info('constant block loaded...')
  end
endfunction


