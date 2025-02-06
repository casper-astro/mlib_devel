//Create a simple custom block.
function [x, y, typ]= bus_expand(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'bus_expand';
    ndivision = 4;
    bit_division = '[8,8,8,8]';
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;
        //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
        txt = [ 'Block Name (any string)';...
                'Number of Division';...
                'Bit Division';];
        [ok, blkname, ndivision, bit_division, exprs] = scicos_getvalue("Set bus expand block parameters",...
                          txt,...
                          list("str", 1, "str", 1, "str", 1),...
                          exprs);
        evtin = [];
        evtout = [];
        //[model,graphics,ok] = set_io(model, graphics, list(in,intype), list(out, outype), evtin, evtout);
        if ok then
            // convert the string to decimal
            ndivision = strtod(ndivision);
            [iports_index, iports_label] = create_iports(1);
            [oports_index, oports_label] = create_oports(ndivision);
            // it seems like we don't care about the io type here.
            io_in = [iports_index;iports_index];
            io_out = [oports_index;oports_index];
            io_in_type = ones(1, length(iports_index));
            io_out_type = ones(1, length(oports_index));
            [model,graphics,ok] = set_io(model, graphics, list(io_in', io_in_type), list(io_out', io_out_type), evtin, evtout);
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
        model.sim = list('bus_expand',4);
        model.blocktype = 'c';
        // Type : column vector of real numbers.
        model.rpar = [0, 3, 4];
        // Type : column vector of strings.
        exprs = ['bus_expand'; '4'; '[8,8,8,8]'];
        gr_i = [];
        [iports_index, iports_label] = create_iports(ndivision);
        model.in = iports_index;
        model.in2 = iports_index;
        [oports_index, oports_label] = create_oports(ndivision);
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
        debug_info('bus_expand loaded...')
    end
endfunction

//create input ports index and labels
function [ports_index, ports_label] = create_iports(n)
    // ports_label = ['in_sync', 'in_valid', 'in_shiftreg'];
    // ports_index = [1, 2, 3];
    // for i = 1:wb_factor
    //     ports_label = [ports_label, 'in_re' + string(i - 1)];
    //     ports_index = [ports_index, 2*i + 2];
    //     ports_label = [ports_label, 'in_im' + string(i - 1)];
    //     ports_index = [ports_index, 2*i + 3];
    // end
    ports_label = ['i_data'];
    ports_index = [1];
endfunction

// create output ports index and labels
function [ports_index, ports_label] = create_oports(n)
    ports_label = [];
    ports_index = [];
    for i = 1:n
        ports_label = [ports_label, 'o_data_' + string(i - 1)];
        ports_index = [ports_index, i];
    end
endfunction
  
  
  