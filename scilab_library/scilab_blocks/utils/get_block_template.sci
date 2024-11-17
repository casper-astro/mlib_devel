// open the block template file
function [template] = get_block_template(type, tag)
    scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
    template_path = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
    template = fromJSON(template_path, "file");
endfunction