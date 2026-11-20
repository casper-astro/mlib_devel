loadXcosLibs;

// load the scilab functions
exec('scilab_library/scilab_blocks/utils/debug_info.sci');
exec('scilab_library/scilab_blocks/utils/collect_block_info.sci');
exec('scilab_library/scilab_blocks/utils/get_block_tag.sci');
exec('scilab_library/scilab_blocks/utils/get_block_type.sci');
exec('scilab_library/scilab_blocks/utils/get_block_name.sci');
exec('scilab_library/scilab_blocks/utils/get_port_width.sci');
exec('scilab_library/scilab_blocks/utils/gen_block_config.sci');
exec('scilab_library/scilab_blocks/utils/get_link_info_by_link_obj.sci');
exec('scilab_library/scilab_blocks/utils/search_for_real_src_blk.sci');
exec('scilab_library/scilab_blocks/utils/get_port_name.sci');
exec('scilab_library/scilab_blocks/utils/get_port_width_id.sci');
exec('scilab_library/scilab_blocks/utils/update_block_config.sci');
exec('scilab_library/scilab_blocks/utils/get_block_vals.sci');
exec('scilab_library/scilab_blocks/utils/get_block_vindex.sci');
exec('scilab_library/scilab_blocks/utils/search_block_by_name.sci');
exec('scilab_library/scilab_blocks/utils/run_mask.sci');
exec('scilab_library/scilab_blocks/utils/gen_uid.sci');
exec('scilab_library/scilab_blocks/jasper.sci');
exec('scilab_library/scilab_blocks/jasper_frontend.sci');
exec('scilab_library/scilab_blocks/jasper_simulation.sci');
exec('scilab_library/scilab_blocks/run_simulation.sci');
exec('scilab_library/scilab_blocks/utils/update_bconfig.sci');
exec('scilab_library/scilab_blocks/utils/gen_block_name.sci');
exec('scilab_library/scilab_blocks/utils/get_blocks_by_uids.sci');
exec('scilab_library/scilab_blocks/utils/init_exprs.sci');
exec('scilab_library/scilab_blocks/utils/export_exprs.sci');
exec('scilab_library/scilab_blocks/utils/export_exprs_to_tmpdir.sci');
exec('scilab_library/scilab_blocks/utils/update_exprs.sci');
exec('scilab_library/scilab_blocks/utils/update_exprs_from_tmpdir.sci');
exec('scilab_library/scilab_blocks/utils/check_duplicate_names.sci');
exec('scilab_library/scilab_blocks/utils/check_valid_filename.sci');
exec('scilab_library/scilab_blocks/utils/pre_validate_design.sci');
exec('scilab_library/scilab_blocks/utils/check_bit_width.sci');
exec('scilab_library/scilab_blocks/utils/post_validate_design.sci');
exec('scilab_library/scilab_blocks/utils/remove_tmpdir.sci');
exec('scilab_library/scilab_blocks/utils/load_module_registry.sci');
exec('scilab_library/scilab_blocks/utils/bus_vec_width.sci');

// Which casper_dsp/casper_xps/casper_sim modules get loaded and registered
// into the Xcos palette -- and which category (sub-palette leaf) each one
// belongs to -- is entirely data-driven from scilab_library/casper_modules.json,
// not hand-edited here. See load_module_registry.sci and
// casper_dsp_from_simulink/SKILL.md Step 3c for how to add/enable a module.

/* exec() each enabled module's <module>.sci here, at the file's OWN top
   level -- NOT from inside load_casper_group() (or any other function)
   below. A function definition loaded via exec() from inside another
   function is local to that function's call frame and disappears once it
   returns (confirmed by direct test: exec()-ing a file that defines `foo`
   from inside a wrapper function leaves `exists('foo')` false as soon as
   the wrapper returns). It must be global here because xcosPalAddBlock(),
   for a block with no custom icon, calls generateBlockImage() to render
   one on the fly, which re-invokes the block's own interface function by
   name -- and can only find it if it's a global function, not a local one
   hidden inside some other function's scope. */
casper_module_registry = load_module_registry();
casper_group_keys = ['casper_xps'; 'casper_dsp'; 'casper_sim'];
for casper_g = 1:size(casper_group_keys, '*')
    casper_group_key = casper_group_keys(casper_g);
    casper_names = fieldnames(get_enabled_modules(casper_module_registry, casper_group_key));
    for casper_i = 1:size(casper_names, '*')
        exec(sprintf('scilab_library/scilab_blocks/%s/%s.sci', casper_group_key, casper_names(casper_i)));
    end
end
clear casper_module_registry casper_group_keys casper_g casper_group_key casper_names casper_i;

/* instantiate/register every module enabled=true under registry(group_key)
   (e.g. group_key = 'casper_dsp'), grouping them into one Xcos sub-palette
   per distinct "category" value, all nested under one top-level Category
   folder named top_name (e.g. "CASPER DSP" -> "Basic Elements"/"Flow_Control"/
   "Misc"). Every leaf here reuses the same top_name string for its
   xcosPalAdd call, which is what merges them into one folder instead of
   each spawning its own duplicate top-level entry (xcosPalAdd's category
   argument creates/reuses a Category tree node by exact string match).
   Every module's <module>.sci has already been exec()'d at top level
   above, so the execstr() call below can just call it by name. */
function [] = load_casper_group(group_key, top_name)
    registry = load_module_registry();
    enabled = get_enabled_modules(registry, group_key);
    names = fieldnames(enabled);
    fig_dir = pwd() + '/scilab_library/scilab_blocks/' + group_key + '/figures/';
    pals = struct();
    for i = 1:size(names, '*')
        name = names(i);
        entry = enabled(name);
        // dynamic call-by-name: Scilab has no feval(name, ...) equivalent,
        // so execstr() is the standard idiom -- assigns straight into the
        // local variable "inst", no need to fetch it back afterward.
        execstr('inst = ' + name + '(''define'')');
        cat = entry('category');
        if ~isfield(pals, cat) then
            pals(cat) = xcosPal(cat);
        end
        icon = entry('icon');
        if icon <> '' then
            iconfn = fig_dir + icon;
            pals(cat) = xcosPalAddBlock(pals(cat), inst, iconfn, iconfn);
        else
            pals(cat) = xcosPalAddBlock(pals(cat), inst);
        end
    end
    cats = fieldnames(pals);
    for i = 1:size(cats, '*')
        xcosPalAdd(pals(cats(i)), top_name);
    end
endfunction

debug_info('------Loading CASPER XPS...------');
load_casper_group('casper_xps', 'CASPER XPS');
debug_info('------ CASPER XPS loaded --------');

debug_info('------Loading CASPER DSP...------');
load_casper_group('casper_dsp', 'CASPER DSP');
debug_info('------ CASPER DSP loaded --------');

debug_info('------Loading CASPER SIM...------');
load_casper_group('casper_sim', 'CASPER SIM');
debug_info('------ CASPER SIM loaded --------');
