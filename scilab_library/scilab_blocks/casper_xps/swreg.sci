  function [x, y, typ] = swreg(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'swreg';
    io_direction = 'From Processor';
    io_delay = 0;
    init_val = 0;
    sample_period = 1;
    bitfield_name = 'reg';
    bitfield_width = 1;
    bitfield_bp = 0;
    bitfield_types = 2;
    select job
    case 'set' then
      x = arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      txt = [ 'Block Name (any string)';...
              'IO direction(From Processor, To Processor)';...
              'IO delay';...
              'Initial Value'; ...
              'Sample period';...
              'Bitfield names[msb...lsb]';...
              'Bitfield widths';...
              'Bitfield binary point';...
              'Bitfield types(ufix=0, fix=1, bool=2)';...
            ];
      [ok, blkname, io_direction, io_delay, init_val, sample_period, bitfield_name, bitfield_width, bitfield_bp, bitfield_types, exprs] = scicos_getvalue("Set SWREG block parameters",...
                          txt,...
                          list("str", 1, "str", 1, "vec",1 ,"vec",1,"vec",1,"str",1,"vec",1,"vec",1,"vec",1),...
                          exprs);
      if ok then
        // TODO: figure out how to set string in the model
        if io_direction == 'From Processor' then
          model.in = 1;
          model.in2 = 1;
          model.out = 1;
          model.out2 = 1;
          graphics.out_label = ['out'];
          graphics.in_label = ['sim_in'];
          graphics.style = 'shape=rectangle;fillColor=yellow'
        elseif io_direction == 'To Processor' then
          model.in = 1;
          model.in2 = 1;
          model.out = 1;
          model.out2 = 1;
          graphics.out_label = ['sim_out'];
          graphics.in_label = ['in'];
        end
        // generate rpar
        //rpar = [io_delay, init_val, sample_period, bitfield_name_r, bitfield_width, bitfield_bp, bitfield_types];
        // update model
        // model.rpar = rpar;
        graphics.exprs = exprs;
        x.graphics = graphics;
        x.model = model;
      end
    case 'define' then
      model = scicos_model();
      // what does this sim mean??
      model.sim = list('swreg_out',4);
      model.blocktype = 'c';
      // we put the index of the related item in block_info.json into rpar
      // model.rpar =  [0, 0, 1, 0, 1, 0, 2];
      // "SWREG":{
      //   "name": "wreg",              -- 0
      //   "fullpath": "",
      //   "tag": "xps:sw_reg",
      //   "io_dir": "From Processor",  -- 3
      //   "io_delay": 0,               -- 4
      //   "init_val": 0,               -- 5
      //   "sample_period": 1,          -- 6
      //   "names": "reg",              -- 7
      //   "bitwidths": 1,              -- 8
      //   "bin_pts": 0,                -- 9
      //   "arith_types": 2,            -- 10
      //   "sim_port": "on",
      //   "show_format": "on"
      // }
      // Type : column vector of real numbers.
      model.rpar = [0, 3, 4, 5, 6, 7, 8, 9, 10];
      // TODO: do we have to set out2??
      model.out = 1;
      model.out2 = 1;
      model.in = 1;
      model.in2 = 1;
      // Type : column vector of strings.
      exprs = ['swreg'; 'From Processor';'0'; '0'; '1'; 'reg'; '1'; '0'; '2'];
      gr_i = [];
      //set the block tag
      model.label = "xps";
      x=standard_define([5 1.4],model,exprs,gr_i)
      x.graphics.out_label = ['out'];
      x.graphics.in_label = ['sim_in'];
      x.graphics.style = 'shape=rectangle;fillColor=yellow';
      debug_info('swreg block loaded...')
  end
  endfunction