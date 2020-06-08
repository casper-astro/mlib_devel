from pyparsing import alphanums, Word, nums, ParseException
import sys
pins = {}
vector_pin = Word(alphanums+'_') + '[' + Word(nums) + ']'
scalar_pin = Word(alphanums+'_')

try:
    fn = sys.argv[1]
except IndexError:
    raise Exception('Input a filename to translate')

with open(fn, 'r') as fh:
    for line in fh:
        if line.startswith('#'):
            continue
        elements = line.rstrip('\n').split(' ')
        if elements[0] != 'set_property':
            continue
        if elements[1] == 'IOSTANDARD':
            pinline = elements[-1].rstrip(']').rstrip('}').lstrip('{')
            iostd = elements[2]
            try:
                name, foo, idx, bar = vector_pin.parseString(pinline)
                is_vec = True
            except ParseException:
                name = scalar_pin.parseString(pinline)[0]
                is_vec = False
            except:
                raise Exception(pinline)
            if name not in list(sorted(pins.keys())):
                pins[name] = {}
            if 'IOSTD' not in list(sorted(pins[name].keys())):
                pins[name]['IOSTD'] = {}
            if is_vec:
                pins[name]['IOSTD'][int(idx)] = iostd
            else:
                pins[name]['IOSTD'] = iostd

        elif elements[1] == 'PACKAGE_PIN':
            pinline = elements[-1].rstrip(']').rstrip('}').lstrip('{')
            loc = elements[2]
            try:
                name, foo, idx, bar = vector_pin.parseString(pinline)
                is_vec = True
            except ParseException:
                name = scalar_pin.parseString(pinline)[0]
                is_vec = False
            except:
                raise Exception(pinline)
            if name not in list(sorted(pins.keys())):
                pins[name] = {}
            if 'LOC' not in list(sorted(pins[name].keys())):
                pins[name]['LOC'] = {}
            if is_vec:
                pins[name]['LOC'][int(idx)] = loc
            else:
                pins[name]['LOC'] = loc


print(pins)            

for key, val in pins.items():
    if not 'IOSTD' in list(sorted(val.keys())):
        print(('WARNING: key %s does not have IOSTD keyword'%key))
    if not 'LOC' in list(sorted(val.keys())):
        print(('WARNING key %s does not have LOC keyword'%key))

yaml_str = 'pins:'
for key, val in pins.items():
    yaml_str += '  %s:\n'%key
    if 'IOSTD' in list(sorted(val.keys())) and type(val['IOSTD']) is dict:
        for n, iostd in val['IOSTD'].items():
            if iostd != val['IOSTD'][0]:
                print(key)
                raise Exception('Vector signal %s has conflicting io standards'%key)

        yaml_str += '    iostd: %s\n'%val['IOSTD'][0]
    elif 'IOSTD' in list(sorted(val.keys())):
        yaml_str += '    iostd: %s\n'%val['IOSTD']

    if 'LOC' in list(sorted(val.keys())) and type(val['LOC']) is dict:
        yaml_str += '    loc:\n'
        for n, loc in val['LOC'].items():
            yaml_str += '      - %s\n'%loc
    elif 'LOC' in list(sorted(val.keys())):
            yaml_str += '    loc: %s\n'%val['LOC']

with open(fn+'.yaml', 'w') as fh:
    fh.write(yaml_str)

