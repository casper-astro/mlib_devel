// In this function, we check the CASPEER_DEBUG environment variable to see if we should print debug info.
function [] = debug_info(debug_str)
    // check the CASPEER_DEBUG environment variable
    debug = getenv('CASPER_DEBUG');
    if debug == 'on' then
        disp(debug_str);
    end
endfunction