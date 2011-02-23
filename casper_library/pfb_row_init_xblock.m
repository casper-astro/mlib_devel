function pfb_row_init_xblock(nput, PFBSize, CoeffBitWidth, TotalTaps, BitWidthIn, BitWidthOut, CoeffDistMem, WindowType, add_latency, mult_latency, bram_latency, n_inputs, fwidth, use_hdl, use_embedded, conv_latency, adder_tree_impl, quantization, mult_impl)
%% inports
din = xInport('din');
sync = xInport('sync');

%% outports
sync_out = xOutport('sync_out');
out = xOutport('out');

%% diagram

coeff_gen_dout = xSignal;
delay_bram_out1 = xSignal;
scale_1_1_out1 = xSignal;
coeff_gen_sync_out = xSignal;
sync_delay_out1 = xSignal;
delay0_dout = xSignal;
sync_delay_out2 = xSignal;
coeff_gen_outports = {coeff_gen_dout, coeff_gen_sync_out};
for k=1:TotalTaps,
    coeff_gen_outports{k+2} = xSignal;
end
pfb_coeff_gen_out3 = coeff_gen_outports{3};
pfb_coeff_gen_out4 = coeff_gen_outports{4};

% Coefficient Generator
coeff_gen_config.source = str2func('pfb_coeff_gen_init_xblock');
coeff_gen_config.name = 'pfb_coeff_gen';
pfb_coeff_gen_sub = xBlock(coeff_gen_config, {PFBSize, CoeffBitWidth, TotalTaps, ...
    CoeffDistMem, WindowType, bram_latency, n_inputs, ...
    nput, fwidth});
% pfb_coeff_gen_sub = pfb_coeff_gen(PFBSize, CoeffBitWidth, TotalTaps, CoeffDistMem, WindowType, bram_latency, n_inputs, nput, fwidth);
pfb_coeff_gen_sub.bindPort({din, sync}, coeff_gen_outports);



% block: dsp48e_pfb_test2/pfb_row/convert_1_1

convert_1_1 = xBlock(struct('source', 'Convert', 'name', 'convert_1_1'), ...
    struct('n_bits', BitWidthOut, ...
    'bin_pt', BitWidthOut-1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'latency', 1, ...
    'pipeline', 'on'), ...
    {scale_1_1_out1}, ...
    {out});

% block: dsp48e_pfb_test2/pfb_row/scale_1_1
macc_dsp48e_2in_0_out1 = xSignal;
scale_factor = 1 + nextpow2(TotalTaps);
scale_1_1 = xBlock(struct('source', 'Scale', 'name', 'scale_1_1'), ...
    struct('scale_factor', -scale_factor), ...
    {macc_dsp48e_2in_0_out1}, ...
    {scale_1_1_out1});

% block: dsp48e_pfb_test2/pfb_row/sync_delay1
sync_delay1 = xBlock(struct('source', 'Delay', 'name', 'sync_delay1'), ...
    struct('latency', conv_latency), ...
    {sync_delay_out2}, ...
    {sync_out});

% block: dsp48e_pfb_test2/pfb_row/delay_bram

delay_out_sigs = {coeff_gen_dout};
delay_k_out = xSignal;
for k = 2:TotalTaps,
    delay_km1_out = delay_k_out;
    delay_k_out = xSignal;
    bram1_config.source = str2func('delay_bram_init');
    bram1_config.name = ['delay_bram', num2str(k)];
    delay1 = xBlock(bram1_config, {2^(PFBSize-n_inputs)*1, bram_latency, 'on'});
    delay1.bindPort({delay_out_sigs{k-1}}, {delay_k_out});
    delay_out_sigs{k} = delay_k_out;
    
end

macc_dsp48_ports = {};
for k=1:TotalTaps
    macc_dsp48_ports{2*k-1} = coeff_gen_outports{k+2};
    macc_dsp48_ports{2*k} = delay_out_sigs{k};
end
% macc_dsp48_ports

if strcmp(mult_impl, 'DSP48e')
    sync_delay_per = 2^(PFBSize-n_inputs) * (TotalTaps-1) + mult_latency + 1;
    
    macc_dsp48_outports = {};
    adder_tree_inports = {sync_delay_out1};
    for k=1:ceil(TotalTaps/2)
        macc_dsp48_outports{k} = xSignal;
        adder_tree_inports{k+1} = macc_dsp48_outports{k};
    end
    
    % instantiate N-input MACC
    macc_config.source = str2func('macc_dsp48e_init_xblock');
    macc_config.name = 'macc_dsp48e';
    macc_config.depend = {'macc_dsp48e_init_xblock.m'};
    macc_dsp48e_2in_0_sub = xBlock(macc_config, {CoeffBitWidth, CoeffBitWidth-1, BitWidthIn, ...
        BitWidthIn-1, 'on', CoeffBitWidth+BitWidthIn+1, CoeffBitWidth+BitWidthIn-2, 'Truncate', ...
        'Wrap', 0, TotalTaps});
    macc_dsp48e_2in_0_sub.bindPort( macc_dsp48_ports, macc_dsp48_outports);
    
    
    % instantiate N-input adder tree
    adder_tree_config.source = str2func('adder_tree_init_xblock');
    adder_tree_config.name = 'adder_tree';
    adder_tree_config.depend = {'adder_tree_init_xblock.m'};
    adder_tree_block = xBlock( adder_tree_config, {TotalTaps/2, add_latency, quantization, 'Wrap', adder_tree_impl});
    adder_tree_block.bindPort( adder_tree_inports, {sync_delay_out2, macc_dsp48e_2in_0_out1} );
    
    
elseif strcmp(mult_impl, 'Fabric')
    sync_delay_per = 2^(PFBSize-n_inputs) * (TotalTaps-1) + mult_latency;

    
    macc_dsp48_outports = {};
    adder_tree_inports = {sync_delay_out1};
    for k=1:TotalTaps
        macc_dsp48_outports{k} = xSignal;
        adder_tree_inports{k+1} = macc_dsp48_outports{k};
    end
    
    % instantiate N-input MACC
    macc_config.source = str2func('tap_multiply_fabric_init_xblock');
    macc_config.name = 'tap_mult_fabric';
    macc_dsp48e_2in_0_sub = xBlock(macc_config, {BitWidthIn, BitWidthIn-1, mult_latency, 'Truncate', ...
        'Wrap', TotalTaps});
    macc_dsp48e_2in_0_sub.bindPort( macc_dsp48_ports, macc_dsp48_outports);
    
    % instantiate N-input adder tree
    adder_tree_config.source = str2func('adder_tree_init_xblock');
    adder_tree_config.name = 'adder_tree';
    adder_tree_config.depend = {'adder_tree_init_xblock.m'};
    adder_tree_block = xBlock( adder_tree_config, {TotalTaps, add_latency, quantization, 'Wrap', adder_tree_impl});
    adder_tree_block.bindPort( adder_tree_inports, {sync_delay_out2, macc_dsp48e_2in_0_out1} );
end


% block: dsp48e_pfb_test2/pfb_row/sync_delay
sync_delay_config.source = str2func('sync_delay_init');
sync_delay_config.name = 'sync_delay';
sync_delay = xBlock( sync_delay_config, ...
    {sync_delay_per, 0, 0}, ...
    {coeff_gen_sync_out}, ...
    {sync_delay_out1});

end

