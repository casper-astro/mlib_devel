// open the block template file
function [template] = get_block_template(type, tag)
    scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
    template_path = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
    debug_info('template_path: ' + template_path);
    template = fromJSON(template_path, "file");
    // convert all of the values to strings
    keys = template('parameters')('keys');
    vals = template('parameters')('values');
    for i = 1:size(keys)(2)
        template('parameters')('values')(i) = string(vals(i));
    end
endfunction