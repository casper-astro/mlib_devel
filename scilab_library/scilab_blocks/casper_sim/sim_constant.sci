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
        const_bitwidth = strtod(const_bitwidth);
        model.in = [];
        model.in2 = [];
        model.out = [1];
        model.out2 = [const_bitwidth];
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
      model.out = [1];
      model.out2 = [32];
      // Type : column vector of strings.
      exprs = ['constant'; '0'; '32'; '0'];
      gr_i = [];
      // model.label doubles as the on-diagram display text (Scicos
      // aliases it with graphics.id); category is derived separately
      // by get_block_type.sci via file-probe, so this is free to be
      // the block's own name.
      model.label = blkname;
      x=standard_define([2.4 2.4],model,exprs,gr_i)
      debug_info('constant block loaded...')
  end
endfunction


