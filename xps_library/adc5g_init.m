function adc5g_init(blk, varargin)
% Initialize and configure the ASIA 5 GSps ADC

% Declare defaults to be used throughout
defaults = {...
    'demux', '1:1',...
    'adc_clk_rate', 450,...
    'adc_bit_width', 8,...
    'adc_brd', 'ZDOK 0',...
    'using_ctrl', 'on'};

% Check to see if mask parameters have changed
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'adc5g');
munge_block(blk, varargin{:});

% Get all the mask parameters and form the needed derivatives
demux = get_var('demux', 'defaults', defaults, varargin{:});
adc_clk_rate = get_var('adc_clk_rate', 'defaults', defaults, varargin{:});
adc_bit_width = get_var('adc_bit_width', 'defaults', defaults, varargin{:});
adc_brd = get_var('adc_brd', 'defaults', defaults, varargin{:});
using_ctrl = get_var('using_ctrl', 'defaults', defaults, varargin{:});

% Alter the simulation gains depending on the bitwidth
set_param([gcb, '/gain_i'], 'Gain', num2str(2^adc_bit_width));
set_param([gcb, '/gain_q'], 'Gain', num2str(2^adc_bit_width));

% Find all the Xilinx Gateway-In ports and make sure they 
% have the correct names and bitwidths for synthesis
gateway_ins = find_system(gcb,'searchdepth',1,'FollowLinks', 'on', 'lookundermasks','all','masktype','Xilinx Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw,'Name'),'(user_data_[iq][012345657])$')
        if strcmp(demux, '1:1')
            set_param(gw, 'n_bits', '8');
        elseif strcmp(demux, '1:2')
            set_param(gw, 'n_bits', '4');
        else
            error(['Demux ', demux, ' is unsupported!']);
        end
        toks = regexp(get_param(gw,'Name'),'(user_data_[iq][012344567])$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(sync)$')
        toks = regexp(get_param(gw,'Name'),'(sync)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    else
        error(['Unkown gateway name: ',gw]);
    end
end

save_state(blk, 'defaults', defaults, varargin{:});
