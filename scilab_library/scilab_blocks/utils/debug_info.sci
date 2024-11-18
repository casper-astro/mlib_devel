// In this function, we check the CASPEER_DEBUG environment variable to see if we should print debug info.
function [] = debug_info(debug_str)
    // check the CASPEER_DEBUG environment variable
    debug = getenv('CASPER_DEBUG');
    if debug == 'on' then
        // TODO: got errors, when using datetime('now') too often.
        // This seems a bug in scilab.
        // dt = datetime('now')
        // disp('Debug info - ' + string(dt) + ' - ' + debug_str);
        disp('Debug info - ' + debug_str);
    end
endfunction