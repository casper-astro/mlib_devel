function build_cmd = jasper(model)

if nargin > 0
    build_cmd = jasper_frontend(model);
else
    build_cmd = jasper_frontend;
end

if isempty(build_cmd)
    error(['JASPER front-end completed okay, but could not find ', ...
        'a valid back-end to use. Have you defined the JASPER_BACKEND ', ...
        'environment variable?']);
end

system(build_cmd)
% end
