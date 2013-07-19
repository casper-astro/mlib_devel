function [multipliers_setup, spec_array] = multiplier_specification(spec_array, desired_size, caller_name)
% Multiplier implementation specification is done in a bunch of places, so
% this function helps to do that.

if length(spec_array) == 1
    % Replicate single value for desired_size
    spec_array = ones(1, desired_size) * spec_array;
elseif length(spec_array) < desired_size
    % Default missing specifiers to use HDL
    missing = desired_size - length(spec_array);
    warning('%s: defaulting %d missing multiplier specifiers to use HDL', ...
        caller_name, missing);
    spec_array = [reshape(spec_array, 1, []), ones(1, missing) * 2];
elseif length(spec_array) > desired_size
    % Ignore extra trailing specifiers
    warning('%s: ignoring %d extra multiplier specifiers', ...
        caller_name, length(spec_array) - desired_size);
    spec_array = spec_array(1:desired_size);
end

temp.use_hdl = 'on'; temp.use_embedded = 'off';
multipliers_setup = repmat(temp, desired_size);
clear temp;
for ctr = 1 : desired_size,
    if (spec_array(ctr) > 2) || (spec_array(ctr) < 0),
        error_string = sprintf('%s: multiplier specification of %i for stage %i is not valid.', caller_name, spec_array(ctr), ctr);
        clog(error_string,'error');
        errordlg(error_string);
        return;
    end
    temp.use_hdl = 'on'; temp.use_embedded = 'off';
    if spec_array(ctr) == 0,
        temp.use_hdl = 'off'; temp.use_embedded = 'off';
    elseif spec_array(ctr) == 1,
        temp.use_hdl = 'off'; temp.use_embedded = 'on';
    end
    multipliers_setup(ctr) = temp;
end

return
