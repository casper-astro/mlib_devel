//Create a simple custom block.
function [x, y, typ]= rfdc(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'rfdc';
    sampling_rate = 0;
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;
        
        txt = [ 'Block Name (any string)';...
                'Sampling Rate(MSps)';];
        [ok, blkname, sampling_rate, exprs] = scicos_getvalue("Set RFDC block parameters",...
                          txt,...
                          list("str", 1, "str",1),...
                          exprs);
        if ok then
            model.out = [1, 2, 3, 4, 5, 6, 7, 8];
            model.out2 = [];
            model.in = [1, 2, 3, 4, 5, 6, 7, 8];
            model.in2 = [];
            graphics.out_label = ['m00_axis_tdata', 'm02_axis_tdata', 'm10_axis_tdata', 'm12_axis_tdata', 'm20_axis_tdata', 'm22_axis_tdata', 'm30_axis_tdata', 'm32_axis_tdata'];
            graphics.in_label = ['m00_axis_tdata_sim', 'm02_axis_tdata_sim', 'm10_axis_tdata_sim', 'm12_axis_tdata_sim', 'm20_axis_tdata_sim', 'm22_axis_tdata_sim', 'm30_axis_tdata_sim', 'm32_axis_tdata_sim'];
            graphics.style = 'shape=rectangle;fillColor=yellow'
            graphics.exprs = exprs;
            x.graphics = graphics;
            x.model = model;
        end
      case 'define' then
        model = scicos_model();
        model.sim = list('rfdc',4);
        model.blocktype = 'c';
        // Type : column vector of real numbers.
        model.rpar = [0, 5];
        // TODO: do we have to set in2??
        model.in = [1, 2, 3, 4, 5, 6, 7, 8];
        model.in2 = [];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8];
        model.out2 = [];
        // Type : column vector of strings.
        exprs = ['rfdc', '3932.16'];
        gr_i = [];
        // set block tag
        model.label = "xps";
        x=standard_define([14 14],model,exprs,gr_i)
        x.graphics.out_label = ['m00_axis_tdata', 'm02_axis_tdata', 'm10_axis_tdata', 'm12_axis_tdata', 'm20_axis_tdata', 'm22_axis_tdata', 'm30_axis_tdata', 'm32_axis_tdata'];
        x.graphics.in_label = ['m00_axis_tdata_sim', 'm02_axis_tdata_sim', 'm10_axis_tdata_sim', 'm12_axis_tdata_sim', 'm20_axis_tdata_sim', 'm22_axis_tdata_sim', 'm30_axis_tdata_sim', 'm32_axis_tdata_sim'];
        x.graphics.style = 'shape=rectangle;fillColor=yellow'
        debug_info('rfdc block loaded...')
    end
  endfunction
  
  
  