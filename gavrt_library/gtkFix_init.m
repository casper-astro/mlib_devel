typestr = sprintf('int%d',width);
set_param([gcb, '/var_int'],'VariableName',['gtk_',strrep(get_param(gcb, 'Parent'),'/','_'),'__',get_param(gcb,'Name'),'_',typestr])
