//Create a simple custom block.
function [x, y, typ]= sine(job, arg1, arg2)
    x=[];y=[];typ=[];
    blkname = 'sine';
    select job
      case 'set' then
        x = arg1;
        // a block saved before sine.json got its current keys may lack
        // fullpath/tag or newer parameters; template_exprs fills them in
        x.graphics.exprs = template_exprs(x);
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = sine_update_ports(x, bconfig);
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
        model.out2 = 16;
        // the parameters come from sine.json, see init_exprs below
        exprs = [];
        gr_i = [];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately
        // by get_block_type.sci via file-probe, so this is free to be
        // the block's own name.
        model.label = blkname;
        x=standard_define([2.4 2.4],model,exprs,gr_i)
        x = init_exprs(x);
        debug_info('sine block loaded...')
    end
  endfunction

/* the output port width follows the output_bit_width parameter */
function [x] = sine_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    model = x.model;
    model.out = 1;
    model.out2 = strtod(p('output_bit_width'));
    x.model = model;
endfunction
