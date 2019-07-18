function jasper(model)

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

disp('****************************************')
disp('*  Frontend complete!                  *')
disp('*  Running Backend generation          *')
disp('****************************************')

rv = system(build_cmd);

if rv > 0
    error('Backend build failed! Check log files for more information');
else
    disp('****************************************')
    disp('*  Backend complete!                   *')
    disp('****************************************')
end
