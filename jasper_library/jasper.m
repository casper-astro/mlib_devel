function build_cmd = jasper(model)

if nargin > 0
    build_cmd = jasper_frontend(model);
else
    build_cmd = jasper_frontend;
end

system(build_cmd)
% end
