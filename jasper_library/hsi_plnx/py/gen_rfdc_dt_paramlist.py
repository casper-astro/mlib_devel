import struct
import os

# rfdc driver xsa configuration field names
import rfdc_dt_info

"""

  Example device tree declaration for the Xilinx RF-Data Converter, the Xilinx rfdc
  linux software driver uses the device tree information to initialize and start
  the driver

  usp_rf_data_converter_0: usp_rf_data_converter@b0000000 {
    clock-names = "adc2_clk_p", "adc2_clk_n", "s_axi_aclk", "m0_axis_aclk", "m1_axis_aclk", "m2_axis_aclk", "m3_axis_aclk";
    clocks = <&misc_clk_0>, <&misc_clk_0>, <&zynqmp_clk 71>, <&misc_clk_0>, <&misc_clk_0>, <&misc_clk_0>, <&misc_clk_0>;
    compatible = "xlnx,usp-rf-data-converter-2.4";
    num-insts = <0x1>;
    param-list = [ 00 00 00 00 00 00 00 b0 00 00 00 00 ... 00 00 00 03 00 00 00];
    reg = <0x0 0xb0000000 0x0 0x40000>;
};

  param-list:
    A little-endian byte string of all configuration parameters matching the
    `XRFdc_Config` struct in the xilinx c rfdc driver
    (github.com/xilinx/embeddedsw/XilinxProcessorIPLib/drivers/rfdc/src/xrfdc.h).
    Instead of always looking at each of the fields and structs that make up the
    `XRFdc_Config` struct the list of parameters that make this up are listed in the
    xilinx device tree genertor tcl script
    (github.com/xilinx/device-tree-xlnx/rfdc/data/rfdc.tcl). That list of parameters
    are stored here and used for parsing as the `rfdc_param_keys` list. It is
    possible that the `XRFdc_Config` struct change as the driver is updated.

"""


def gen_rfdc_dt(fpath, opath, baseaddr):
  """
    generates device tree node for xilinx rfdc, dumps the device tree
    description as a dtsi and compiles using `dtc` to a dtbo for application as
    an overlay

    fpath, str: file name containing dumped information from IP core
    opath, str: output file name for the dts
    baseaddr, str: string of hex literals of the memory mapped address for nodes unit-address

    return:
      dt, dict: device tree node dictionary representation, if this ends up being to the tools
                a more useful implementation would manage a device tree implementation adding
                this (and other nodes) as part of a managed tree
                
  """
  # dictionary containing configuration parsed from dumped tcl
  rfdc_params = {}
  # dictionary representing the property list and values for the rfdc device tree node
  dt = {}

  # static properties from the rfdc device tree binding 
  dt['compatible'] = '"xlnx,usp-rf-data-converter-2.4";'
  dt['num-insts'] = '<0x1>;'

  # baseaddr and size of rfdc address space to be used to complete the node unit-address
  dt['baseaddr'] = baseaddr
  dt['range'] = '0x40000'

  # hard code device id to be zero, only one rfdc allowed
  rfdc_params['DEVICE_ID'] = '0'

  dtreg_fmt = '<{:s} {:s} {:s} {:s}>;'
  dt['reg'] = dtreg_fmt.format('0x0', dt['baseaddr'], '0x0', dt['range'])

  if not os.path.exists(fpath):
    raise FileNotFoundError
  fd = open(fpath, 'r')

  # skip first line, just column headers
  s = fd.readline()

  # parsing loop builind the `rfdc_params` dict
  for s in fd.readlines():
    s = s.split()

    k = s[0]
    if "CONFIG." in k:
      v = s[3]
      rfdc_params[k[7:]] = v # strip "CONFIG." and add value
    elif "DT.CLOCKS" in k:
      clks = s[1:]
      clkstr = (len(clks)*'"{:s}"').format(*clks)
      clkstr = clkstr.replace('""', '", "')
      dt['clock-names'] = clkstr + ";"

  fd.close()

  # build `param-list` property, see file header for information on property format
  rfdc_param_keys = rfdc_dt_info.rfdc_keys_git
  param_list = ""

  for k in rfdc_param_keys:
    fmt = ""

    if k == "C_BASEADDR":
      v = rfdc_params[k]
      dt['baseaddr'] = v.lower()
      # low address in little-endian
      param_list += " {:2s} {:2s} {:2s} {:2s}".format(v[8:10], v[6:8], v[4:6], v[2:4])#format(v[2:4], v[4:6], v[6:8], v[8:10])
      # high address hard coded to 0x00000000
      param_list += " 00 00 00 00"

    else:
      if ('_Sampling_Rate' in k) or ('_Refclk_Freq' in k) or ('_Fabric_Freq' in k) or ('_Fs_Max' in k):
        fmt = '<d' # little-endian double
        t = float
      else:
        fmt = '<i' # little-endian int
        t = int

      if k in rfdc_params.keys():
        v = rfdc_params[k]
        if v == 'true':
          v = 1
        elif v == 'false':
          v = 0
      else:
        v = 0

      # make byte conversion
      p = struct.pack(fmt, t(v)) # struct.pack('d', 250.0)
      to_add = " {:s}".format(p.hex(' ', 1))
      if fmt == '<d':
        # NOTE: the {:8.3f} prints out to 3 dec but the value passed to jasper should contain 5
        # as defined by the rfdc structure in the yellow block
        print("{:28s} {:s} {:8.3f} {:s}".format(k, fmt, t(v), to_add))
      elif fmt == '<i':
        print("{:28s} {:s} {:8d} {:s}".format(k, fmt, t(v), to_add))
      param_list += " {:s}".format(p.hex(' ', 1))

  param_list = param_list.lower()

  dt['param-list'] = '[{:s}];'.format(param_list)
  
  # assemble dt node
  dtstr = []
  dtstr.append('/* AUTOMATICALLY GENERATED */\n\n')
  dtstr.append('/dts-v1/;')
  dtstr.append('/plugin/;')
  dtstr.append('/ {')
  dtstr.append('    fragment@0 {')
  dtstr.append('      target = <&amba>;')
  dtstr.append('      overlay0: __overlay__ {')
  dtstr.append('        #address-cells = <2>;')
  dtstr.append('        #size-cells = <2>;')
  dtstr.append('        usp_rf_data_converter_0: usp_rf_data_converter@{:s} {{'.format(dt['baseaddr'][2:]))
  dtstr.append('         clock-names = {:s}'.format(dt['clock-names']))
  dtstr.append('         compatible = {:s}'.format(dt['compatible']))
  dtstr.append('         num-insts = {:s}'.format(dt['num-insts']))
  dtstr.append('         param-list = {:s}'.format(dt['param-list']))
  dtstr.append('         reg = {:s}'.format(dt['reg']))
  dtstr.append('        };')
  dtstr.append('      };')
  dtstr.append('    };')
  dtstr.append('};')

  # write dtsi node to file
  dtnode = '\n'.join(dtstr)
  fd = open(opath+'.dtsi', 'w+')
  fd.write(dtnode)
  fd.close()

  # write dtbo, could instead pipe to stdin if wanted
  # as long as we sourced Vitis before starting `dtc` should be on the path, check anyway
  path = os.getenv('PATH')
  dtcexe = None
  for p in path.split(':'):
    if os.path.exists(os.path.join(p, 'dtc')):
      dtcexe = os.path.join(p, 'dtc')

  if dtcexe:
    e = os.system("{:s} -I dts {:s} -O dtb -b 0 -@ -o {:s}".format(dtcexe, opath+'.dtsi', opath+'.dtbo'))
    if e != 0:
      print("Failed to write dtb")
  else:
    print("dtc executable not found, cannot compile dtbo")

  return dt


if __name__=="__main__":

  gold_param_list = """00 00 00 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00 02 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00 9a 99 99 99 99 99 19 40 00 00 00 00 00 00 b9 40 00 00 00 00 00 00 00 00 0a 00 00 00 02 00 00 00 01 00 00 00 00 00 00
     00 00 00 00 00 00 00 24 40 04 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00
     00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00
     00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00
     00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 9a 99 99 99 99 99 19
     40 00 00 00 00 00 00 b9 40 00 00 00 00 00 00 00 00 0a 00 00 00 02 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 24 40 04 00 00 00 00 00
     00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00
     00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00
     00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 9a 99 99 99 99 99 19 40 00 00 00 00 00 00 b9 40 00 00 00 00 00 00
     00 00 0a 00 00 00 02 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 24 40 04 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00
     00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00
     00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00
     00 00 00 00 00 00 00 00 00 00 9a 99 99 99 99 99 19 40 00 00 00 00 00 00 b9 40 00 00 00 00 00 00 00 00 0a 00 00 00 02 00 00 00 01 00 00 00 00
     00 00 00 00 00 00 00 00 00 24 40 04 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00
     00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00
     00 00 00 00 00 00 03 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 00
     00 00 40 00 00 00 00 00 40 6f 40 00 00 00 00 00 40 6f 40 30 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 04 40 04 00 00 00
     01 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 01 00 00 00 08 00 00 00 00 00 00
     00 01 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00
     00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 40 6f 40 00 00 00 00 00
     40 6f 40 30 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 04 40 04 00 00 00 01 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00
     00 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 01 00 00 00 08 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 08 00 00 00 00 00 00
     00 00 00 00 00 03 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00
     00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 40 6f 40 00 00 00 00 00 40 6f 40 30 00 00 00 06 00 00 00 01 00 00 00 00
     00 00 00 00 00 00 00 00 00 04 40 04 00 00 00 01 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00
     00 00 00 00 01 00 00 00 08 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 08 00 00
     00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00
     00 40 00 00 00 00 00 40 6f 40 00 00 00 00 00 40 6f 40 30 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 04 40 04 00 00 00 01
     00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 01 00 00 00 08 00 00 00 00 00 00 00
     01 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00
     00 08 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00"""

  fpath = 'dump_rfdc_alpaca_snapshots.txt'
  opath = 'alpaca-rfdc-overlay-fragment.dtsi'
  dt = gen_rfdc_dt(fpath, opath, '0xa0040000')

  # compare
  g = gold_param_list.split()
  p = dt['param_list'].split()

  k = 0
  for (i,j) in zip(g, p):
    if (i != j):
      print("ERROR", k, "g[k]=", i, "p[k]=",j)
    k+=1

  print("SUCCESS byte strings matched")

