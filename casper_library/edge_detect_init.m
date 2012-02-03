function edge_detect_init(blk,varargin)
% Configure an edge_detect block
%
% edge = Edge to detect
%                1 = 'Rising'
%                2 = 'Falling'
%                3 = 'Both'
% polarity = Output polarity
%                1 = 'Active High'
%                2 = 'Active Low'

check_mask_type(blk,'edge_detect');

defaults = {'edge', 'Rising',...
            'polarity','Active High',...
            'x_in','[0,0.08,0.08,0.16,0.16,0.24,0.24,0.32,0.32,0.4]',...
            'x_out','[0.6,0.68,0.68,0.76,0.76,0.84,0.84,0.92,0.92,1]',...
            'y_in','[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]',...
            'y_out','[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end

munge_block(blk, varargin{:});
edge=get_var('edge', 'defaults', defaults, varargin{:});
polarity=get_var('polarity', 'defaults', defaults, varargin{:});

switch polarity
    case 'Active High'
        switch edge
        case 'Rising'
            edge_op='NOR';
            y_in  = [-1,-1,1,1,1,1,1,1,1,1];
            y_out = [-1,-1,1,1,-1,-1,-1,-1,-1,-1];
        case 'Falling'
            edge_op='AND';
            y_in=[1,1,-1,-1,-1,-1,-1,-1,-1,-1];
            y_out = [-1,-1,1,1,-1,-1,-1,-1,-1,-1];
        case 'Both'
            edge_op='XNOR';
            y_in=[-1,-1,1,1,1,1,-1,-1,-1,-1];
            y_out = [-1,-1,1,1,-1,-1,1,1,-1,-1];
        otherwise errordlg('Edge selection error');
        end

    case 'Active Low'
        switch edge
        case 'Rising'
            edge_op='OR';
            y_in  = [-1,-1,1,1,1,1,1,1,1,1];
            y_out = [-1,-1,1,1,-1,-1,-1,-1,-1,-1].* -1;
        case 'Falling'
            edge_op='NAND';
            y_in=[1,1,-1,-1,-1,-1,-1,-1,-1,-1];
            y_out = [-1,-1,1,1,-1,-1,-1,-1,-1,-1].* -1;
        case 'Both'
            edge_op='XOR';
            y_in=[-1,-1,1,1,1,1,-1,-1,-1,-1];
            y_out = [-1,-1,1,1,-1,-1,1,1,-1,-1].* -1;
        otherwise errordlg('Edge selection error');
        end

    otherwise errordlg('Polarity selection error');
end

% Setup edge_op
set_param([blk,'/edge_op'],'logical_function', edge_op);

varargin{10} = ['[',num2str(y_in),']'];
varargin{12} = ['[',num2str(y_out),']'];

% Set attribute format string (block annotation)
annotation=sprintf('%s edges\n%s', lower(edge), lower(polarity));
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

