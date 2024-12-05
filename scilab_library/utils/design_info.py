
from datetime import datetime

# TODO: we may not need this list, and just write all the tags in the design_info.tab??
tag_list = ['xps:xsg', 'xps:sw_reg', 'xps:rfdc', 'xps:bram']

def gen_design_info(yellow_blocks, proj_name,  fn='design_info.tab'):
    used_tags = []
    design_info = []
    for k,v in yellow_blocks.items():
        if v['tag'] in tag_list:
            # add the tag to used_tags
            if v['tag'] in used_tags:
                pass
            else:
                used_tags.append(v['tag'])
            name = v['name']
            tag = v['tag']
            for sk, sv in v.items():
                # we don't need to wirte fullpath, name and tag
                if sk == 'fullpath' or sk == 'name' or sk == 'tag':
                    continue
                else:
                    if v['tag'] == 'xps:bram' and sk == 'init_vals':
                        # this is a very special case
                        # TODO: we have to deal with this case in a better way
                        design_info.append('%s %s %s [0:2^%d-1]\n'%(name, tag, sk, v['addr_width']))
                    else:
                        if type(sv) == str:
                            design_info.append('%s %s %s %s\n'%(name, tag, sk, sv.replace(' ', '\_')))
                        else:
                            design_info.append('%s %s %s %d\n'%(name, tag, sk, sv))
    # not sure where the following data is from
    # TODO: this piece of code has to be improved
    d = '77777 77777 tags ' + used_tags[0]
    for t in used_tags[1:]:
        d = d + ',' + t
    d = d + '\n'
    design_info.append(d)
    d = '77777 77777 system %s\n'%(proj_name)
    design_info.append(d)
    t = datetime.now()
    d = '77777 77777 builddate '+ t.strftime('%d-%b-%Y\_%H:%M:%S')
    design_info.append(d)
    with open(fn, 'w') as f:
        f.writelines(design_info)
