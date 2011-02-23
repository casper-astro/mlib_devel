function adder_tree_init_xblock(n_inputs, add_latency, quantization, overflow, mode)

	% dummy 0 input
	dummy_input = xSignal;
	dummy_const = xBlock(struct('source', 'Constant', 'name', 'zero_in'), ...
							struct('arith_type', 'Unsigned', ...
								   'const', 0, ...
								   'n_bits', 18, ...
								   'bin_pt', 17), ...
							{}, ...
							{dummy_input});
	
	% Inports
	sync_in = xInport('sync');
	inports = {};
	for k=1:n_inputs,
		inports{k} = xInport(['din_', num2str(k)]);
	end
	
	sync_out = xOutport('sync_out');
	dout = xOutport('dout');
	
	n_stages = ceil(log2(n_inputs));
	if strcmp(mode, 'dsp48e') || strcmp(mode, 'DSP48e')
		add_latency = 2;
	end
	
	% Take care of sync
	sync_delay_config.source = 'Delay';
	sync_delay_config.name = 'sync_delay';
	sync_delay_block = xBlock( sync_delay_config, struct('latency', n_stages*add_latency), ...
								{sync_in}, {sync_out});



% If nothing to add, connect in to out
if n_stages==0
	dummy_delay_config.source = 'Delay';
	dummy_delay_config.name = 'dummy_delay';
	dummy_delay_block = xBlock( dummy_delay_config, struct('latency', 0), ...
							inports, {dout});

elseif strcmp(mode, 'DSP48e')
	[data_inports, n_real_ports] = cluster_ports( inports, dummy_input, 4 );
	n_simd_adders = 0;
	stage_outports = inports;
	stage_ind = 1;
	while (1)
		[data_inports, n_real_ports] = cluster_ports(stage_outports, dummy_input, 4);
		if length(stage_outports) <= 2,
				data_inports{1}
				ports = data_inports{1};
				penult_stage_out1 = xSignal;
				penult_stage_out2 = xSignal;                
				adder_config.source = 'simd_add_dsp48e_init';
				adder_config.name = ['adder_', num2str(n_simd_adders)];
				adder1 = xBlock( adder_config, {'Addition', 18 + stage_ind, 17, 18 + stage_ind, ...
							17, 'on', 18, 17, 'Truncate', ...
							'Wrap', 0}, ...
							{ports{3}, ports{1}, ports{4}, ports{2}}, ...
							{dout, []});	
				n_simd_adders = n_simd_adders + 1;            
				break
		elseif length(stage_outports) <= 4
			% base case, manually instantiate the 2 required adders
				penult_stage_out1 = xSignal;
				penult_stage_out2 = xSignal;
				adder_config.source = 'simd_add_dsp48e_init';
				adder_config.name = ['adder_', num2str(n_simd_adders)];
				adder1 = xBlock( adder_config, {'Addition', 18 + stage_ind-1, 17, 18 + stage_ind-1, ...
							17, 'on', 18, 17, 'Truncate', ...
							'Wrap', 0}, ...
							data_inports{1}, ...
							{penult_stage_out1, penult_stage_out2});	
				n_simd_adders = n_simd_adders + 1;
	
				adder_config.source = 'simd_add_dsp48e_init';
				adder_config.name = ['adder_', num2str(n_simd_adders)];
				adder2 = xBlock( adder_config, {'Addition', 18 + stage_ind, 17, 18 + stage_ind, ...
							17, 'on', 18, 17, 'Truncate', ...
							'Wrap', 0}, ...
							{penult_stage_out1, dummy_input, penult_stage_out2, dummy_input}, ...
							{dout, []});	
				n_simd_adders = n_simd_adders + 1;
			break		
		else
			stage_outports = {};
			for k=1:length(data_inports)
				% instantiate an adder
				sum1 = xSignal;
				sum2 = xSignal;
				adder_config.source = 'simd_add_dsp48e_init';
				adder_config.name = ['adder_', num2str(n_simd_adders)];
				adder = xBlock( adder_config, {'Addition', 18 + stage_ind-1, 17, 18 + stage_ind-1, ...
							17, 'on', 18, 17, 'Truncate', ...
							'Wrap', 0}, ...
							data_inports{k}, ...
							{sum1, sum2});	
				stage_outports{2*k-1} = sum1;
				stage_outports{2*k} = sum2;
				n_simd_adders = n_simd_adders + 1;
			end
		end
		stage_ind = stage_ind + 1;
	
	end
elseif strcmp(mode, 'Behavioral') || strcmp(mode, 'Fabric')
	% [data_inports, n_real_ports] = cluster_ports( inports, dummy_input, 2 );
	n_simd_adders = 0;
	stage_outports = inports;
	stage_ind = 1;
    
    if strcmp(mode, 'Behavioral')
        adder_config = struct('mode', 'Addition', 'latency', add_latency, 'precision', 'Full', ...
								 		'quantization', quantization, 'overflow', overflow, ...
                                        'use_behavioral_HDL', 'on');
    else
        adder_config = struct('mode', 'Addition', 'latency', add_latency, 'precision', 'Full', ...
								 		'quantization', quantization, 'overflow', overflow, ...
                                        'use_behavioral_HDL', 'off', 'hw_selection', 'Fabric');        
    end
    
	while (1)
		[data_inports, n_real_ports] = cluster_ports(stage_outports, dummy_input, 2);

		if length(stage_outports) <= 2,
			% base case
			last_adder = xBlocK( struct('source', 'AddSub', 'name', ['adder_', num2str(n_simd_adders)] ), ...
								 adder_config, ...
								 data_inports{1}, {dout} );						 
			break;

		else
			last_port = stage_outports{end};
			stage_outports = {};
			for k=1:length(data_inports)
				sum_out = xSignal;				
				if (mod(n_real_ports, 2) == 1 ) && (k == length(data_inports))
					% last input goes through a delay iff odd number of inputs
					delay = xBlock( struct('source', 'Delay', 'name', ['delay_', num2str(n_simd_adders)]), ...
									struct('latency', add_latency), ...
									{last_port}, {sum_out} );
					stage_outports{k} = sum_out;
					
				else % instantiate an adder
					adder = xBlock( struct('source', 'AddSub', 'name', ['adder_', num2str(n_simd_adders)] ), ...
									  adder_config, ...
									 data_inports{k}, {sum_out} );
					stage_outports{k} = sum_out;
				end
				n_simd_adders = n_simd_adders + 1;				
				
			end
		end
		stage_ind = stage_ind + 1;
	end
end % endif

end 

function [port_clusters, n_inputs] = cluster_ports( port_list, dummy_input, cluster_size )
	port_clusters = {};
	n_inputs = length( port_list );
	for k=1:ceil(n_inputs/cluster_size),
		ports = {};
		for m=cluster_size-1:-1:0,
			if cluster_size*k-m <= n_inputs
				ports{m+1} = port_list{cluster_size*k-m};
			else
				ports{m+1} = dummy_input;
			end
		end
		port_clusters{k} = ports;
	end
end
