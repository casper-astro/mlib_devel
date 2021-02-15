#!/usr/bin/env python

"""
Read incoming packets from the Tutorial 2 transmitter and check them for
consistency.
"""

import struct
import socket
import argparse

import skarab_tut2


def unpack_word256(word):
    """
    
    :param word: 
    :return: 
    """
    mark = word[12]
    walkm = (word[13] << 32) | (word[14] << 16) | (word[15] << 0)
    pktcntm = (word[8] << 16) | (word[9] << 0)
    rampm = (word[10] << 16) | (word[11] << 0)
    walkl = (word[4] << 48) | (word[5] << 32) | (word[6] << 16) | \
        (word[7] << 0)
    pktcntl = (word[0] << 16) | (word[1] << 0)
    rampl = (word[2] << 16) | (word[3] << 0)
    return mark, walkm, walkl, pktcntm, pktcntl, rampm, rampl


parser = argparse.ArgumentParser(
    description='SKARAB Tutorial 2 - analyse packets from TX SKARAB',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('--port', dest='port', type=int, action='store',
                    default=7779,
                    help='Port to which TX FPGA is sending data.')
parser.add_argument('--num', dest='numpkts', type=int, action='store',
                    default=100,
                    help='How many packets should we process?')
parser.add_argument('-q', '--quiet', dest='quiet', action='store_true',
                    default=False, help='Only print error summary.')
parser.add_argument('--loglevel', dest='log_level', action='store',
                    default='INFO', help='log level to use, default None, '
                                         'options INFO, DEBUG, ERROR')
args = parser.parse_args()

# open a RX socket and bind to the port
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.settimeout(1)
sock.bind(('', args.port))
# receive a bunch of packets and save them in a list
pkts = []
try:
    for ctr in range(args.numpkts):
        pkts.append(sock.recvfrom(10000))
except socket.timeout:
    raise RuntimeError('ERROR: socket timed out waiting for '
                       'packets from TX FPGA.')
finally:
    sock.close()

# analyse the data we have received
fpkts = []
for pkt in pkts:
    d = struct.unpack('>%iH' % (len(pkt[0]) / 2), pkt[0])
    pkt_dict = {'marker': [], 'walking0': [], 'walking1': [],
                'ctr0': [], 'ctr1': [], 'ramp0': [], 'ramp1': [],
                'eof': [], 'valid_raw': []}
    for ctr in range(0, len(d), 16):
        try:
            marker, walking_m, walking_l, pkt_count_m, pkt_count_l, \
                ramp_m, ramp_l = unpack_word256(d[ctr:ctr+16])
            pkt_dict['marker'].append(marker)
            pkt_dict['walking0'].append(walking_l)
            pkt_dict['walking1'].append(walking_m)
            pkt_dict['ctr0'].append(pkt_count_l)
            pkt_dict['ctr1'].append(pkt_count_m)
            pkt_dict['ramp0'].append(ramp_l)
            pkt_dict['ramp1'].append(ramp_m)
        except IndexError:
            errors['pkt_format'] += 1
    pkt_dict['eof'] = [0] * len(pkt_dict['marker'])
    pkt_dict['eof'][-1] = 1
    pkt_dict['valid_raw'] = [15] * len(pkt_dict['marker'])
    fpkts.append(pkt_dict)

skarab_tut2.process_tut2_data(fpkts, -1 if not args.quiet else 0)

# end
