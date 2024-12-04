//Create a simple custom block.
function [x, y, typ]= edge_detect(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'edge_detect';
    edge_type = "rising";
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;
        //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
        txt = [ 'Block Name (any string)';...
                'Edge Type(rising, falling)';];
        [ok, blkname, edge_type, exprs] = scicos_getvalue("Set edge detect block parameters",...
                          txt,...
                          list("str", 1, "str",1 ),...
                          exprs);
        if ok then
            graphics.out_label = ['out'];
            graphics.in_label = ['in'];
            graphics.style = 'shape=rectangle;fillColor=grey';
            //graphics.id = '<p style=""margin-top: 0"">      my edge detect     </p>';
            graphics.exprs = exprs;
            x.graphics = graphics;
            x.model = model;
        end
      case 'define' then
        model = scicos_model();
        model.sim = list('edge_detect',4);
        model.blocktype = 'c';
        // Type : column vector of real numbers.
        model.rpar = [0, 3];
        // TODO: do we have to set in2??
        model.in = [1];
        model.in2 = [];
        model.out = [1];
        model.out2 = [];
        // Type : column vector of strings.
        exprs = ['edge_detect'; 'rising'];
        gr_i = [];
        // we use model.label as the block tag.
        // the best place to set the tag should be graphics.gr_i/id.
        // However, I can't set graphics.gr_i/id...not sure why.
        // I tracked the code of standard_define until sciscicos_new().
        // Everything looks good, but gr_i/id is not set successfully.
        // scicos_new() looks implemented in c++, so I stopped tracking it.
        // TODO: track the source code of scicos_new() in c++.
        model.label = "dsp";
        x=standard_define([5 1],model,exprs,gr_i)
        x.graphics.out_label = ['out'];
        x.graphics.in_label = ['in'];
        x.graphics.style = 'shape=rectangle;fillColor=grey';
        //x.graphics.id = '<p style=""margin-top: 0"">      my edge detect     </p>';
        debug_info('edge detect block loaded...')
    end
  endfunction
  
  
  