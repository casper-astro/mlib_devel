//Create a simple custom block.
function [x, y, typ]= counter(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'counter';
    bit_width = 1024;
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;
        //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
        txt = [ 'Block Name (any string)';...
                'Bit Width';];
        [ok, blkname, bit_width, exprs] = scicos_getvalue("Set counter block parameters",...
                          txt,...
                          list("str", 1, "str",1 ),...
                          exprs);
        if ok then
            graphics.in_label = ['rst', 'en'];
            graphics.out_label = ['out'];
            bit_width = strtod(bit_width);
            graphics.style = 'shape=rectangle;fillColor=grey';
            //graphics.id = '<p style=""margin-top: 0"">      my edge detect     </p>';
            graphics.exprs = exprs;
            x.graphics = graphics;
            model.in = [1 2];
            model.in2 = [1, 1];
            model.out = [1];
            model.out2 = [bit_width];
            x.model = model;
        end
      case 'define' then
        model = scicos_model();
        model.sim = list('counter',4);
        model.blocktype = 'c';
        // Type : column vector of real numbers.
        model.rpar = [0, 3];
        // TODO: do we have to set in2??
        model.in = [1 2];
        model.in2 = [1, 1];
        model.out = [1];
        model.out2 = [1024];
        // Type : column vector of strings.
        exprs = ['counter'; '10'];
        gr_i = [];
        // we use model.label as the block tag.
        // the best place to set the tag should be graphics.gr_i/id.
        // However, I can't set graphics.gr_i/id...not sure why.
        // I tracked the code of standard_define until sciscicos_new().
        // Everything looks good, but gr_i/id is not set successfully.
        // scicos_new() looks implemented in c++, so I stopped tracking it.
        // TODO: track the source code of scicos_new() in c++.
        model.label = "dsp";
        x=standard_define([5 5],model,exprs,gr_i)
        x.graphics.out_label = ['out'];
        x.graphics.in_label = ['rst', 'en'];
        x.graphics.style = 'shape=rectangle;fillColor=grey';
        //x.graphics.id = '<p style=""margin-top: 0"">      my edge detect     </p>';
        debug_info('counter loaded...')
    end
  endfunction
  
  
  