import csv
import os
import argparse
from gen_rfdc_dt_paramlist import gen_rfdc_dt

if __name__=="__main__":

  parser = argparse.ArgumentParser()

  # TODO change defaults for os.getenv('MLIB_DEVEL_PATH')
  parser.add_argument('-t', '--tclxsctpath', dest="tclpath", type=str,
    default="/home/mcb/git/casper/mlib_devel/jasper_library/hsi_plnx",
    help="path to toolflow xsct tcl scripts")

  parser.add_argument('-p', '--prjpath', dest="prjpath", type=str,
    default="/home/mcb/git/casper/mlib_devel/jasper_library/test_models/test_zcu111/",
    help="path to project")

  parser.add_argument('-o', '--outfile', dest="ofile", type=str,
    default="jasper_rfdc.txt", help="intermediate text dump representation of platform IP config")

  parser.add_argument('-d', '--dtpath', dest="dtsopath", type=str,
    default="jasper-overlay-fragment", help="name of output device tree products (.dtsi/.dtbo)")

  opts = parser.parse_args()

  # build paths
  tclscript = os.path.join(opts.tclpath, 'jasper_dts.tcl')
  xsafile = os.path.join(opts.prjpath, 'myproj/top.xsa')
  dtsopath = os.path.join(opts.prjpath, opts.dtsopath)

  # call xsct to dump xsa data
  # as long as we sourced Vitis before starting `xsct` should be on the path, check anyway
  path = os.getenv('PATH')
  xsctexe = None
  for p in path.split(':'):
    if os.path.exists(os.path.join(p, 'xsct')):
      xsctexe = os.path.join(p, 'xsct')

  if xsctexe:
    e = os.system("{:s} {:s} {:s} {:s}".format(xsctexe, tclscript, xsafile, opts.ofile))
    if e != 0:
      print("Failed to run xsct")
      os.exit(e)
  else:
    print("xsct was not found, was Vitis sourced?")

  coreinfo = os.path.join(opts.prjpath, "core_info.tab")
  fcsv = open(coreinfo, 'r')
  fields = ['core', 'rw', 'baseaddr', 'size']
  rdr = csv.DictReader(fcsv, fieldnames=fields, delimiter=" ", skipinitialspace=True)

  for row in rdr:
    if row['core'] == "rfdc":
      baseaddr = row['baseaddr']
      continue

  # now dump the dts
  dt = gen_rfdc_dt(opts.ofile, dtsopath, '0x{:s}'.format(baseaddr), compile_dtbo=True)
