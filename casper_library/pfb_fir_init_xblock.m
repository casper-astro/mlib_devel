function pfb_fir_init_xblock(PFBSize, TotalTaps, WindowType, n_inputs, MakeBiplex, BitWidthIn, BitWidthOut, ...
    CoeffBitWidth, CoeffDistMem, add_latency, mult_latency, bram_latency, conv_latency, ...
    quantization, fwidth, adder_tree_impl, mult_impl)    
%% inports & outports

sync_in = xInport('sync');
sync_out = xOutport('sync_out');

if MakeBiplex
    pols = 2;
else
    pols = 1;
end

for p = 1:pols,
    for k=1:2^n_inputs
        k
        p
        % declare input port
        pol1_in_k = xInport(['pol', num2str(p), '_in', num2str(k)]);
        
        % declare output port
        pol1_out_k = xOutport(['pol', num2str(p), '_out', num2str(k)]);
        
        % config for pfb_row
        pfb_row_k_config.source = str2func('pfb_row_init_xblock');
        pfb_row_k_config.name   = ['pfb_row_', num2str(p), num2str(k)];
        
        sync_out_conn = '';
        if k == 1 && p == 1,
            sync_out_conn = sync_out;
        end
        
        pfb_row_block = xBlock(pfb_row_k_config, {k-1, PFBSize, CoeffBitWidth, TotalTaps, ...
            BitWidthIn, BitWidthOut, CoeffDistMem, WindowType, add_latency, mult_latency, bram_latency, n_inputs, ...
            fwidth, 'on', 'off', conv_latency, adder_tree_impl, quantization, mult_impl}, ...
            {pol1_in_k, sync_in},... % inputs
            {sync_out_conn, pol1_out_k});    % outputs
        
    end
end

end

