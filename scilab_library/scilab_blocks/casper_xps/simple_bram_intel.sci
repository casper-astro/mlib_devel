function [x, y, typ] = simple_bram_intel(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'simple_bram_intel';
    block_path = getenv('MLIB_DEVEL_PATH');
    bit_width = '32';
    addr_width = '10';
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
      [ok, blkname, addr_width, bit_width, exprs] = scicos_getvalue("Set SBRAM block parameters",...
                          txt,...
                          list("str", 1, "str", 1, "str", 1),...
                          exprs);
      if ok then
        bit_width = strtod(bit_width);
        addr_width = strtod(addr_width);
        // TODO: figure out how to set string in the model
        model.in = [1, 1];
        model.in2 = [bit_width, 1];
        model.out = [];
        model.out2 = [];
        graphics.in_label = ['data_in', 'we'];
        graphics.out_label = [];
        if block_path == '' then
          warning('MLIB_DEVEL_PATH not set, icon will default to yellow rectangle');
          graphics.style = 'shape=rectangle;fillColor=yellow';
        else
          icon_path = block_path + '/scilab_library/scilab_blocks/casper_xps/figures/simple_bram_intel.png';
          disp('ICON PATH')
          disp(icon_path)
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
      model.sim = list('simple_bram_intel',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 4, 5];
      // TODO: do we have to set out2??
      model.in = [1, 1];
      model.in2 = [32, 1];
      model.out = [];
      model.out2 = [];
      // Type : column vector of strings.
      exprs = ['simple_bram_intel'; '10';'32'];
      gr_i = [];
      //set the block tag
      model.label = "xps";
      x=standard_define([8 5.5],model,exprs,gr_i)
      x.graphics.in_label = ['data_in', 'we'];
      x.graphics.out_label = [];
      x.graphics.style = 'shape=rectangle;fillColor=yellow';
      debug_info('sbram block loaded...')
  end
  endfunction
