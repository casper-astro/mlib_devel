function [x, y, typ] = snapshot(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'snapshot';
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
      [ok, blkname, addr_width, bit_width, exprs] = scicos_getvalue("Set snapshot block parameters",...
                          txt,...
                          list("str", 1, "str", 1, "str", 1),...
                          exprs);
      if ok then
        bit_width = strtod(bit_width);
        addr_width = strtod(addr_width);

        model.in = [1, 1, 1, 1, 1];
        model.in2 = [bit_width, 1, 1, 1, 1];
        model.out = [1, 1, 1];
        model.out2 = [bit_width, 1, 1];

        graphics.in_label = ['din', 'we', 'trig', 'arm', 'rst'];
        graphics.out_label = ['dout', 'busy', 'done'];
        graphics.style = 'shape=rectangle;fillColor=green';
        graphics.exprs = exprs;

        x.graphics = graphics;
        x.model = model;
      end

    case 'define' then
      model = scicos_model();
      model.sim = list('snapshot',4);
      model.blocktype = 'c';
      model.rpar = [0, 4, 5];
      model.in = [1, 1, 1, 1, 1];
      model.in2 = [32, 1, 1, 1, 1];
      model.out = [1, 1, 1];
      model.out2 = [32, 1, 1];

      exprs = ['snapshot'; '10'; '32'];
      gr_i = [];
      model.label = "xps";

      x = standard_define([8 5.5], model, exprs, gr_i)
      x.graphics.in_label = ['din', 'we', 'trig', 'arm', 'rst'];
      x.graphics.out_label = ['dout', 'busy', 'done'];
      x.graphics.style = 'shape=rectangle;fillColor=lightgreen';
      debug_info('snapshot block loaded...')
    end
endfunction
