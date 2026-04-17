//Create a simple custom block.
function [x, y, typ]= ltc2308(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'ltc2308';
    channel = '0';
    fft_length = '1024';
    out_width = '16';
    select job
      case 'set' then
        x=arg1;
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;

        txt = [ 'Block Name (any string)';...
                'Channel (0 to 7)';...
                'FFT frame length';...
                'Output width';];
        [ok, blkname, channel, fft_length, out_width, exprs] = scicos_getvalue("Set LTC2308 block parameters",...
                          txt,...
                          list("str", 1, "str", 1, "str", 1, "str", 1),...
                          exprs);
        if ok then
            model.in = [1, 2];
            model.in2 = [1, 1];
            model.out = [1, 2, 3];
            model.out2 = [evstr(out_width), 1, 8];
            // rpar stores expr-to-config-key index mapping, not parameter values.
            // keys = [name, fullpath, tag, sample_rate, channel, fft_length, out_width]
            // exprs = [name, channel, fft_length, out_width]
            model.rpar = [0, 4, 5, 6];
            graphics.out_label = ['sample_data'; 'sample_valid'; 'sample_sync'];
            graphics.in_label = ['enable'; 'rst_n'];
            graphics.style = 'shape=rectangle;fillColor=yellow';
            graphics.exprs = exprs;
            x.graphics = graphics;
            x.model = model;
        end
      case 'define' then
        model = scicos_model();
        model.sim = list('ltc2308',4);
        model.blocktype = 'c';
        // rpar maps expr fields into JSON parameter keys.
        model.rpar = [0, 4, 5, 6];
        model.in = [1, 2];
        model.in2 = [1, 1];
        model.out = [1, 2, 3];
        model.out2 = [16, 1, 8];
        // Type : column vector of strings.
        exprs = ['ltc2308', '0', '1024', '16'];
        gr_i = ["xstringb(orig(1),orig(2),''LTC2308'',sz(1),sz(2),''fill'');"];
        // set block tag
        model.label = "xps";
        x=standard_define([14 14],model,exprs,gr_i)
        x.graphics.out_label = ['sample_data'; 'sample_valid'; 'sample_sync'];
        x.graphics.in_label = ['enable'; 'rst_n'];
        x.graphics.style = 'shape=rectangle;fillColor=yellow';
        debug_info('ltc2308 block loaded...')
    end
  endfunction

