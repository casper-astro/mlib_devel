//Create a simple custom block.
function [x, y, typ]= sim(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'sim';
    sim_length = 0;
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        // exprs follows sim.json's keys: name, fullpath, tag, then the
        // parameters (see export_exprs); the dialog edits all but fullpath and tag
        exprs = template_exprs(x);
        idx = [1, 4:size(exprs, '*')];
        model = arg1.model;
        //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
        txt = [ 'Block Name (any string)';...
                'Simulation Length'];
        [ok, blkname, sim_length, edited] = scicos_getvalue("Set constant block parameters",...
                          txt,...
                          list("str", 1, "str",1 ),...
                          exprs(idx));
        if ok then
          exprs(idx) = edited;
          graphics.exprs = exprs;
          x.graphics = graphics;
          x.model = model;
        end
      case 'define' then
        model = scicos_model();
        model.sim = list('constant',4);
        model.blocktype = 'c';
        // Type : column vector of real numbers.
        model.rpar = [0, 3];
        // TODO: do we have to set in2??
        model.in = [];
        model.in2 = [];
        model.out = [];
        model.out2 = [];
        // the parameters come from sim.json, see init_exprs below
        exprs = [];
        gr_i = [];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately
        // by get_block_type.sci via file-probe, so this is free to be
        // the block's own name.
        model.label = blkname;
        x=standard_define([2.4 2.4],model,exprs,gr_i)
        x = init_exprs(x);
        debug_info('sim block loaded...')
    end
  endfunction
  
  
  