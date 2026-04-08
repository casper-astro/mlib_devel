function [x, y, typ] = sbram_intel(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'sbram_intel';
    block_path = getenv('MLIB_DEVEL_PATH');
    bit_width = '32';
    addr_width = 10;
    select job
    case 'set' then
      x = arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      txt = [ 'Block Name (any string)';...
              'addr_width(2^x)';...
              'Bitwidth(8, 16, 32, 64, 128)';...
            ];
      [ok, blkname, bit_width, addr_width, exprs] = scicos_getvalue("Set SBRAM block parameters",...
                          txt,...
                          list("str", 1, "str", 1, "str",1 ),...
                          exprs);
      if ok then
        bit_width = strtod(bit_width);
        addr_width = strtod(addr_width);
        // TODO: figure out how to set string in the model
        model.in = [1, 2, 3];
        model.in2 = [bit_width, addr_width, 1];
        model.out = [1];
        model.out2 = [];
        graphics.in_label = ['addr', 'data_in', 'we'];
        graphics.out_label = ['data_out'];
        if block_path == '' then
          warning('MLIB_DEVEL_PATH not set, icon will default to yellow rectangle');
          graphics.style = 'shape=rectangle;fillColor=yellow';
        else
          icon_path = block_path + '/scilab_library/scilab_blocks/casper_xps/figures/simple_bram_intel.png';
          graphics.style = 'image=' + icon_path;
        end
        graphics.style = 'image=' + icon_path;
        graphics.exprs = exprs;
        x.graphics = graphics;
        x.model = model;
      end
    case 'define' then
      model = scicos_model();
      // what does this sim mean??
      model.sim = list('sbram_intel_out',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 4, 5];
      // TODO: do we have to set out2??
      model.in = [1, 2, 3];
      model.in2 = [10, 32, 1];
      model.out = [1];
      model.out2 = [];
      // Type : column vector of strings.
      exprs = ['sbram_intel'; '10';'32'];
      gr_i = [];
      //set the block tag
      model.label = "xps";
      x=standard_define([8 5.5],model,exprs,gr_i)
      x.graphics.in_label = ['addr', 'data_in', 'we'];
      x.graphics.out_label = ['data_out'];
      x.graphics.style = 'shape=rectangle;fillColor=yellow';
      debug_info('sbram_intel block loaded...')
  end
  endfunction