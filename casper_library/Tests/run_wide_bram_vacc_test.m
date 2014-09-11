function [din, bram, bram_valid, wide, wide_valid] = run_wide_bram_vacc_test()
    % Assumes vector length is 10
    vec_len = 10;
    acc_len = 5;

    alpha = 1+2^-32;
    omega = 2.5;

    % Setup input vectors as [alpha, ..., omega]
    new_acc = [0; 1; zeros(acc_len*vec_len-2, 1)];
    din     = [0; omega; alpha; zeros(vec_len-3, 1)];

    % Start with all samples "ok"
    dok     = ones(1000, 1);
    % Then mark the first omega sample after the sync as "not ok"
    dok(12) = 0;

    bram_expected = [acc_len*alpha; zeros(vec_len-2, 1); acc_len*omega];
    wide_expected = [acc_len*alpha; zeros(vec_len-2, 1); (acc_len-1)*omega];

    new_acc_ws.time=[];
    new_acc_ws.signals.values=new_acc;

    din_ws.time=[];
    din_ws.signals.values=din;

    dok_ws.time=[];
    dok_ws.signals.values=dok;

    ws = get_param('wide_bram_vacc_test', 'ModelWorkspace');
    ws.assignin('new_acc', new_acc_ws);
    ws.assignin('din', din_ws);
    ws.assignin('dok', dok_ws);
    
    simout = sim('wide_bram_vacc_test', 'ReturnWorkspaceOutputs', 'on');
    
    bram       = simout.get('bram');
    bram_valid = simout.get('bram_valid');
    wide       = simout.get('wide');
    wide_valid = simout.get('wide_valid');

    % Skip any valid samples in first 20 samples (initial valid pulse is bogus)
    bram_valid(1:20) = 0;
    wide_valid(1:20) = 0;

    bram_accumulations = bram(find(bram_valid, 10));
    wide_accumulations = wide(find(wide_valid, 10));

    if length(bram_accumulations) ~= length(wide_accumulations)
      fprintf('length mismatch between bram vector and wide_bram vectors\n');
    elseif any(bram_accumulations - bram_expected)
      fprintf('data mismatch between bram vacc expected vs actual\n');
    elseif any(wide_accumulations - wide_expected)
      fprintf('data mismatch between wide vacc expected vs actual\n');
    else
      fprintf('OK\n');
    end
end
    
function foo()
    % Find sync_out pulse
    s=find(sync_out,1);
    % Clear validity flags before sync pulse
    valid(1:s)=0;
    % Find indexes of first 20 valid samples 
    idx=find(valid,20);
    % Get values for first 20 valid samples
    out=reshape([acc0(idx), acc1(idx)].', [], 1);
    
    nerr = 0;
    
    % MIRIAD Baseline 1-1
    nerr = nerr + xeng_check(out,  1, x(1), x(1));
    nerr = nerr + xeng_check(out,  2, y(1), y(1));
    nerr = nerr + xeng_check(out,  3, x(1), y(1));
    nerr = nerr + xeng_check(out,  4, y(1), x(1));
    
    % MIRIAD Baseline 1-2
    nerr = nerr + xeng_check(out,  5, x(1), x(2));
    nerr = nerr + xeng_check(out,  6, y(1), y(2));
    nerr = nerr + xeng_check(out,  7, x(1), y(2));
    nerr = nerr + xeng_check(out,  8, y(1), x(2));
    
    % MIRIAD Baseline 2-2
    nerr = nerr + xeng_check(out,  9, x(2), x(2));
    nerr = nerr + xeng_check(out, 10, y(2), y(2));
    nerr = nerr + xeng_check(out, 11, x(2), y(2));
    nerr = nerr + xeng_check(out, 12, y(2), x(2));

    % MIRIAD Baseline 1-3
    nerr = nerr + xeng_check(out, 13, x(1), x(3));
    nerr = nerr + xeng_check(out, 14, y(1), y(3));
    nerr = nerr + xeng_check(out, 15, x(1), y(3));
    nerr = nerr + xeng_check(out, 16, y(1), x(3));

    % MIRIAD Baseline 2-3
    nerr = nerr + xeng_check(out, 17, x(2), x(3));
    nerr = nerr + xeng_check(out, 18, y(2), y(3));
    nerr = nerr + xeng_check(out, 19, x(2), y(3));
    nerr = nerr + xeng_check(out, 20, y(2), x(3));

    % MIRIAD Baseline 3-3
    nerr = nerr + xeng_check(out, 21, x(3), x(3));
    nerr = nerr + xeng_check(out, 22, y(3), y(3));
    nerr = nerr + xeng_check(out, 23, x(3), y(3));
    nerr = nerr + xeng_check(out, 24, y(3), x(3));

    % MIRIAD Baseline 2-4
    nerr = nerr + xeng_check(out, 25, x(2), x(4));
    nerr = nerr + xeng_check(out, 26, y(2), y(4));
    nerr = nerr + xeng_check(out, 27, x(2), y(4));
    nerr = nerr + xeng_check(out, 28, y(2), x(4));

    % MIRIAD Baseline 3-4
    nerr = nerr + xeng_check(out, 29, x(3), x(4));
    nerr = nerr + xeng_check(out, 30, y(3), y(4));
    nerr = nerr + xeng_check(out, 31, x(3), y(4));
    nerr = nerr + xeng_check(out, 32, y(3), x(4));

    % MIRIAD Baseline 4-4
    nerr = nerr + xeng_check(out, 33, x(4), x(4));
    nerr = nerr + xeng_check(out, 34, y(4), y(4));
    nerr = nerr + xeng_check(out, 35, x(4), y(4));
    nerr = nerr + xeng_check(out, 36, y(4), x(4));

    % MIRIAD Baseline 1-4
    nerr = nerr + xeng_check(out, 37, x(1), x(4));
    nerr = nerr + xeng_check(out, 38, y(1), y(4));
    nerr = nerr + xeng_check(out, 39, x(1), y(4));
    nerr = nerr + xeng_check(out, 40, y(1), x(4));

    fprintf('found %d errors\n', nerr);
end
