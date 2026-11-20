// get the block type (category).
// we have three types of blocks: xps, dsp, sim -- plus 'scilab' for a
// block that isn't one of ours at all (see below).
//
// This is derived by probing for which casper_<category>/<tag>.json
// parameter template exists on disk, NOT from obj.model.label: Scicos
// aliases graphics.id (the text drawn on the block) with model.label, so
// model.label must stay free to hold the block's own display name instead
// of the category marker it used to hold.
function [type] = get_block_type(obj)
    mlib_devel_path = getenv("MLIB_DEVEL_PATH");
    tag = get_block_tag(obj);
    categories = ['dsp', 'xps', 'sim'];
    for i = 1:size(categories, '*')
        candidate = categories(i);
        fn = sprintf("%s/scilab_library/scilab_blocks/casper_%s/%s.json", mlib_devel_path, candidate, tag);
        if isfile(fn) then
            type = candidate;
            return;
        end
    end
    // Not a registered casper_<dsp|xps|sim> module -- in this toolflow
    // the only other kind of block an Xcos diagram can contain is a
    // built-in Scicos/Xcos block (SPLIT_f from a fanned-out wire being
    // the most common, but also links, superblocks, annotations, ...).
    // Callers that walk a whole diagram (pre_validate_design.sci,
    // collect_block_info.sci) need to tell these apart from a genuine
    // casper module without crashing, so this is a real return value,
    // not an error -- every other caller here only ever operates on an
    // object it already knows is one of its own casper blocks, so this
    // branch should never realistically be hit there.
    type = 'scilab-block';
endfunction
