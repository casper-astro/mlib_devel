// rfdc: Xcos block definition, hand-written "anything else" port topology
// (per casper_xps_from_simulink/SKILL.md -- neither generator script in
// that skill can express ports gated by independent per-tile/per-slice
// enable flags plus per-slice mixer-mode branching).
//
// Port list replicates the REAL xps_library/rfdc_mask.m algorithm (its
// function rfdc_mask + helper add_gw), not a best-effort guess:
//   - 8 tiles total: 224-227 are ADC, 228-231 are DAC, each independently
//     enabled via Tile{N}_enable.
//   - Each tile is wired in one of two real hardware architectures --
//     Dual-Tile (DT, 2 slices) or Quad-Tile (QT, 4 slices). In real
//     Simulink this is auto-detected from a sibling System Generator
//     block's FPGA part string (get_rfsoc_properties.m); Xcos has no
//     equivalent, and the ported mask has no such selector parameter --
//     instead this function infers a tile's architecture from which
//     enable checkboxes the user actually turned on for that tile (DT
//     preferred on a genuine tie, since that reproduces this file's
//     previous/original default behavior exactly -- see rfdc_update_ports
//     below).
//   - Port name template is 'm%d%d_axis_tdata' for ADC / 's%d%d_axis_tdata'
//     for DAC, first digit = tile index within its group (tile-224 or
//     tile-228), second digit = a slice-derived port index whose meaning
//     depends on architecture and (for DT) digital_output/analog_output
//     and mixer_mode -- see rfdc_add_port's callers below for the exact
//     per-case indexing, taken directly from rfdc_mask.m.
//   - Port DIRECTION is asymmetric by design (from add_gw): an ADC port
//     pair is an OUTPUT (real sample data to the fabric) plus an INPUT
//     '..._sim' (simulation stimulus); a DAC port pair is an INPUT (real
//     sample data from the fabric) plus an OUTPUT '..._sim' (simulation
//     readback).
//   - Port width is 16 (adcbits, a constant in the real mask) times that
//     slice's own 'sample_per_cycle' parameter.
//
// Known judgment call: for QUAD-tile architecture, the real mask gates
// port creation on mixer_type ~= 'Off'. This port's mixer_type comboboxes
// only ever expose 'Bypassed'/'Fine'/'Coarse' (confirmed against
// block_guis/casper_xps/rfdc/rfdc_ui.py -- there is no literal 'Off' option anywhere
// in this GUI), so in practice every enabled QT slice always produces a
// port. The 'Off' string comparison is kept anyway for exact fidelity to
// the source algorithm in case that ever changes.
function [x, y, typ]= rfdc(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
      case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = rfdc_update_ports(x, bconfig);
      case 'define' then
        /* the block init code is here */
        tag = 'rfdc';
        /* create model data structure */
        /* 1. fixed part */
        model = scicos_model();
        model.sim = list(tag,4);
        model.blocktype = 'c';
        // model.label doubles as the on-diagram display text (Scicos aliases
        // it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        model.rpar = [];
        /* 2. port definiation -- matches what rfdc_update_ports computes
           from rfdc.json's own default values (the xps_library rfdc
           defaults: Tile224-227 and Tile228-231 'on', only DT slice 0
           of each tile 'on', Real data, 8 samples per cycle): 4 ADC
           ports followed by 4 DAC ports, named/ordered exactly as below. */
        model.in = [1, 2, 3, 4, 5, 6, 7, 8];
        model.in2 = [128, 128, 128, 128, 128, 128, 128, 128];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8];
        model.out2 = [128, 128, 128, 128, 128, 128, 128, 128];
        /* create the block data structure */
        gr_i = [];
        exprs = [];
        x=standard_define([16.8 16.8],model,exprs,gr_i)
        x.graphics.out_label = ['m00_axis_tdata', 'm10_axis_tdata', ...
                                'm20_axis_tdata', 'm30_axis_tdata', ...
                                's00_axis_tdata_sim', 's10_axis_tdata_sim', ...
                                's20_axis_tdata_sim', 's30_axis_tdata_sim'];
        x.graphics.in_label = [ 'm00_axis_tdata_sim', 'm10_axis_tdata_sim', ...
                                'm20_axis_tdata_sim', 'm30_axis_tdata_sim', ...
                                's00_axis_tdata', 's10_axis_tdata', ...
                                's20_axis_tdata', 's30_axis_tdata'];
        /* init exprs */
        x = init_exprs(x);
        x.graphics.style = rfdc_build_style(x.graphics.exprs(1));
        debug_info('rfdc block loaded...')
    end
  endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = rfdc_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

// Helper: append one port PAIR (a real signal port + its matching
// simulation-side port, see file header) to the accumulator arrays and
// return them. is_adc=%t builds an ADC-style pair (data OUT + sim IN);
// is_adc=%f builds a DAC-style pair (data IN + sim OUT).
function [in,in2,out,out2,in_label,out_label,nport] = rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,prefix,tileidx,portidx,width,is_adc)
    name = sprintf('%s%d%d_axis_tdata', prefix, tileidx, portidx);
    nport = nport + 1;
    if is_adc then
        in_label = [in_label, name + '_sim'];
        out_label = [out_label, name];
    else
        in_label = [in_label, name];
        out_label = [out_label, name + '_sim'];
    end
    in = [in, nport];
    in2 = [in2, width];
    out = [out, nport];
    out2 = [out2, width];
endfunction

/* define the port update function */
function [x] = rfdc_update_ports(obj, bconfigfn)
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    adcbits = 16;

    in_label = []; out_label = [];
    in = []; in2 = []; out = []; out2 = [];
    nport = 0;

    ADC_TILES = [224 225 226 227];
    DAC_TILES = [228 229 230 231];

    // ---------------------------------------------------------------
    // ADC tiles
    // ---------------------------------------------------------------
    for ti = 1:4
        tile = ADC_TILES(ti);
        tileidx = tile - 224;
        if p(sprintf('Tile%d_enable', tile)) == 'on' then
            // infer architecture: DT if any DT slice is enabled, else QT
            // if any QT slice is enabled, else this tile contributes no
            // ports (mirrors rfdc_mask.m's "at least one slice must be
            // enabled" validation, but skips instead of erroring -- a
            // Scicos block definition shouldn't hard-fail for a
            // still-being-configured block).
            dt_any = %f;
            for a = 0:1
                if p(sprintf('t%d_DT_adc%d_enable', tile, a)) == 'on' then
                    dt_any = %t;
                end
            end
            qt_any = %f;
            for a = 0:3
                if p(sprintf('t%d_QT_adc%d_enable', tile, a)) == 'on' then
                    qt_any = %t;
                end
            end

            if dt_any then
                // Dual-Tile: 2 slices, indexing/port-count depends on
                // digital_output (Real/I-Q) and, for I-Q, mixer_mode.
                for a = 0:1
                    if p(sprintf('t%d_DT_adc%d_enable', tile, a)) == 'on' then
                        spc = strtod(p(sprintf('t%d_DT_adc%d_sample_per_cycle', tile, a)));
                        width = adcbits * spc;
                        digiout = p(sprintf('t%d_DT_adc%d_digital_output', tile, a));
                        if digiout == 'Real' then
                            [in,in2,out,out2,in_label,out_label,nport] = ..
                                rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,'m',tileidx,2*a,width,%t);
                        elseif digiout == 'I/Q' then
                            mixmode = p(sprintf('t%d_DT_adc%d_mixer_mode', tile, a));
                            if mixmode == 'Real -> I/Q' then
                                [in,in2,out,out2,in_label,out_label,nport] = ..
                                    rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,'m',tileidx,2*a,width,%t);
                                [in,in2,out,out2,in_label,out_label,nport] = ..
                                    rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,'m',tileidx,2*a+1,width,%t);
                            elseif mixmode == 'I/Q -> I/Q' then
                                [in,in2,out,out2,in_label,out_label,nport] = ..
                                    rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,'m',tileidx,a,width,%t);
                            else
                                // odd slice (a==1) paired with an even
                                // slice (a==0) already set to 'I/Q -> I/Q'
                                // -> no port for this one, it's covered by
                                // the even slice's single port above.
                                // Anything else is an inconsistent/
                                // in-progress config -- skip, don't crash.
                                if a == 1 then
                                    prevmode = p(sprintf('t%d_DT_adc0_mixer_mode', tile));
                                    if prevmode <> 'I/Q -> I/Q' then
                                        debug_info(sprintf('rfdc: Tile%d DT adc1 mixer_mode(%s) inconsistent with adc0 -- no port created', tile, mixmode));
                                    end
                                else
                                    debug_info(sprintf('rfdc: Tile%d DT adc0 unexpected mixer_mode(%s) -- no port created', tile, mixmode));
                                end
                            end
                        end
                    end
                end
            elseif qt_any then
                // Quad-Tile: 4 slices, port created whenever the slice is
                // enabled and its mixer_type isn't 'Off' (see file header
                // comment -- in practice always true for this GUI).
                for a = 0:3
                    if p(sprintf('t%d_QT_adc%d_enable', tile, a)) == 'on' then
                        mixtype = p(sprintf('t%d_QT_adc%d_mixer_type', tile, a));
                        if mixtype <> 'Off' then
                            spc = strtod(p(sprintf('t%d_QT_adc%d_sample_per_cycle', tile, a)));
                            width = adcbits * spc;
                            [in,in2,out,out2,in_label,out_label,nport] = ..
                                rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,'m',tileidx,a,width,%t);
                        end
                    end
                end
            end
        end
    end

    // ---------------------------------------------------------------
    // DAC tiles
    // ---------------------------------------------------------------
    for ti = 1:4
        tile = DAC_TILES(ti);
        tileidx = tile - 228;
        if p(sprintf('Tile%d_enable', tile)) == 'on' then
            dt_any = %f;
            for a = 0:1
                if p(sprintf('t%d_DT_dac%d_enable', tile, a)) == 'on' then
                    dt_any = %t;
                end
            end
            qt_any = %f;
            for a = 0:3
                if p(sprintf('t%d_QT_dac%d_enable', tile, a)) == 'on' then
                    qt_any = %t;
                end
            end

            if dt_any then
                // Dual-Tile: 2 slices. Real -> one port at bare index a
                // (NOT 2*a -- DAC's indexing differs from ADC's here).
                // I/Q -> one port only when a==0 (the a==2 case in the
                // real mask is unreachable for a 2-slice/Dual-Tile loop,
                // kept for literal fidelity to the source branch).
                for a = 0:1
                    if p(sprintf('t%d_DT_dac%d_enable', tile, a)) == 'on' then
                        spc = strtod(p(sprintf('t%d_DT_dac%d_sample_per_cycle', tile, a)));
                        width = adcbits * spc;
                        anaout = p(sprintf('t%d_DT_dac%d_analog_output', tile, a));
                        if anaout == 'Real' then
                            [in,in2,out,out2,in_label,out_label,nport] = ..
                                rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,'s',tileidx,a,width,%f);
                        elseif a == 0 | a == 2 then
                            [in,in2,out,out2,in_label,out_label,nport] = ..
                                rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,'s',tileidx,a,width,%f);
                        end
                    end
                end
            elseif qt_any then
                // Quad-Tile: 4 slices, same mixer_type-gated rule as ADC.
                for a = 0:3
                    if p(sprintf('t%d_QT_dac%d_enable', tile, a)) == 'on' then
                        mixtype = p(sprintf('t%d_QT_dac%d_mixer_type', tile, a));
                        if mixtype <> 'Off' then
                            spc = strtod(p(sprintf('t%d_QT_dac%d_sample_per_cycle', tile, a)));
                            width = adcbits * spc;
                            [in,in2,out,out2,in_label,out_label,nport] = ..
                                rfdc_add_port(in,in2,out,out2,in_label,out_label,nport,'s',tileidx,a,width,%f);
                        end
                    end
                end
            end
        end
    end

    // put the port info to the obj
    x=obj;
    graphics = obj.graphics;
    exprs = graphics.exprs;
    model = obj.model;
    evtin = [];
    evtout = [];
    io_in = [in;in];
    io_out = [out;out];
    io_in_type = ones(1, length(in));
    io_out_type = ones(1, length(out));
    [model,graphics,ok] = set_io(model, graphics, list(io_in', io_in_type), list(io_out', io_out_type), evtin, evtout);
    model.out = out;
    model.out2 = out2;
    model.in = in;
    model.in2 = in2;
    graphics.out_label = out_label;
    graphics.in_label = in_label;
    graphics.style = rfdc_build_style(p('name'));
    graphics.exprs = exprs;
    x.graphics = graphics;
    x.model = model;
endfunction
