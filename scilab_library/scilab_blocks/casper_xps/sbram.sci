function [x, y, typ] = sbram(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'sbram';
    bit_widths = '32';
    addr_width = 10;
    select job
    case 'set' then
      x = arg1;
      graphics = arg1.graphics;
      exprs = graphics.exprs;
      model = arg1.model;
      txt = [ 'Block Name (any string)';...
              'Bitwidth(8, 16, 32, 64, 128)';...
              'addr_width(2^x)';...
            ];
      [ok, blkname, bit_widths, addr_width, exprs] = scicos_getvalue("Set SBRAM block parameters",...
                          txt,...
                          list("str", 1, "str", 1, "str",1 ),...
                          exprs);
      if ok then
        // TODO: figure out how to set string in the model
        model.in = [1, 2, 3];
        model.in2 = [];
        model.out = [1];
        model.out2 = [];
        graphics.in_label = ['addr', 'data_in', 'we'];
        graphics.out_label = ['data_out'];
        graphics.style = 'shape=rectangle;fillColor=yellow';
        graphics.exprs = exprs;
        x.graphics = graphics;
        x.model = model;
      end
    case 'define' then
      model = scicos_model();
      // what does this sim mean??
      model.sim = list('sbram_out',4);
      model.blocktype = 'c';
      // Type : column vector of real numbers.
      model.rpar = [0, 3, 4, 5, 6, 7, 8, 9, 10];
      // TODO: do we have to set out2??
      model.out = [1];
      model.out2 = [];
      model.in = [1, 2, 3];
      model.in2 = [];
      // Type : column vector of strings.
      exprs = ['sbram'; '32';'10'];
      gr_i = [];
      //set the block tag
      model.label = "xps";
      x=standard_define([8 5.5],model,exprs,gr_i)
      graphics.in_label = ['addr', 'data_in', 'we'];
      graphics.out_label = ['data_out'];
      x.graphics.style = 'shape=rectangle;fillColor=yellow';
      debug_info('sbram block loaded...')
  end
  endfunction