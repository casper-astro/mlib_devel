/* Read scilab_library/casper_modules.json, the single source of truth for
   which casper_dsp/casper_xps/casper_sim modules load_casper_lib.sci loads
   and registers into the Xcos palette, and which category (sub-palette
   leaf) each one belongs to. See casper_dsp_from_simulink/SKILL.md Step 3c
   for how to add a new module. */
function [registry] = load_module_registry()
    mlib_devel_path = getenv("MLIB_DEVEL_PATH");
    fn = sprintf("%s/scilab_library/casper_modules.json", mlib_devel_path);
    registry = fromJSON(fn, 'file');
endfunction

/* JSON booleans aren't guaranteed to decode to a Scilab `boolean` (versus a
   1/0 double or a "true"/"false" string) across fromJSON implementations --
   accept any of the three, so get_enabled_modules() doesn't depend on which
   one this Scilab install produces. */
function [b] = to_bool(v)
    t = typeof(v);
    if t == 'boolean' then
        b = v;
    elseif t == 'constant' then
        b = (v == 1);
    else
        s = convstr(string(v), 'l');
        b = (s == 'true') | (s == '1');
    end
endfunction

/* Return a struct name -> {category, icon} of every module with
   enabled=true under registry(group_key) (e.g. group_key = 'casper_dsp').
   icon is '' when the module has none. Modules with enabled=false, or
   missing from the registry entirely, are left out -- load_casper_lib.sci
   never execs or instantiates them at all. */
function [enabled] = get_enabled_modules(registry, group_key)
    enabled = struct();
    if ~isfield(registry, group_key) then
        return;
    end
    grp = registry(group_key);
    names = fieldnames(grp);
    for i = 1:size(names, '*')
        name = names(i);
        entry = grp(name);
        if to_bool(entry('enabled')) then
            info = struct();
            info('category') = entry('category');
            if isfield(entry, 'icon') then
                info('icon') = entry('icon');
            else
                info('icon') = '';
            end
            enabled(name) = info;
        end
    end
endfunction
