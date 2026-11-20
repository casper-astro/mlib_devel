// fft_wideband_real: Xcos block definition, PyQt6-mask pattern.
// Hand-written (not gen_sci_block.py) -- the real/complex port counts scale
// with TWO mask parameters jointly (n_streams AND n_inputs: n_streams*2^n_inputs
// real inputs, n_streams*2^(n_inputs-1) complex outputs), which the single
// factor_key "dynamic" generator can't express. Port layout/widths are
// confirmed against casper_library/fft_wideband_real_init.m (in<s><n> for
// s=0..n_streams-1, n=0..2^n_inputs-1; out<s><n> for s=0..n_streams-1,
// n=0..2^(n_inputs-1)-1 -- each out<s><n> is complex, split into _re/_im
// ports here per this project's "no MATLAB bus struct" convention).
//
// HDL backend: casper_dsp/rtl/FFTs/fft_wideband_real.sv. Several mask
// parameters are declared here (for parameter-list completeness/
// traceability against the original casper_library mask) but not yet
// functionally implemented by the HDL -- see fft_wideband_real_update_ports
// and mask.py's validate_config for which ones, and
// mlib_devel_notes/fft_wideband_real_hdl_plan.md for the full rationale.
function [x, y, typ] = fft_wideband_real(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = fft_wideband_real_update_ports(x, bconfig);
    case 'define' then
        tag = 'fft_wideband_real';
        model = scicos_model();
        model.sim = list(tag,4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // initial on-canvas shape, before the user ever opens the mask --
        // n_streams=1/n_inputs=2/input_bit_width=18 match the JSON
        // template's own defaults; FFTSize's own default is the -1
        // "unset" sentinel (not a valid port width), so a concrete
        // placeholder (6) is used here only for the initial shift port
        // width -- fft_wideband_real_update_ports recomputes everything
        // for real the moment the user hits OK/Apply.
        default_n_streams = 1;
        default_n_inputs = 2;
        default_FFTSize = 6;
        default_input_bit_width = 18;
        [iports_index, iports_label] = fft_wideband_real_create_iports(default_n_streams, default_n_inputs);
        model.in = iports_index;
        model.in2 = [1, default_FFTSize, default_input_bit_width*ones(1, default_n_streams*2^default_n_inputs)];
        [oports_index, oports_label] = fft_wideband_real_create_oports(default_n_streams, default_n_inputs);
        model.out = oports_index;
        model.out2 = [1, default_input_bit_width*ones(1, 2*default_n_streams*2^(default_n_inputs-1)), ...
            fft_wideband_real_of_width(default_n_streams, default_n_inputs)];
        model.label = tag;
        x=standard_define([9 10],model,exprs,gr_i)
        x.graphics.in_label = iports_label;
        x.graphics.out_label = oports_label;
        /* init exprs */
        x = init_exprs(x);
        x.graphics.style = fft_wideband_real_build_style(x.graphics.exprs(1));
        debug_info('fft_wideband_real loaded...')
    end
endfunction

// Port layout, fixed part:
//   in:  sync (1), shift (2), then in<s><n> starting at port 3
//   out: sync_out (1), then out<s><n>_re/out<s><n>_im pairs starting at
//        port 2, then of as the very last output port
//
// create input ports index and labels
function [ports_index, ports_label] = fft_wideband_real_create_iports(n_streams, n_inputs)
    ports_label = ['sync', 'shift'];
    ports_index = [1, 2];
    port = 3;
    for s = 0:n_streams-1
        for n = 0:2^n_inputs-1
            ports_label = [ports_label, 'in' + string(s) + '_' + string(n)];
            ports_index = [ports_index, port];
            port = port + 1;
        end
    end
endfunction

// create output ports index and labels
function [ports_index, ports_label] = fft_wideband_real_create_oports(n_streams, n_inputs)
    ports_label = ['sync_out'];
    ports_index = [1];
    port = 2;
    for s = 0:n_streams-1
        for n = 0:2^(n_inputs-1)-1
            ports_label = [ports_label, 'out' + string(s) + '_' + string(n) + '_re'];
            ports_index = [ports_index, port];
            port = port + 1;
            ports_label = [ports_label, 'out' + string(s) + '_' + string(n) + '_im'];
            ports_index = [ports_index, port];
            port = port + 1;
        end
    end
    ports_label = [ports_label, 'of'];
    ports_index = [ports_index, port];
endfunction

// output bit-width, for Xcos's own port width display / check_bit_width.sci
// cross-checking -- confirmed verbatim against
// casper_dsp/rtl/FFTs/fft_wideband_real.sv's own N_BITS_OUT parameter
// formula: with bitgrowth=='off' (the
// mask's own default), the dynamic shift-select datapath keeps the width
// constant at input_bit_width end to end; with bitgrowth=='on', it's a
// single min() against (input_bit_width+FFTSize), capped at max_bits.
function [w] = fft_wideband_real_out_width(input_bit_width, FFTSize, n_inputs, bitgrowth, max_bits)
    if bitgrowth == 'on' then
        w = min(max_bits, input_bit_width + FFTSize);
    else
        w = input_bit_width;
    end
endfunction

// of (overflow) port width -- confirmed verbatim against
// fft_wideband_real.sv's own OF_WIDTH parameter formula: casper's OR aligns
// its two source blocks' overflow buses at the LSB (fft_biplex_real_4x has
// n_streams*2^n_inputs/4 bits, fft_direct has n_streams bits), so of is as
// wide as the larger of the two.
function [w] = fft_wideband_real_of_width(n_streams, n_inputs)
    w = max(n_streams*2^n_inputs/4, n_streams);
endfunction

function [x]= fft_wideband_real_update_ports(arg1, bconfigfn)
    x=arg1;
    bconfig = fromJSON(bconfigfn, 'file');
    graphics = arg1.graphics;
    exprs = graphics.exprs;
    model = arg1.model;
    params = bconfig('parameters');
    n_streams = strtod(params('n_streams'));
    n_inputs = strtod(params('n_inputs'));
    FFTSize = strtod(params('FFTSize'));
    input_bit_width = strtod(params('input_bit_width'));
    bitgrowth = params('bitgrowth');
    max_bits = strtod(params('max_bits'));
    out_width = fft_wideband_real_out_width(input_bit_width, FFTSize, n_inputs, bitgrowth, max_bits);
    evtin = [];
    evtout = [];
    [iports_index, iports_label] = fft_wideband_real_create_iports(n_streams, n_inputs);
    [oports_index, oports_label] = fft_wideband_real_create_oports(n_streams, n_inputs);
    io_in = [iports_index;iports_index];
    io_out = [oports_index;oports_index];
    io_in_type = ones(1, length(iports_index));
    io_out_type = ones(1, length(oports_index));
    [model,graphics,ok] = set_io(model, graphics, list(io_in', io_in_type), list(io_out', io_out_type), evtin, evtout);
    model.in = iports_index;
    // sync width 1, shift width FFTSize (one bit per FFT stage), then
    // n_streams*2^n_inputs real input samples at input_bit_width each
    model.in2 = [1, FFTSize, input_bit_width*ones(1, n_streams*2^n_inputs)];
    model.out = oports_index;
    // sync_out width 1, then n_streams*2^(n_inputs-1) complex (re,im)
    // output pairs at out_width each, then of
    model.out2 = [1, out_width*ones(1, 2*n_streams*2^(n_inputs-1)), ...
        fft_wideband_real_of_width(n_streams, n_inputs)];
    graphics.in_label = iports_label;
    graphics.out_label = oports_label;
    graphics.style = fft_wideband_real_build_style(params('name'));
    graphics.exprs = exprs;
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, shown below the fill color (see displayedLabel). Strips ';' and
   '=' from the name since those are the mxGraph style string's own
   delimiter characters. */
function [style] = fft_wideband_real_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
