#!/usr/bin/env python

import logging
import time
import os

import casperfpga


def snapdata2packets(snapdata):
    """
    Convert the given snap data to packet dictionaries 
    :param snapdata: 
    :return: 
    """
    pkts = []
    pkt_start = 0
    for ctr in range(len(snapdata['eof'])):
        if snapdata['eof'][ctr] == 1:
            pktval = {k: v[pkt_start:ctr+1] for k, v in snapdata.items()}
            pkts.append(pktval)
            pkt_start = ctr + 1
    return pkts


def process_tut2_data(packets, printlimit=-1):
    """
    Given a dictionary of tut2 data, analyse it for errors
    :param packets: packets, in the form of individual dictionaries
    :param printlimit: number of packets to print, -1 means all, 0 means none
    :return: 
    """
    printed = 0
    errors = {
        'pkt_count_match': 0, 'pkt_count_progression': 0,
        'pkt_count_internal': 0, 'ramp_match': 0, 'ramp_progression': 0,
        'ramp_start': 0, 'walk_match': 0, 'walk_progression': 0,
        'marker': 0, 'pkt_format': 0,
    }
    last_pkt_count = packets[0]['ctr0'][0] - 1
    last_walk = packets[0]['walking0'][0] / 2
    if last_walk == 1:
        last_walk = 2 ** 63
    for pktctr, pkt in enumerate(packets):
        this_pkt_cnt = pkt['ctr0'][0]
        pktlen = len(pkt['eof'])
        pktstr = '------------------------- pkt_%03i ' \
                 '------------------------- ' % pktctr
        if this_pkt_cnt != last_pkt_count + 1:
            pktstr += 'PKTCNT_ERROR '
            errors['pkt_count_progression'] += 1
        if pkt['ramp0'][0] != 1:
            pktstr += 'RAMP_START_ERROR '
            errors['ramp_start'] += 1
        pktstr += '\n'
        pktstr += '%5s%5s%25s%10s%10s\n' % ('ctr', 'mark', 'walking_one',
                                            'pkt_ctr', 'ramp')
        last_ramp = pkt['ramp0'][0] - 1
        for ctr in range(pktlen):
            if 'marker' in pkt:
                marker = pkt['marker'][ctr]
            else:
                marker = 7777
            pktstr += '%5i%5i%25i%10i%10i ' % (
                ctr, marker, pkt['walking0'][ctr],
                pkt['ctr0'][ctr], pkt['ramp0'][ctr])
            # do all the error checks
            if marker != 7777:
                pktstr += 'MARKER_ERROR '
                errors['marker'] += 1
            if pkt['walking0'][ctr] != last_walk * 2:
                if (pkt['walking0'][ctr] == 2) and (last_walk == 2 ** 63):
                    pass
                else:
                    pktstr += 'WALK_ERROR '
                    errors['walk_progression'] += 1
            last_walk = pkt['walking0'][ctr]
            if pkt['ramp0'][ctr] != last_ramp + 1:
                if (pkt['ramp0'][ctr] == 1) and (last_ramp == pktlen):
                    pass
                else:
                    pktstr += 'RAMP_ERROR '
                    errors['ramp_progression'] += 1
            last_ramp = pkt['ramp0'][ctr]
            if ctr == pktlen-1:
                if pkt['eof'][ctr] != 1:
                    pktstr += 'EOF_ERROR '
            if pkt['ctr0'][ctr] != this_pkt_cnt:
                pktstr += 'PKTCNT_INT_ERROR '
                errors['pkt_count_internal'] += 1
            if 'ctr1' in pkt:
                if pkt['ctr0'][ctr] != pkt['ctr1'][ctr]:
                    pktstr += 'PKTCNT_MATCH_ERROR '
                    errors['pkt_count_match'] += 1
            if 'ramp1' in pkt:
                if pkt['ramp0'][ctr] != pkt['ramp1'][ctr]:
                    pktstr += 'RAMP_MATCH_ERROR '
                    errors['ramp_match'] += 1
            if 'walking1' in pkt:
                walk0 = pkt['walking0'][ctr] & (2 ** 48 - 1)
                walk1 = pkt['walking1'][ctr] & (2 ** 48 - 1)
                if walk0 != walk1:
                    pktstr += 'WALK_MATCH_ERROR '
                    errors['walk_match'] += 1
            if pkt['eof'][ctr] == 1:
                pktstr += 'EOF '
            if (printlimit == -1) or (printed < printlimit):
                print(pktstr)
                pktstr = ''
        printed += 1
        last_pkt_count = this_pkt_cnt
    print('-------------------------\nERRORS:')
    for key, val in errors.items():
        print('\t%s: %i' % (key, val))
    return errors


def read_rx_regs():
    """
    Read all the debug registers on the RX FPGA
    :return: 
    """
    return {
        'err_walk': f.registers.err_walk.read()['data']['reg'],
        'err_ramp': f.registers.err_ramp.read()['data']['reg'],
        'err_pktctr': f.registers.err_pkt_ctr.read()['data']['reg'],
        'err_marker': f.registers.err_marker.read()['data']['reg'],
        'err_valid_raw': f.registers.err_valid_raw.read()['data']['reg'],
        'err_pktctr_step': f.registers.err_pkt_ctr_step.read()['data']['reg'],
        'rx_badframe': f.registers.rx_badframe.read()['data']['reg'],
        'rx_overrun': f.registers.rx_overrun.read()['data']['reg'],
        'rx_valid': f.registers.rx_valid.read()['data']['reg'],
        'rx_eof': f.registers.rx_eof.read()['data']['reg'],
    }


def check_rx_pkt_counters():
    """
    Read the snapshot on the RX boards that collects packet counters. Check
    that they increase monotonically.
    :return: the numbers of errors
    """
    d = f.snapshots.pkt_ctrs_ss.read()['data']
    last_ctr = d['pkt_ctr'][0] - 1
    errors = 0
    for ctr in d['pkt_ctr']:
        if ctr != last_ctr + 1:
            errors += 1
        last_ctr = ctr
    print '%i errors in %i packets (%i->%i).' % (
        errors, len(d['pkt_ctr']), d['pkt_ctr'][0], d['pkt_ctr'][-1])
    return errors


def check_rx_pkt_counters2():
    """
    Read the snapshot on the RX boards that collects packet counters. Check
    that they increase monotonically.
    :return: the numbers of errors
    """
    d = f.snapshots.pkt_ctrs_compare_ss.read()['data']
    errors = 0
    for ctr in range(len(d['pkt_ctr'])):
        now = d['pkt_ctr'][ctr]
        old = d['pkt_ctr_old'][ctr]
        if now != old + 1:
            errors += 1
    print '%i errors in %i packets (%i->%i).' % (
        errors, len(d['pkt_ctr']), d['pkt_ctr'][0], d['pkt_ctr'][-1])
    return errors


def print_txsnap(packets_to_print=-1):
    """
    
    :param packets_to_print: 
    :return: 
    """
    f.registers.control.write(snap_arm=0)
    f.snapshots.txsnap0_ss.arm()
    f.snapshots.txsnap1_ss.arm()
    f.registers.control.write(snap_arm=1)
    d = f.snapshots.txsnap0_ss.read(arm=False)['data']
    d1 = f.snapshots.txsnap1_ss.read(arm=False)['data']
    d.update(d1)
    pkts = snapdata2packets(d)
    errors = process_tut2_data(pkts, printlimit=packets_to_print)


def print_rxsnap(packets_to_print=-1):
    """
    
    :param packets_to_print: 
    :return: 
    """
    import IPython
    IPython.embed()
    f.registers.control1.write(snap_arm=0)
    f.snapshots.d0_ss.arm()
    f.snapshots.d1_ss.arm()
    f.snapshots.d2_ss.arm()
    f.registers.control1.write(snap_arm=1)
    time.sleep(1)
    d0 = f.snapshots.d0_ss.read(arm=False)['data']
    d1 = f.snapshots.d1_ss.read(arm=False)['data']
    d2 = f.snapshots.d2_ss.read(arm=False)['data']
    d0.update(d1)
    d0.update(d2)
    pkts = snapdata2packets(d0)
    errors = process_tut2_data(pkts, printlimit=packets_to_print)


if __name__ == '__main__':

    import argparse

    def_rxhost = '' if 'TUT2_RXHOST' not in os.environ else \
        os.environ['TUT2_RXHOST']
    def_txhost = '' if 'TUT2_TXHOST' not in os.environ else \
        os.environ['TUT2_TXHOST']
    def_fpg = '' if 'TUT2_FPG' not in os.environ else os.environ[
        'TUT2_FPG']

    parser = argparse.ArgumentParser(
        description='Script and classes for SKARAB Tutorial 2',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--rx_host', dest='rx_host', type=str, action='store',
                        default=def_rxhost,
                        help='RX Hostname or IP for the rx port.')
    parser.add_argument('--tx_host', dest='tx_host', type=str, action='store',
                        default=def_txhost,
                        help='TX Hostname or IP for the tx SKARAB.')
    parser.add_argument('--fpg', dest='fpg', type=str, action='store',
                        default=def_fpg,
                        help='fpg file to program.')
    parser.add_argument('--pktsize', dest='pktsize', type=int, action='store',
                        default=160, help='Packet length to send (in words).')
    parser.add_argument('--rate', dest='rate', type=float, action='store',
                        default=2.0, help='TX bitrate, in Gbps.')
    parser.add_argument('--decimate', dest='decimate', type=int, action='store',
                        default=-1, help='Decimate the datarate by this much.')
    parser.add_argument('-p', '--program', dest='program', action='store_true',
                        default=False, help='Program the SKARABs')
    parser.add_argument('-i', '--ipython', dest='ipython', action='store_true',
                        default=False, help='Start IPython at script end.')
    parser.add_argument('--loglevel', dest='log_level', action='store',
                        default='INFO', help='log level to use, default None, '
                                             'options INFO, DEBUG, ERROR')
    args = parser.parse_args()

    if args.log_level != '':
        import logging

        log_level = args.log_level.strip()
        try:
            logging.basicConfig(level=eval('logging.%s' % log_level))
        except AttributeError:
            raise RuntimeError('No such log level: %s' % log_level)

    # tx_host = '10.0.0.25'
    # rx_host = '10.0.0.26'
    # fpg = '/home/wnew/forty_gbe_testing/'

    if args.rate > 40.0:
        raise RuntimeError('Cannot send data faster than 40Gbps.')

    logging.info('Connecting to SKARAB.')
    f = casperfpga.CasperFpga(args.tx_host)

    if args.program:
        logging.info('Programming SKARAB.')
        res = f.upload_to_ram_and_program(args.fpg)
        if not res:
            logging.error('Could not program TX SKARAB: %s' % args.tx_host)
        logging.info('\tDone programming.')
    else:
        f.get_system_information(args.fpg)
        logging.info('Stopping TX.')
        f.registers.control.write(tx_en=0, pkt_rst='pulse')
        f.registers.control.write(snap_arm=0)

    to_pc = False

    port = 8765
    logging.info("TX ip address %s" %f.gbes["forty_gbe"].get_ip())
    logging.info("RX ip address %s" %f.gbes["forty_gbe1"].get_ip())

    # set up TX
    print f
    ip_dest = f.gbes["forty_gbe1"].get_ip()
    if to_pc:
        from casperfpga import tengbe
        ip_dest = tengbe.IpAddress('10.99.1.1')
    logging.info('Setting TX destination to %s.' % ip_dest)
    f.registers.tx_ip = int(ip_dest)
    logging.info('Setting TX port to %s' %port)
    f.registers.tx_port = port
    logging.info('Setting packet size to %s' %args.pktsize)
    f.registers.control.write(pkt_len=args.pktsize)
    #clk_ghz = f.registers.clk_mhz.read()['data']['reg'] / 1000.0
    clk_ghz = f.estimate_fpga_clock()/1000
    logging.info('Clock speed calculated as %s' %clk_ghz)
    if args.decimate > -1:
        decimation = args.decimate
    else:
        decimation = int((clk_ghz * 256.0 / args.rate) + 1)
    actual_rate = clk_ghz * 256.0 / decimation
    logging.info('Sending data at %.3fGbps (%.3fGhz * 256 / %i)' % (
        actual_rate, clk_ghz, decimation))
    f.registers.decimation.write(reg=decimation)
    logging.info('Decimation calculated as %s' %decimation)

    # set up RX
    logging.info('Setting RX port to %s' %port)
    f.gbes["forty_gbe1"].set_port(port)
    f.registers.control.write(gbe_rst='pulse')

    # Enable tx
    logging.info('Starting TX.')
    tx_comms_lost = False
    try:
        f.registers.control.write(tx_en=1, pkt_rst='pulse')
    except:
        print 'NO RESPONSE!'
        tx_comms_lost = True

    time.sleep(1)
    logging.info('Some RX stats:')
    logging.info('\tvalid: %s' % f.registers.rx_valid.read()['data']['reg'])
    logging.info('\teof: %s' % f.registers.rx_eof.read()['data']['reg'])
    logging.info('\tbadframe: %s' %
                 f.registers.rx_badframe.read()['data']['reg'])
    logging.info('\toverrun: %s'
                 % f.registers.rx_overrun.read()['data']['reg'])

    if not tx_comms_lost:
        print_txsnap(2)
        print ''

    if not to_pc:
        print_rxsnap(2)
    
    #f.registers.control.write(tx_en=1, gbe_rst='pulse')

    #f.registers.control.write(tx_en=1, gbe_rst=1)
    f.registers.control.write(gbe_rst=1)
    time.sleep(15)
    f.registers.control.write(gbe_rst=0)
    #f.registers.control.write(tx_en=1, gbe_rst=0)

    if not tx_comms_lost:
        print_txsnap(2)
        print ''

    if not to_pc:
        print_rxsnap(2)

    if not tx_comms_lost:
        print_txsnap(2)
        print ''

    if not to_pc:
        print_rxsnap(2)

    if args.ipython:
        import IPython
        IPython.embed()

# end
