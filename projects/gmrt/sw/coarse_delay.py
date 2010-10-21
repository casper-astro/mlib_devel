#! /usr/bin/python
import numpy as n
#import pylab as p

########
ts = 50*10**6

######## ANTENNA CONFIGURATION ########
config = [
{'x':    6.92, 'y':   687.88, 'z':   -20.04, 't1':  -463.39,'t2':  -463.39},
{'x':   13.25, 'y':   326.44, 'z':   -40.35, 't1':   199.34,'t2':   200.61},
{'x':    0.00, 'y':     0.00, 'z':     0.00, 't1':   611.25,'t2':   611.25},
{'x':  -51.20, 'y':  -372.71, 'z':   133.59, 't1':   502.17,'t2':   498.86},
{'x':  -50.99, 'y':  -565.97, 'z':   123.43, 't1':    59.10,'t2':    65.34},
{'x':   79.13, 'y':    67.81, 'z':  -246.59, 't1':    43.24,'t2':    37.95},
{'x':   71.24, 'y':   -31.43, 'z':  -220.58, 't1':  -184.09,'t2':  -186.99},
{'x':  130.80, 'y':   280.68, 'z':  -400.33, 't1':  -440.64,'t2':  -441.75},
{'x':   48.59, 'y':    41.93, 'z':  -151.65, 't1':   276.39,'t2':   272.97},
{'x':  191.36, 'y':  -164.85, 'z':  -587.49, 't1':  -451.55,'t2':  -451.54},
{'x':  102.52, 'y':  -603.25, 'z':  -321.56, 't1':  -332.90,'t2':  -343.74},
{'x':  209.29, 'y':   174.86, 'z':  -635.54, 't1': -1027.06,'t2': -1027.75},
{'x':  368.70, 'y':  -639.48, 'z': -1117.92, 't1': -1348.76,'t2': -1349.22},
{'x':  207.38, 'y':  -473.68, 'z':  -628.63, 't1':  -407.14,'t2':  -407.75},
{'x': -348.27, 'y':  2814.54, 'z':   953.67, 't1': -3925.53,'t2': -3912.50},
{'x': -707.69, 'y':  4576.04, 'z':  1932.46, 't1': -7921.67,'t2': -7924.42},
{'x':-1037.76, 'y':  7780.58, 'z':  2903.29, 't1':-14150.77,'t2':-14148.86},
{'x':-1178.29, 'y': 10199.89, 'z':  3343.20, 't1':-20834.11,'t2':-20834.22},
{'x':-1572.38, 'y': 12073.31, 'z':  4543.13, 't1':-25554.23,'t2':-25557.17},
{'x':  942.96, 'y':   633.98, 'z': -2805.93, 't1': -5627.57,'t2': -5631.00},
{'x': 1452.89, 'y':  -367.16, 'z': -4279.16, 't1': -9442.33,'t2': -9447.27},
{'x': 2184.59, 'y':   333.18, 'z': -6404.96, 't1':-14188.89,'t2':-14189.58},
{'x': 3072.87, 'y':   947.89, 'z': -8979.50, 't1':-19026.79,'t2':-19027.10},
{'x': 4592.75, 'y':  -368.93, 'z':-13382.48, 't1':-28509.69,'t2':-28509.38},
{'x': -201.29, 'y': -1591.95, 'z':   591.32, 't1': -1430.23,'t2': -1429.27},
{'x': -482.34, 'y': -3099.44, 'z':  1419.39, 't1': -4733.34,'t2': -4733.23},
{'x': -991.46, 'y': -5200.01, 'z':  2899.11, 't1': -9819.46,'t2': -9821.05},
{'x':-1733.91, 'y': -7039.06, 'z':  5067.53, 't1':-15516.26,'t2':-15521.71},
{'x':-2705.38, 'y': -8103.23, 'z':  7817.14, 't1':-21828.75,'t2':-21831.43},
{'x':-3101.12, 'y':-11245.81, 'z':  8916.26, 't1':-29842.14,'t2':-29838.91},
{'x':-3102.11, 'y':-11245.60, 'z':  8916.26, 't1':-29671.71,'t2':-29668.49},
{'x':-3102.11, 'y':-11245.60, 'z':  8916.26, 't1':-29671.71,'t2':-29668.49}
]
#######################################
# Re normalize the delay times, relative to the fastest signal
fastest_t1 = 0
fastest_t2 = 0
for ant in config:
    if ant['t1'] > fastest_t1:
        fastest_t1 = ant['t1']
    if ant['t2'] > fastest_t2:
        fastest_t2 = ant['t2']

for ant in range(len(config)):
    config[ant]['t1'] -= fastest_t1
    config[ant]['t2'] -= fastest_t2

# calculate maximum pairwise delays
# This is the delay where the source lies
# on a line joining the two antennas
c = 3*10**8
max_delay = n.zeros((len(config),len(config)))
for i in range(len(config)):
    for j in range(len(config)):
        max_delay[i,j] = n.max([n.abs(config[i]['x'] - config[j]['x']),
                                n.abs(config[i]['y'] - config[j]['y']),
                                n.abs(config[i]['z'] - config[j]['z'])])/c
print 'Maximum physical delay between ant 0 and other based on ant pos.'
print max_delay[0]*10**9

max_delay_actual = n.zeros((len(config),len(config)))
for i in range(len(config)):
    for j in range(len(config)):
        max_delay_actual[i,j] = max_delay[i,j]+n.abs(10**-9*(config[i]['t1']-config[j]['t1']))

print 'Maximum delay between ant 0 and other based on ant pos and cable delays.'
print max_delay_actual[0]*10**9

buffer_req = n.zeros(len(config))
for i in range(len(config)):
    buffer_req[i] = n.max(max_delay_actual[i])

#print 'buffer required in ns'
#print buffer_req*10**9
print 'Delay in clock cycles'
print (buffer_req)*ts
