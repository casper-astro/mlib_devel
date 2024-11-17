#! /usr/bin/env python
import json
import os
from datetime import datetime
from utils.design_info import gen_design_info
from utils.git_info import gen_git_info
from utils.utils import gen_glue_module, dump_jasper, val_format_conv
from argparse import ArgumentParser

if __name__ == '__main__':
    parser = ArgumentParser(prog=os.path.basename(__file__))
    parser.add_argument("-c", "--builddir", dest="builddir", type=str,
                default='',
                help="build directory. Default: Use directory with same name as model")
    parser.add_argument("-m", "--model", dest="model", type=str,
                default="/tools/mlib_devel/jasper_library/test_models/test.xcos", 
                help="model to compile")
    
    opts = parser.parse_args()
    
    """
    Step 1: get the project directory and model name, then open jasper.json
    """
    # get the model path and model name
    builddir = opts.builddir or opts.model.split('.')[0]
    model_name = builddir.split('/')[-1]

    # open jasper.json, which contains the block(xps, dsp, sim) info and link info
    with open('%s/jasper.json'%builddir) as f:
        model_info = json.load(f)
    
    """
    Step 2: generate jasper.per, which contains the yellow(xps) block info and user module info 
    """
    # yellow(xps) blocks
    xps_blocks = {}
    for block in model_info['xps_blocks']:
        key = model_name + '/' + block['name']
        block = val_format_conv(block)
        xps_blocks[key] = block
        # the xsg block will also be added to jasper.dsp
        if block['tag'] == 'xps:xsg':
            xsg_block = block
    # add the ip core info to xps_blocks
    xps_blocks['sysgen_ip'] = {}
    xps_blocks['sysgen_ip']['name'] = 'sysgen_ip'
    xps_blocks['sysgen_ip']['fullpath'] = '%s/dspproj/dspproj.srcs'%(model_name)
    xps_blocks['sysgen_ip']['tag'] = 'xps:ip'
    xps_blocks['sysgen_ip']['lib_path'] = '%s/dspproj/dspproj.srcs'%(builddir)
    xps_blocks['sysgen_ip']['ip_name'] = model_name
    # add user modules
    xps_user_modules = {}
    link_info = model_info['link_info']
    for link in link_info:
        if link['link_type'] == 'xps_xps':
            gen_glue_module(link, file_dir=builddir+'/glues')
            module_name = link['link_type'] + '_' + link['src_blk_name'] + '_' \
                + 'out%d_'%(link['src_port_id'] - 1) + link['dst_blk_name'] + '_' \
                + 'in%d'%(link['dst_port_id'] - 1)
            xps_user_modules[module_name] = {}
            xps_user_modules[module_name]['clock'] = 'clk'
            # add ports
            xps_user_modules[module_name]['ports'] = []
            xps_user_modules[module_name]['ports'].append(link['src_port_name'])
            xps_user_modules[module_name]['ports'].append(link['dst_port_name'])
            # add sources
            xps_user_modules[module_name]['sources'] = []
            xps_user_modules[module_name]['sources'].append('%s/glues/%s.v'%(builddir, module_name))
    # add ip core info to xps_user_modules
    xps_user_modules['%s_ip'%(model_name)] = {}
    xps_user_modules['%s_ip'%(model_name)]['clock'] = 'clk'
    xps_user_modules['%s_ip'%(model_name)]['ports'] = []
    for link in link_info:
        if link['link_type'] == 'xps_dsp':
            xps_user_modules['%s_ip'%(model_name)]['ports'].append(link['src_port_name'])
        if link['link_type'] == 'dsp_xps':
            xps_user_modules['%s_ip'%(model_name)]['ports'].append(link['dst_port_name'])
    xps_user_modules['%s_ip'%(model_name)]['sources'] = []
    # generate jasper.per
    jasper_per = {}
    jasper_per['yellow_blocks'] = xps_blocks
    jasper_per['user_modules'] = xps_user_modules
    #jasper_per_str = json.dumps(jasper_per, indent=2)
    #print(jasper_per_str)
    dump_jasper(jasper_per, fn='%s/jasper.per'%(builddir)) 

    """
    Step 3: generate jasper.dsp, which contains the dsp blocks info and user module info 
    """
    # dsp blocks
    dsp_blocks = {}
    for block in model_info['dsp_blocks']:
        key = model_name + '/' + block['name']
        block = val_format_conv(block)
        dsp_blocks[key] = block
    # we need a special yellow block in jasper.dsp, whose tag is xps:xsg.
    # this block will be used for creating the vivado project for the DSP IP core generation.
    key = xsg_block['name']
    dsp_blocks[key] = xsg_block
    # generate dsp_user_module dict
    dsp_user_modules = {}
    for link in link_info:
        if link['link_type'] == 'dsp_dsp':
            gen_glue_module(link, file_dir=builddir+'/glues')
            module_name = link['link_type'] + '_' + link['src_blk_name'] + '_' \
                + 'out%d_'%(link['src_port_id'] - 1) + link['dst_blk_name'] + '_' \
                + 'in%d'%(link['dst_port_id'] - 1)
            dsp_user_modules[module_name] = {}
            dsp_user_modules[module_name]['clock'] = 'clk'
            # add ports
            dsp_user_modules[module_name]['ports'] = []
            dsp_user_modules[module_name]['ports'].append(link['src_port_name'])
            dsp_user_modules[module_name]['ports'].append(link['dst_port_name'])
            # add sources
            dsp_user_modules[module_name]['sources'] = []
            dsp_user_modules[module_name]['sources'].append('%s/glues/%s.v'%(builddir, module_name))
    # generate jasper.dsp
    jasper_dsp = {}
    jasper_dsp['dsp_blocks'] = dsp_blocks
    jasper_dsp['user_modules'] = dsp_user_modules
    #jasper_dsp_str = json.dumps(jasper_dsp, indent=2)
    #print(jasper_dsp_str)
    dump_jasper(jasper_dsp, fn='%s/jasper.dsp'%(builddir))

    """
    generate design_info.tab and git_info.tab
    """
    # generate design_info.tab
    gen_design_info(xps_blocks, model_name, fn='%s/design_info.tab'%(builddir))
    # generate git_info.tab
    gen_git_info(model_name, fn='%s/git_info.tab'%(builddir))
    
"""
# get the scilab path from the environment variable
scilab_library_path = os.getenv('MLIB_DEVEL_PATH')+ '/scilab_library'
# open the jasper.json file
with open('jasper.json') as f:
    blkinfo = json.load(f)
# after reading the file, remove it
# os.remove('jasper.json')
# open the block_info_template.json file
with open('%s/block_info_template.json'%(scilab_library_path)) as f:
    blkinfo_template = json.load(f)

# get the proj name
blkfn = blkinfo['project']['filename']
model_name = blkfn.split('/')[-1].split('.')[0]
filepath = blkfn.split('.')[0]

# create the build directory, and log file
os.system('mkdir -p %s/glues' % filepath)

# get the scilab blk, blk objs and link objs from the jaser.json file
scilab_blk_objs = []
blk_objs = []
link_info = blkinfo['link_info']
for k, v in blkinfo.items():
    if k.startswith('blk'):
        blk_objs.append(v)

# genenrate yellow blocks dict
xps_blocks = {}
for blk in blk_objs:
    tag = blk['tag']
    # check if the block in the blockinfo starts with xps
    if blkinfo_template[tag]['tag'].startswith('xps'):
        # populate yellow block
        key = model_name + '/' + blk['val'][0][0]
        xps_blocks[key] = write_blkinfo_to_dict(blk, blkinfo_template[tag])
        xps_blocks[key]['fullpath'] = key
# add sysgen ip
# acutally, this ip is generated by dspflow, when we use scilab as the frontend tool
xps_blocks['sysgen_ip'] = {}
xps_blocks['sysgen_ip']['name'] = 'sysgen_ip'
xps_blocks['sysgen_ip']['fullpath'] = '%s/dspproj/dspproj.srcs'%(model_name)
xps_blocks['sysgen_ip']['tag'] = 'xps:ip'
xps_blocks['sysgen_ip']['lib_path'] = '%s/dspproj/dspproj.srcs'%(filepath)
xps_blocks['sysgen_ip']['ip_name'] = model_name

# generate xps_user_module dict
xps_user_modules = {}
for link in link_info:
    if link['link_type'] == 'xps_xps':
        gen_glue_module(link, file_dir=filepath+'/glues')
        module_name = link['link_type'] + '_' + link['src_blk_name'] + '_' \
            + 'out%d_'%(link['src_port_id'] - 1) + link['dst_blk_name'] + '_' \
            + 'in%d'%(link['dst_port_id'] - 1)
        xps_user_modules[module_name] = {}
        xps_user_modules[module_name]['clock'] = 'clk'
        # add ports
        xps_user_modules[module_name]['ports'] = []
        xps_user_modules[module_name]['ports'].append(link['src_port_name'])
        xps_user_modules[module_name]['ports'].append(link['dst_port_name'])
        # add sources
        xps_user_modules[module_name]['sources'] = []
        xps_user_modules[module_name]['sources'].append('%s/glues/%s.v'%(filepath, module_name))  
# add ip core info to xps_user_modules
xps_user_modules['%s_ip'%(model_name)] = {}
xps_user_modules['%s_ip'%(model_name)]['clock'] = 'clk'
xps_user_modules['%s_ip'%(model_name)]['ports'] = []
for link in link_info:
    if link['link_type'] == 'xps_dsp':
        xps_user_modules['%s_ip'%(model_name)]['ports'].append(link['src_port_name'])
    if link['link_type'] == 'dsp_xps':
        xps_user_modules['%s_ip'%(model_name)]['ports'].append(link['dst_port_name'])
xps_user_modules['%s_ip'%(model_name)]['sources'] = []
# generate jasper.per
jasper_per = {}
jasper_per['yellow_blocks'] = xps_blocks
jasper_per['user_modules'] = xps_user_modules
#jasper_per_str = json.dumps(jasper_per, indent=2)
#print(jasper_per_str)
dump_jasper(jasper_per, fn='%s/jasper.per'%(filepath)) 

# now, we need to generate jasper.dsp, which contains the dsp block info
dsp_blocks = {}
for blk in blk_objs:
    tag = blk['tag']
    # check if the block in the blockinfo starts with dsp or xps:xsg
    # we need xps:xsg as it contains the platform info
    if blkinfo_template[tag]['tag'].startswith('dsp') or blkinfo_template[tag]['tag'] == 'xps:xsg':
        # populate dsp block
        key = model_name + '/' + blk['val'][0][0]
        dsp_blocks[key] = write_blkinfo_to_dict(blk, blkinfo_template[tag])
        dsp_blocks[key]['fullpath'] = key
# generate dsp_user_module dict
dsp_user_modules = {}
for link in link_info:
    if link['link_type'] == 'dsp_dsp':
        gen_glue_module(link, file_dir=filepath+'/glues')
        module_name = link['link_type'] + '_' + link['src_blk_name'] + '_' \
            + 'out%d_'%(link['src_port_id'] - 1) + link['dst_blk_name'] + '_' \
            + 'in%d'%(link['dst_port_id'] - 1)
        dsp_user_modules[module_name] = {}
        dsp_user_modules[module_name]['clock'] = 'clk'
        # add ports
        dsp_user_modules[module_name]['ports'] = []
        dsp_user_modules[module_name]['ports'].append(link['src_port_name'])
        dsp_user_modules[module_name]['ports'].append(link['dst_port_name'])
        # add sources
        dsp_user_modules[module_name]['sources'] = []
        dsp_user_modules[module_name]['sources'].append('%s/glues/%s.v'%(filepath, module_name))  
# generate jasper.dsp
jasper_dsp = {}
jasper_dsp['dsp_blocks'] = dsp_blocks
jasper_dsp['user_modules'] = dsp_user_modules
#jasper_dsp_str = json.dumps(jasper_dsp, indent=2)
#print(jasper_dsp_str)
dump_jasper(jasper_dsp, fn='%s/jasper.dsp'%(filepath))

# generate design_info.tab
gen_design_info(xps_blocks, model_name, fn='%s/design_info.tab'%(filepath))
# generate git_info.tab
gen_git_info(model_name, fn='%s/git_info.tab'%(filepath))
"""