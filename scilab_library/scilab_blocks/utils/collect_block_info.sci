function [] = collect_block_info(fn)
[path, projname, ext] = fileparts(fn);
// load the diagram file
scs_m = xcosDiagramToScilab(fn);
// get the number of objs
n_objs = length(scs_m.objs);

// query the block information
st = struct();
st('project') = struct('tag', 'proj', 'filename', fn);
// st('xps_blocks') = struct();
// st('dsp_blocks') = struct();
// st('sim_blocks') = struct();
// st('link_info') = struct();
st('xps_blocks') = list();
st('dsp_blocks') = list();
st('sim_blocks') = list();
xps_blocks_id = 1;
dsp_blocks_id = 1;
sim_blocks_id = 1;
scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
for i = 1:n_objs
    obj = scs_m.objs(i);
    // if it's a block, get the block info
    if typeof(obj) == 'Block' then
        tag = get_block_tag(obj);
        type = get_block_type(obj);
        // if it's a split_f block, we don't need to get the info
        if tag == 'SPLIT_f' then
            continue;
        end
        // get the block type and block tag
        // the type should be on of "xps", "dsp", "sim"
        // the tag is the "swreg", "gpio", etc.
        // each block has a template, which contains the paramters info and input/output ports info
        template_path = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
        template = fromJSON(template_path, "file");
        // create a new struct for the block info
        keys = template('parameters')('keys');
        vals = template('parameters')('values');
        block_info = struct();
        // set the default value from the template
        debug_info('block_template: ' + tag);
        for j = 1:size(keys)(2)
            block_info(keys(j)) = vals(j);
            debug_info('    key: ' + string(keys(j)) + ' val: ' + string(vals(j)));
        end
        // get the values from the scilab block
        blk_val = obj.graphics.exprs;
        blk_vindex = obj.model.rpar;
        debug_info('blk_name: ' + blk_val(1))
        for j = 1:length(blk_vindex)
            id = blk_vindex(j) + 1;
            debug_info('    id: ' + string(id) + ' val: ' + string(blk_val(j)));
            block_info(keys(id)) = blk_val(j);
        end
        // set "fullpath", which should be the project name + block name
        block_info('fullpath') = projname + '/' + block_info('name');
        // write the block info to the struct
        if type == 'xps' then
            st('xps_blocks')(xps_blocks_id) = block_info;
            xps_blocks_id = xps_blocks_id + 1;
        elseif type == 'dsp' then
            st('dsp_blocks')(dsp_blocks_id) = block_info;
            dsp_blocks_id = dsp_blocks_id + 1;
        elseif type == 'sim' then
            st('sim_blocks')(sim_blocks_id) = block_info;
            sim_blocks_id = sim_blocks_id + 1;
        end
     end
     // For the link info, we deal with it in another for loop.
     if typeof(obj) == 'Link' then
         continue;
     end
 end

// go through all of the link objs, 
// and generate the port names for each blk_obj based on the link objs.
// the port info is stored in a struct.
port_info = list();
// create a struct for each blk_obj
// some of the blk_objs are link objs, we don't need to generate port names for them
for i = 1:n_objs
    port_info(i) = struct();
    port_info(i)('in') = list();
    port_info(i)('out') = list();
end
st('link_info') = list();
ind = 1;
// go through all of the objs, and get the link objs
// we will generate the port info based on the link objs
for i = 1:n_objs
    obj = scs_m.objs(i);
    // check the obj type
    // if it's a link obj, we used generate port name based on this obj
    if typeof(obj) == 'Link' then
        port_info = gen_port_info(projname, scs_m.objs, obj);
    end
end

// create a big struct
toJSON(st, path + name + '/jasper.json', 4);
endfunction