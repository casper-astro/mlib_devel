function pipeline_init_xblock(latency)



%% inports
xlsub2_d = xInport('d');

%% outports
xlsub2_q = xOutport('q');

%% diagram

if (latency==0)
    xlsub2_q.bind(xlsub2_d);
else
    prev=xlsub2_d;
    next=xSignal;
    for i=1:latency,
        xlsub2_Register.(['R',num2str(i-1)]) = xBlock(struct('source', 'Register', 'name', ['Register',num2str(i-1)]), ...
                                             [], ...
                                             {prev}, ...
                                             {next});
        prev=xSignal;
        prev.bind(next);
        next=xSignal;
    end
    xlsub2_q.bind(prev);
end
    
        
    
% % block: delay_7/pipeline/Register0
% xlsub2_Register0_out1 = xSignal;
% xlsub2_Register0 = xBlock(struct('source', 'Register', 'name', 'Register0'), ...
%                           [], ...
%                           {xlsub2_d}, ...
%                           {xlsub2_Register0_out1});
% 
% % block: delay_7/pipeline/Register1
% xlsub2_Register1 = xBlock(struct('source', 'Register', 'name', 'Register1'), ...
%                           [], ...
%                           {xlsub2_Register0_out1}, ...
%                           {xlsub2_q});
% 


end

