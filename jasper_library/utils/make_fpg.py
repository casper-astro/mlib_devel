#!/usr/bin/ python

__author__ = 'tyronevb'
__organisation__ = 'sarao'
__date__ = 'october 2019'

import os
import sys
import subprocess
import time
import argparse
import struct

# add parent dir to sys path to allow importing of module in parent directory
sys.path.insert(1, os.path.join(sys.path[0], '..'))

import toolflow as tf


class NoDirectorySpecified(RuntimeError):
    pass


class InvalidDirectory(RuntimeError):
    pass


class NoBitstream(RuntimeError):
    pass


def make_bin(input_bit_file, output_bin_file):
    """
    Make a .bin file and return the name.
    :param: input_bit_file: path to input bit file
    :param: output_bin_file: path to output bin file
    :return: nothing
    """
    # apparently .fpg file uses the .bit file generated from implementation
    # this function will convert the .bit file portion extracted from
    # the .fpg file and convert it to .bin format with required endianness
    # also strips away .bit file header

    fptr = open(input_bit_file, 'rb')  # read from
    data = fptr.read()
    data = data.rstrip()  # get rid of pesky EOF chars
    # bin file header identifier - '\xff' * 32
    header_end_index = data.find('\xff' * 32)
    data = data[header_end_index:]
    fptr.close()

    # .bit file already contains packed data: ABCD is a 2-byte hex value
    # (size of this value is 2-bytes) .bin file requires this packing of
    # data, but has a different bit ordering within each nibble
    # i.e. given 1122 in .bit, require 8844 in .bin
    # i.e. given 09DC in .bit, require B039 in .bin
    # this equates to reversing the bits in each byte in the file

    # for unpacking data from bit file and repacking
    data_format = struct.Struct('!B')
    bitstream = ''
    for bytectr in range(len(data)):
        # reverse bits each byte
        byte = data_format.unpack(data[bytectr])[0]
        bits = '{:08b}'.format(byte)
        bits_flipped = bits[::-1]
        byte_to_pack = int(bits_flipped, 2)
        bitstream += data_format.pack(byte_to_pack)

    bin_file = open(output_bin_file, 'wb')
    bin_file.write(bitstream)
    bin_file.close()


if __name__ == '__main__':
    compile_time = time.localtime()
    
    parser = argparse.ArgumentParser(description="Make fpg file from a CASPER Toolflow compile directory "
                                                 "where the Vivado Backend has already been run and generated "
                                                 "the bitstream")
    parser.add_argument("-d", "--compile_dir", dest="compile_dir", type=str,
                        default=None, help="Absolute path to compile directory, where the project files and generated "
                        "bitstreams are located")
    parser.add_argument("-f", "--fpg_name", dest="fpg", type=str, default=None,
                        help="Name (excluding extension) for the output fpg file. Timestamp and extension will be "
                             "appended to this. Defaults to the project name from the compile directory name.")
    parser.add_argument("-i", "--implementation", dest="impl", type=str, default=['1'], nargs='*',
                        help="Which implementation run should be used? Can pass multiple values and an fpg file will "
                             "be generated for each. Defaults to 'impl_1'")

    args = parser.parse_args()

    print('\nGenerating fpg file . . .')

    # create timestamp for generation
    timestamp = '_%d-%02d-%02d_%02d%02d.fpg' % (
        compile_time.tm_year, compile_time.tm_mon, compile_time.tm_mday,
        compile_time.tm_hour, compile_time.tm_min)

    try:
        # check for given compile directory
        if args.compile_dir:

            # force directory string to end in /
            compile_dir = os.path.join(args.compile_dir, '')

            # check if specified directory exists and is a valid compile directory
            if os.path.isdir(compile_dir + 'myproj/myproj.runs'):

                # dict for bitstreams
                bitstreams = {}

                # check which implementations to use
                for i in args.impl:

                    # create path to bitstream
                    bitstream = compile_dir + 'myproj/myproj.runs/impl_' + i + '/top.bit'

                    # check if bitstream exists
                    if not os.path.isfile(bitstream):
                        print("WARNING: Compile implementation directory '{}' does not contain a generated "
                              "bitstream".format(compile_dir + 'myproj/myproj.runs/impl_' + i))
                    else:
                        # append valid bitstream to dict of bitstreams
                        bitstreams['bitstream_' + i] = bitstream

            else:
                raise InvalidDirectory("Specified directory '{}' is not a valid compile "
                                       "directory.".format(compile_dir))
        else:
            raise NoDirectorySpecified("Must specify a compile directory.")

        # check if we have any valid bitstreams
        if not bitstreams:
            raise NoBitstream("No valid bitreams found in the specified directories")
        else:
            # check for given fpg output filename
            outputs = []
            if args.fpg:
                base_name = args.fpg
            else:
                base_name = compile_dir.split('/')[-2]

            for bitstream_idx, bitstream_path in bitstreams.items():
                if len(bitstreams) == 1:
                    impl_idx = ''
                else:
                    impl_idx = '_impl_' + bitstream_idx[-1]

                # convert the .bit file to a .bin file using Python function

                bin_file_path = bitstream_path[:-7] + 'top_python.bin'

                make_bin(input_bit_file=bitstream_path, output_bin_file=bin_file_path)

                # set the name of the output fpg file
                fpg_name = base_name + impl_idx + timestamp

                outputs.append(fpg_name)

                # generate the fpg file using the toolflow module
                tf_backend = tf.ToolflowBackend(plat=None, compile_dir=compile_dir)
                tf_backend.mkfpg(bin_file_path, fpg_name)

        print('\nSuccess! fpg generation completed. fpg files available in {} '
              '\nGenerated files: {}'.format(compile_dir+'outputs/', outputs))

    except Exception as err:
        print("ERROR: {}".format(err))
# end
