import math
import string
amplitude = 100
inp = raw_input("Enter frequency in MHz")
if len(inp)<1: inp = "22"
freq= float(inp)
inp = raw_input("Output File Name")
if len(inp)<1: inp = ".\\fake_data.coe"
fout = open(inp, 'w')
fout.write("memory_initialization_radix=16;\n")
fout.write("memory_initialization_vector=\n")
values = []
i=0
while i < 8192:
    values.append(int(amplitude*(1.0+math.sin(2*3.1415926*i*freq/2000.0))))
    i=i+1

j=0
print values[0:15]
while j<1024:
    ascii_value=""
    i=7
    while i>=0:
        hex_byte=hex(values[8*j+i])
        #strip off the "0x" and fill to 2 characters
        s=string.zfill(hex_byte[2:],2)
        ascii_value=ascii_value+s    
        i=i-1
    fout.write(ascii_value)
    fout.write("\n")
    j=j+1
    if j==1024:fout.write(";\n")
    #print j
fout.close()