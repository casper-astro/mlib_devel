//Create a simple custom block.
function [x, y, typ]= wbfft(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'wbfft';
    nstream = 1;
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;
        //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
        txt = [ 'Block Name (any string)';...
                'Stream Number';];
        [ok, blkname, nstream, exprs] = scicos_getvalue("Set wbfft block parameters",...
                          txt,...
                          list("str", 1, "str",1 ),...
                          exprs);
        evtin = [];
        evtout = [];
        //[model,graphics,ok] = set_io(model, graphics, list(in,intype), list(out, outype), evtin, evtout);
        if ok then
            // convert the string to decimal
            nstream = strtod(nstream);
            [iports_index, iports_label] = wbfft_create_iports(nstream);
            [oports_index, oports_label] = wbfft_create_oports(nstream);
            io_in = [iports_index;iports_index];
            io_out = [oports_index;oports_index];
            [model,graphics,ok] = set_io(model, graphics, list(io_in', iports_index), list(io_out', oports_index), evtin, evtout);
            model.in = iports_index;
            model.in2 = iports_index;
            model.out = oports_index;
            model.out2 = oports_index;
            graphics.in_label = iports_label;
            graphics.out_label = oports_label;
            graphics.style = 'shape=rectangle;fillColor=green'
            graphics.exprs = exprs;
            x.graphics = graphics;
            x.model = model;
        end
      case 'define' then
        model = scicos_model();
        model.sim = list('wbfft',4);
        model.blocktype = 'c';
        // Type : column vector of real numbers.
        model.rpar = [0, 3];
        // Type : column vector of strings.
        exprs = ['wbfft'; '1'];
        gr_i = [];
        [iports_index, iports_label] = wbfft_create_iports(nstream);
        model.in = iports_index;
        model.in2 = iports_index;
        [oports_index, oports_label] = wbfft_create_oports(nstream);
        model.out = oports_index;
        model.out2 = oports_index;
        // we use model.label as the block tag.
        // the best place to set the tag should be graphics.gr_i/id.
        // However, I can't set graphics.gr_i/id...not sure why.
        // I tracked the code of standard_define until sciscicos_new().
        // Everything looks good, but gr_i/id is not set successfully.
        // scicos_new() looks implemented in c++, so I stopped tracking it.
        // TODO: track the source code of scicos_new() in c++.
        model.label = "dsp";
        x=standard_define([14 14],model,exprs,gr_i)
        x.graphics.in_label = iports_label;
        x.graphics.out_label = oports_label;
        x.graphics.style = 'shape=rectangle;fillColor=green';
        debug_info('wbfft loaded...')
    end
endfunction

// create input ports index and labels
function [ports_index, ports_label] = wbfft_create_iports(nstream)
    ports_label = ['in_sync', 'in_valid', 'shiftreg'];
    ports_index = [1, 2, 3];
    for i = 1:nstream
        ports_label = [ports_label, 'in_re' + string(i - 1)];
        ports_index = [ports_index, 2*i + 2];
        ports_label = [ports_label, 'in_im' + string(i - 1)];
        ports_index = [ports_index, 2*i + 3];
    end
endfunction

// create output ports index and labels
function [ports_index, ports_label] = wbfft_create_oports(nstream)
    ports_label = ['out_sync', 'out_valid', 'ovflw'];
    ports_index = [1, 2, 3];
    for i = 1:nstream
        ports_label = [ports_label, 'out_re' + string(i - 1)];
        ports_index = [ports_index, 2*i + 2];
        ports_label = [ports_label, 'out_im' + string(i - 1)];
        ports_index = [ports_index, 2*i + 3];
    end
endfunction
  
  
  