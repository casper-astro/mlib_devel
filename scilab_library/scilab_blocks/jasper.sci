function [] = jasper(fn)
    // run jasper_fontend
    build_cmd = jasper_frontend(fn);
    if isempty(build_cmd) then
        return;
    end
    disp('****************************************')
    disp('*  Frontend complete!                  *')
    disp('*  Running Backend generation          *')
    disp('****************************************')
    disp('****************************************')
    disp('*  Generating DSP IP core...           *')
    disp('****************************************')
    unix_s(build_cmd('dsp'));
    disp('****************************************')
    disp('*  Compiling the model...              *')
    disp('****************************************')
    unix_w(build_cmd('full'));
    disp('****************************************')
    disp('*  Backend complete!                   *')
    disp('****************************************')
endfunction
