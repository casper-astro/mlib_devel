#!/bin/python
import csv
import os
from gen_rfdc_dt_paramlist import gen_rfdc_dt

if __name__=="__main__":

  tclpath = "/home/mcb/git/casper/mlib_devel/jasper_library/hsi_plnx"
  tclscript = os.path.join(tclpath, 'jasper_dts.tcl')

  prjpath = "/home/mcb/git/casper/mlib_devel/jasper_library/test_models/test_zcu111/"
  xsafile = os.path.join(prjpath, 'myproj/top.xsa')

  ofile = os.path.join(prjpath, 'jasper_rfdc.txt')
  dtsopath = os.path.join(prjpath, 'jasper-overlay-fragment')

  # call xsct to dump xsa data
  # as long as we sourced Vitis before starting `xsct` should be on the path, check anyway
  path = os.getenv('PATH')
  xsctexe = None
  for p in path.split(':'):
    if os.path.exists(os.path.join(p, 'xsct')):
      xsctexe = os.path.join(p, 'xsct')

  if xsctexe:
    e = os.system("{:s} {:s} {:s} {:s}".format(xsctexe, tclscript, xsafile, ofile))
    if e != 0:
      print("Failed to run xsct")
      os.exit(e)
  else:
    print("xsct was not found, was Vitis sourced?")

  # in the toolflow this would ideally be replaced by having direct access to the list of cores
  coreinfo = os.path.join(prjpath, "core_info.tab")
  fcsv = open(coreinfo, 'r')
  fields = ['core', 'rw', 'baseaddr', 'size']
  rdr = csv.DictReader(fcsv, fieldnames=fields, delimiter=" ", skipinitialspace=True)

  for row in rdr:
    if row['core'] == "RFDC":
      baseaddr = row['baseaddr']
      continue
  ############################################################################################

  # now dump the dts
  dt = gen_rfdc_dt(ofile, dtsopath, '0x{:s}'.format(baseaddr))
