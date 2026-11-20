import os, sys
import json
from argparse import ArgumentParser
from matplotlib import pyplot as plt
import numpy as np

def ParseData(d):
    x = d[0]/1000
    if len(d[1]) == 1:
        # Sometimes, the data is `bx`.
        # If so, we just set the value to 0.
        try:
            y = int(d[1], 2)
        except:
            y = 0

    else:
        # here, we assume the data is like this: 'b1100'
        # or 'bxx'
        try:
            # if the data is 'b1100', we decode it.
            y = int(d[1][1:], 2)
        except:
            # if the data is 'bxx', we set it to 0
            # TODO: what's the best way to deal with 'bxx'??
            y = 0
    return x, y

def ParseFile(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        raw_simdata = json.load(f)
    parsed_simdata = []
    for data in raw_simdata['simdata']:
        pdata = {}
        pdata['name'] = data['name']
        pdata['width'] = data['type']['width']
        pdata['data'] = {}
        pdata['data']['x'] = []
        pdata['data']['y'] = []
        for d in data['data']:
            x , y = ParseData(d)
            pdata['data']['x'].append(x)
            pdata['data']['y'].append(y)
        parsed_simdata.append(pdata)
    return parsed_simdata


def main():
    parser = ArgumentParser(prog=os.path.basename(__file__))
    parser.add_argument('-f', '--file', dest='file', type=str, 
                        default='casper_simulation.json',
                        help='The simulation data file path.')
    args = parser.parse_args()
    if not args.file:
        print('Simulation data doesn\'t exist.')
        sys.exit()
    simdata = ParseFile(args.file)
    n_sig = len(simdata)
    figs = np.zeros(n_sig, dtype=object)
    for i in range(n_sig):
        data = simdata[i]
        x = data['data']['x']
        y = data['data']['y']
        name = data['name']
        if name == 'user_clk':
            # We don't need to show clk
            continue
        figs[i] = plt.figure()
        subfig = figs[i].add_subplot()
        subfig.plot(x,y)
        subfig.set_xlabel('ns')
        subfig.set_title(name)
        subfig.grid(True)
    plt.show()

if __name__ == '__main__':
    main()