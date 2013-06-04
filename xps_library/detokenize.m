function detokenize(in_fid, out_fid, xps_objs);

xsg_obj = xps_objs{1};

hw_sys         = get(xsg_obj,'hw_sys');
sw_os          = get(xsg_obj,'sw_os');
app_clk        = get(xsg_obj,'clk_src');
app_clk_rate   = get(xsg_obj,'clk_rate');
input_clk_rate = 100;
multiply       = 1;
divide         = 1;
divclk         = 1;

if strcmp(hw_sys, 'ROACH2')
   if strcmp(app_clk, 'aux_clk')
      input_clk_rate = app_clk_rate;
      [multiply divide divclk] = clk_factors(100, 100);
      fprintf(strcat('Running off aux_clk @ ', int2str(app_clk_rate), 'MHz', '\n'))
   elseif strcmp(app_clk, 'sys_clk')
      [multiply divide divclk] = clk_factors(100, app_clk_rate);
      fprintf(strcat('Running off sys_clk @ ', int2str(input_clk_rate*multiply/divide/divclk), 'MHz','\n'))
   else
      [multiply divide divclk] = clk_factors(100, 100);
      fprintf(strcat('Running off adc_clk @ ', int2str(app_clk_rate), 'MHz','\n')) 
   end
   if input_clk_rate < 135
      clk_high_low = 'low';
   else
      clk_high_low = 'high';
   end
end

while 1
    line = fgets(in_fid);
    if ~ischar(line)
        break;
    else
        toks = regexp(line,'(.*)#IF#(.*?)#(.*)','tokens');
        if isempty(toks)
            fprintf(out_fid,line);
        else
            default   = toks{1}{1};
            condition = toks{1}{2};
            real_line = toks{1}{3};
            condition_met = 0;
            for i = 1:length(xps_objs)
                b = xps_objs{i};
                try
                    if eval(condition)
                        condition_met = 1;
                        try
                            real_line = eval(real_line);
                        end
                        fprintf(out_fid,real_line);
                        break;
                    end
                end
            end
            if ~condition_met & ~isempty(default)
                fprintf(out_fid, [default, '\n']);
            end
        end
    end
end

