//Create a simple custom block.
function [x, y, typ]= sine(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'sine';
    amplitude = 2047;
    freq = 16;
    phase = 0;
    sampling_rate = 1024;
    output_bit_width = 16;
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;
        //[io_group, custom_io_group, io_dir, d_type, d_bw, d_bp, gpio_bi, sample_period] = create_gpio();
        txt = [ 'Block Name (any string)';...
                'Amplitude(2^x)';...
                'Frequency(Hz)'; ...
                'Phase';...
                'Sampling rate(Hz)';...
                'Output bit width';];
        [ok, blkname, amplitude, freq, phase, sampling_rate, output_bit_width, exprs] = scicos_getvalue("Set sine block parameters",...
                          txt,...
                          list("str", 1, "str",1 ,"str",1, "str",1, "str",1, "str",1),...
                          exprs);
        if ok then
          graphics.exprs = exprs;
          x.graphics = graphics;
          x.model = model;
        end
      case 'define' then
        model = scicos_model();
        model.sim = list('sine',4);
        model.blocktype = 'c';
        // Type : column vector of real numbers.
        model.rpar = [0, 3, 4, 5, 6, 7];
        // TODO: do we have to set in2??
        model.in = [];
        model.in2 = [];
        model.out = 1;
        model.out2 = [];
        // Type : column vector of strings.
        exprs = ['sine'; '2047'; '16'; '0'; '1024'; '16'];
        gr_i = [];
        // we use model.label as the block tag.
        // the best place to set the tag should be graphics.gr_i/id.
        // However, I can't set graphics.gr_i/id...not sure why.
        // I tracked the code of standard_define until sciscicos_new().
        // Everything looks good, but gr_i/id is not set successfully.
        // scicos_new() looks implemented in c++, so I stopped tracking it.
        // TODO: track the source code of scicos_new() in c++.
        model.label = "sim";
        x=standard_define([2 2],model,exprs,gr_i)
        debug_info('sine block loaded...')
    end
  endfunction
  
  
  