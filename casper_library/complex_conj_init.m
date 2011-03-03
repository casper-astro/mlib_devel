function complex_conj_init(bitwidth, bin_pt, latency, mode)

in = xInport('z');
out = xOutport('z*');

in_real = xSignal;
in_imag = xSignal;
out_real = xSignal;
out_imag = xSignal;

c_to_ri_config.source = 'casper_library_misc/c_to_ri';
c_to_ri_config.name = 'c_to_ri';

xBlock( c_to_ri_config, ...
    struct('n_bits', bitwidth, 'bin_pt', bin_pt), ...
    {in}, ...
    {in_real, in_imag} );

if strcmp(mode, 'dsp48e')
    latency = 3;
end

delay_config.source = 'Delay';
delay_config.name = 'real_delay';
xBlock( delay_config, struct('latency', latency), ...
    {in_real}, ...
    {out_real} );

negate_config.source = str2func('negate_init');
negate_config.name = 'imag_negate';
xBlock( negate_config, {bitwidth, bin_pt, latency, mode}, ...
    {in_imag}, ...
    {out_imag} );

ri_to_c_config.source = 'casper_library_misc/ri_to_c';
ri_to_c_config.name = 'ri_to_c';
xBlock( ri_to_c_config, {}, {out_real, out_imag}, {out});


end