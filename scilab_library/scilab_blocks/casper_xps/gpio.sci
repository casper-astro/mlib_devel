//Create a simple custom block.
function [x, y, typ]= gpio(job, arg1, arg2)
  x=[];y=[];typ=[];
  blkname = 'gpio';
  io_group = 0;
  custom_io_group = 0;
  io_dir = 0;
  d_type = 0;
  d_bw = 0;
  d_bp = 0;
  gpio_bi = 0;
  sample_period = 0;
  select job
    case 'set' then
      x=arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
      txt = [ 'Block Name (any string)';...
              'IO group(gpio, led...)';...
              'Custom I/O group'; ...
              'IO direction(in, out)';...
              'Data type(Boolean, Signed, Unsigned)';...
              'Data bitwidth';...
              'Data binary point';...
              'GPIO bit index';...
              'Sample Period';];
      [ok, blkname, io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period, exprs] = scicos_getvalue("Set GPIO block parameters",...
                        txt,...
                        list("str", 1, "str",1 ,"str",1,"str",1,"str",1,"vec",1,"vec",1,"vec",1, "vec", 1),...
                        exprs);
      if ok then
        if io_dir == 'in' then
          io_dir_r = 0;
          model.in = [];
          model.in2 = [];
          model.out = 1;
          model.out2 = 1;
        elseif io_dir == 'out' then
          io_dir_r = 1;
          model.in = 1;
          model.in2 = 1;
          model.out = [];
          model.out2 = [];
        end
        // if io_group == 'custom' then
        //   io_group_r = 0;
        // end
        // if custom_io_group == 'gpio' then
        //   custom_io_group_r = 0;
        // end
        // if d_type == 'boolean' then
        //   d_type_r = 0;
        // elseif d_type == 'ufix' then
        //   d_type_r = 1;
        // elseif d_type == 'fix' then
        //   d_type_r = 2;
        // end
        // generate rpar
        // rpar = [io_group_r, custom_io_group_r, io_dir_r, d_type_r, d_bw, d_bp, gpio_bi, sample_period];
        // update model
        // model.rpar = rpar;
        graphics.exprs = exprs;
        x.graphics = graphics;
        x.model = model;
      end
    case 'define' then
      model = scicos_model();
      model.sim = list('gpio',4);
      model.blocktype = 'c';
      // we put the index of the related item in block_info.json into rpar
      // model.rpar = [0, 0, 1, 0, 1, 0, 0, 1];
      // "GPIO": {
      //   "name": "gpio",            -- 0
      //   "fullpath": "",
      //   "tag": "xps:gpio",
      //   "io_group": "ROACH:led",
      //   "io_group_real": "gpio",   -- 4
      //   "io_group_custom": 0,      -- 5
      //   "io_dir": "out",           -- 6
      //   "arith_type": "Boolean",   -- 7
      //   "bitwidth": 1,             -- 8
      //   "bin_pt": 0,               -- 9
      //   "bit_index": 0,            -- 10
      //   "sample_period": 1,        -- 11
      //   "use_single_ended": "off",
      //   "use_ddr": "off",
      //   "reg_iob": "on",
      //   "reg_clk_phase": 0,
      //   "termination": "None",
      //   "use_iodelay": "off"
      // }
      // Type : column vector of real numbers.
      model.rpar = [0, 4, 5, 6, 7, 8, 9, 10, 11];
      // TODO: do we have to set in2??
      model.in = 1;
      model.in2 = 1;
      // Type : column vector of strings.
      exprs = ['gpio'; 'custom'; '0'; 'out'; 'boolean'; '1'; '0'; '0'; '1'];
      gr_i = [];
      // set block tag
      model.label = "xps";
      x=standard_define([4 2],model,exprs,gr_i)
      debug_info('gpio block loaded...')
  end
endfunction


