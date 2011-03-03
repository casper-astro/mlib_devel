function mirror_spectrum_init(FFTSize, input_bitwidth, bram_latency, negate_latency, negate_mode)


%% inports
sync = xInport('sync');
din0 = xInport('din0');
reo_in0 = xInport('reo_in0');
din1 = xInport('din1');
reo_in1 = xInport('reo_in1');
din2 = xInport('din2');
reo_in2 = xInport('reo_in2');
din3 = xInport('din3');
reo_in3 = xInport('reo_in3');

%% outports
sync_out = xOutport('sync_out');
dout0 = xOutport('dout0');
dout1 = xOutport('dout1');
dout2 = xOutport('dout2');
dout3 = xOutport('dout3');

input_bin_pt = input_bitwidth - 1;

%% diagram

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Constant3
Constant3_out1 = xSignal;
Constant3 = xBlock(struct('source', 'Constant', 'name', 'Constant3'), ...
                          struct('arith_type', 'Unsigned', ...
                                 'const', 2^(FFTSize - 1), ...
                                 'n_bits', FFTSize, ...
                                 'bin_pt', 0, ...
                                 'explicit_period', 'on'), ...
                          {}, ...
                          {Constant3_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Counter
Delay1_out1 = xSignal;
Counter_out1 = xSignal;
Counter = xBlock(struct('source', 'Counter', 'name', 'Counter'), ...
                        struct('n_bits', FFTSize, ...
                               'rst', 'on', ...
                               'explicit_period', 'off', ...
                               'use_rpm', 'on'), ...
                        {Delay1_out1}, ...
                        {Counter_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Delay1
Delay1 = xBlock(struct('source', 'Delay', 'name', 'Delay1'), ...
                       struct('latency', bram_latency - 2 + 1 + negate_latency), ...
                       {sync}, ...
                       {Delay1_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Delay2
Delay2 = xBlock(struct('source', 'Delay', 'name', 'Delay2'), ...
                       struct('latency', 2), ...
                       {Delay1_out1}, ...
                       {sync_out});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Delay3
Delay3_out1 = xSignal;
Delay3 = xBlock(struct('source', 'Delay', 'name', 'Delay3'), ...
                       struct('latency', bram_latency - 1 + 1 + negate_latency), ...
                       {din0}, ...
                       {Delay3_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Delay4
Delay4_out1 = xSignal;
Delay4 = xBlock(struct('source', 'Delay', 'name', 'Delay4'), ...
                       struct('latency', bram_latency - 1 + 1 + negate_latency), ...
                       {din1}, ...
                       {Delay4_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Delay5
Delay5_out1 = xSignal;
Delay5 = xBlock(struct('source', 'Delay', 'name', 'Delay5'), ...
                       struct('latency', bram_latency - 1 + 1 + negate_latency), ...
                       {din2}, ...
                       {Delay5_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Delay6
Delay6_out1 = xSignal;
Delay6 = xBlock(struct('source', 'Delay', 'name', 'Delay6'), ...
                       struct('latency', bram_latency - 1 + 1 + negate_latency), ...
                       {din3}, ...
                       {Delay6_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Mux
Relational_out1 = xSignal;
complex_conj0_out1 = xSignal;
Mux = xBlock(struct('source', 'Mux', 'name', 'Mux'), ...
                    struct('latency', 1, ...
                           'arith_type', 'Signed  (2''s comp)', ...
                           'n_bits', 8, ...
                           'bin_pt', 2), ...
                    {Relational_out1, Delay3_out1, complex_conj0_out1}, ...
                    {dout0});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Mux1
complex_conj1_out1 = xSignal;
Mux1 = xBlock(struct('source', 'Mux', 'name', 'Mux1'), ...
                     struct('latency', 1, ...
                            'arith_type', 'Signed  (2''s comp)', ...
                            'n_bits', 8, ...
                            'bin_pt', 2), ...
                     {Relational_out1, Delay4_out1, complex_conj1_out1}, ...
                     {dout1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Mux2
complex_conj2_out1 = xSignal;
Mux2 = xBlock(struct('source', 'Mux', 'name', 'Mux2'), ...
                     struct('latency', 1, ...
                            'arith_type', 'Signed  (2''s comp)', ...
                            'n_bits', 8, ...
                            'bin_pt', 2), ...
                     {Relational_out1, Delay5_out1, complex_conj2_out1}, ...
                     {dout2});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Mux3
complex_conj3_out1 = xSignal;
Mux3 = xBlock(struct('source', 'Mux', 'name', 'Mux3'), ...
                     struct('latency', 1, ...
                            'arith_type', 'Signed  (2''s comp)', ...
                            'n_bits', 8, ...
                            'bin_pt', 2), ...
                     {Relational_out1, Delay6_out1, complex_conj3_out1}, ...
                     {dout3});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/Relational
Relational = xBlock(struct('source', 'Relational', 'name', 'Relational'), ...
                           struct('mode', 'a>b'), ...
                           {Counter_out1, Constant3_out1}, ...
                           {Relational_out1});


% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/complex_conj0
complex_conj_config.source = str2func('complex_conj_init');
complex_conj_config.name = 'complex_conj0';
complex_conj_config.depend = {'complex_conj_init.m'};
complex_conj0 = xBlock( complex_conj_config, {input_bitwidth, input_bin_pt, negate_latency, negate_mode}, ...
    {reo_in0}, {complex_conj0_out1});

complex_conj_config.name = 'complex_conj1';
complex_conj1 = xBlock( complex_conj_config, {input_bitwidth, input_bin_pt, negate_latency, negate_mode}, ...
    {reo_in1}, {complex_conj1_out1} );

complex_conj_config.name = 'complex_conj2';
complex_conj2 = xBlock( complex_conj_config, {input_bitwidth, input_bin_pt, negate_latency, negate_mode}, ...
    {reo_in2}, {complex_conj2_out1});

complex_conj_config.name = 'complex_conj3';
complex_conj3 = xBlock( complex_conj_config, {input_bitwidth, input_bin_pt, negate_latency, negate_mode}, ...
    {reo_in3}, {complex_conj3_out1});
% complex_conj0_sub = complex_conj0(18, 17, negate_latency, 'logic');
% complex_conj0_sub.bindPort({reo_in0}, {complex_conj0_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/complex_conj1
% complex_conj1_sub = complex_conj1(18, 17, negate_latency, 'logic');
% complex_conj1_sub.bindPort({reo_in1}, {complex_conj1_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/complex_conj2
% complex_conj2_sub = complex_conj2(18, 17, negate_latency, 'logic');
% complex_conj2_sub.bindPort({reo_in2}, {complex_conj2_out1});

% block: single_pol/fft_wideband_real1/fft_biplex_real_4x0/bi_real_unscr_4x/mirror_spectrum1/complex_conj3
% complex_conj3_sub = complex_conj3(18, 17, negate_latency, 'logic');
% complex_conj3_sub.bindPort({reo_in3}, {complex_conj3_out1});

% 
% 
% function xblock_obj = complex_conj0(bitwidth, bin_pt, latency, mode)
% 
% 
% % Mask Initialization code
% config.source = str2func('complex_conj_init');
% 
% config.depend = {'complex_conj_init.m'};
% xblock_obj = xBlock( config, {bitwidth, bin_pt, latency, mode});
% 
% 
% %% inports
% 
% %% outports
% 
% %% diagram
% 
% 
% 
% end
% 
% function xblock_obj = complex_conj1(bitwidth, bin_pt, latency, mode)
% 
% 
% % Mask Initialization code
% config.source = str2func('complex_conj_init');
% 
% config.depend = {'complex_conj_init.m'};
% xblock_obj = xBlock( config, {bitwidth, bin_pt, latency, mode});
% 
% 
% %% inports
% 
% %% outports
% 
% %% diagram
% 
% 
% 
% end
% 
% function xblock_obj = complex_conj2(bitwidth, bin_pt, latency, mode)
% 
% 
% % Mask Initialization code
% config.source = str2func('complex_conj_init');
% 
% config.depend = {'complex_conj_init.m'};
% xblock_obj = xBlock( config, {bitwidth, bin_pt, latency, mode});
% 
% 
% %% inports
% 
% %% outports
% 
% %% diagram
% 
% 
% 
% end
% 
% function xblock_obj = complex_conj3(bitwidth, bin_pt, latency, mode)
% 
% 
% % Mask Initialization code
% config.source = str2func('complex_conj_init');
% 
% config.depend = {'complex_conj_init.m'};
% xblock_obj = xBlock( config, {bitwidth, bin_pt, latency, mode});
% 
% 
% %% inports
% 
% %% outports
% 
% %% diagram
% 
% 
% 
% end

end

