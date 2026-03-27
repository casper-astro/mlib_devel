//Create a simple custom block.
function [x, y, typ]= ltc2308(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'ltc2308';
    channel = '0';
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;
        
        txt = [ 'Block Name (any string)';...
                'Channel (0 to 7)';];
        [ok, blkname, channel, exprs] = scicos_getvalue("Set LTC2308 block parameters",...
                          txt,...
                          list("str", 1, "str",1),...
                          exprs);
        if ok then
            model.out = [1];
            model.out2 = [128];
            model.in = [1];
            model.in2 = [128];
            graphics.out_label = ['ch_tdata'];
            graphics.in_label = ['ch_tdata_sim'];
            graphics.style = 'shape=rectangle;fillColor=yellow'
            graphics.exprs = exprs;
            x.graphics = graphics;
            x.model = model;
        end
      case 'define' then
        model = scicos_model();
        model.sim = list('ltc2308',4);
        model.blocktype = 'c';
        // Type : column vector of real numbers.
        model.rpar = [0, 4];
        // TODO: do we have to set in2??
        model.in = [1];
        model.in2 = [128];
        model.out = [1];
        model.out2 = [128];
        // Type : column vector of strings.
        exprs = ['ltc2308', '0'];
        gr_i = [];
        // set block tag
        model.label = "pd";
        x=standard_define([14 14],model,exprs,gr_i)
        x.graphics.out_label = ['ch_tdata'];
        x.graphics.in_label = ['ch_tdata_sim'];
        x.graphics.style = 'shape=rectangle;fillColor=yellow'
        debug_info('ltc2308 block loaded...')
    end
  endfunction
  
  
  