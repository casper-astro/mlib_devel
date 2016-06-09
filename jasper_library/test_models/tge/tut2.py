#!/bin/env ipython

'''
This script demonstrates programming an FPGA, configuring 10GbE cores and checking transmitted and received data using the Python KATCP library along with the katcp_wrapper distributed in the corr package. Designed for use with TUT3 at the 2009 CASPER workshop.
\n\n 
Author: Jason Manley, August 2009.
Updated for CASPER 2013 workshop. This tut needs a rework to use new snap blocks and auto bit unpack.
'''
import corr, time, struct, sys, logging, socket

#Decide where we're going to send the data, and from which addresses:
dest_ip  = 192*(2**24) + 168*(2**16) + 5*(2**8) + 21
fabric_port=10000         
source_ip= 192*(2**24) + 168*(2**16) + 5*(2**8) + 20
mac_base= 0x123456780000

pkt_period = 1024#how often to send another packet in FPGA clocks (200MHz)
payload_len = 128   #how big to make each packet in 64bit words

brams=['bram_msb','bram_lsb','bram_oob']
tx_snap = 'snap_gbe0_tx'
rx_snap = 'snap_gbe3_rx'

tx_core_name = 'gbe0'
rx_core_name = 'gbe3'

boffile = 'tut2.bof'
fpga=[]

def exit_fail():
    print 'FAILURE DETECTED. Log entries:\n',lh.printMessages()
#    try:
#        fpga.stop()
#    except: pass
#    raise
    exit()

def exit_clean():
    try:
        for f in fpgas: f.stop()
    except: pass
    exit()

if __name__ == '__main__':
    from optparse import OptionParser

    p = OptionParser()
    p.set_usage('tut2.py <ROACH_HOSTNAME_or_IP> [options]')
    p.set_description(__doc__)
    p.add_option('', '--noprogram', dest='noprogram', action='store_true',
        help='Don\'t print the contents of the packets.')  
    p.add_option('-s', '--silent', dest='silent', action='store_true',
        help='Don\'t print the contents of the packets.')  
    p.add_option('-p', '--plot', dest='plot', action='store_true',
        help='Plot the TX and RX counters. Needs matplotlib/pylab.')  
    p.add_option('-a', '--arp', dest='arp', action='store_true',
        help='Print the ARP table and other interesting bits.')  
    p.add_option('-b', '--boffile', dest='bof', type='str', default=boffile,
        help='Specify the bof file to load')  
    opts, args = p.parse_args(sys.argv[1:])

    if args==[]:
        print 'Please specify a ROACH board. \nExiting.'
        exit()
    else:
        roach = args[0]
    if opts.bof != '':
        boffile = opts.bof
try:
    lh = corr.log_handlers.DebugLogHandler()
    logger = logging.getLogger(roach)
    logger.addHandler(lh)
    logger.setLevel(10)

    print('Connecting to server %s... '%(roach)),
    fpga = corr.katcp_wrapper.FpgaClient(roach, logger=logger)
    time.sleep(1)

    if fpga.is_connected():
        print 'ok\n'
    else:
        print 'ERROR connecting to server %s.\n'%(roach)
        exit_fail()
    
    if not opts.noprogram:
        print '------------------------'
        print 'Programming FPGA...',
        sys.stdout.flush()
        fpga.progdev(boffile)
        time.sleep(10)
        print 'ok'

    print '---------------------------'    
    print 'Disabling output...',
    sys.stdout.flush()
    fpga.write_int('pkt_sim_enable', 0)
    print 'done'

    print '---------------------------'    
    print 'Port 0 linkup: ',
    sys.stdout.flush()
    gbe0_link=bool(fpga.read_int('gbe0_linkup'))
    print gbe0_link
    print 'Port 3 linkup: ',
    sys.stdout.flush()
    gbe3_link=bool(fpga.read_int('gbe3_linkup'))
    print gbe3_link

    print '---------------------------'
    print 'Configuring receiver core...',
    sys.stdout.flush()
    #fpga.tap_start('tap0',rx_core_name,mac_base+dest_ip,dest_ip,fabric_port)
    for i in range(256):
        j = i
        fpga.write(rx_core_name, struct.pack('>Q', mac_base + j), offset=(0x3000 + 8*i))
    print 'done'
    print 'Configuring transmitter core...',
    sys.stdout.flush()
    #fpga.tap_start('tap3',tx_core_name,mac_base+source_ip,source_ip,fabric_port)
    for i in range(256):
        j = i
        fpga.write(tx_core_name, struct.pack('>Q', mac_base + j), offset=(0x3000 + 8*i))
    print 'done'

    print '---------------------------'
    print 'Setting-up packet source...',
    sys.stdout.flush()
    fpga.write_int('pkt_sim_period',pkt_period)
    fpga.write_int('pkt_sim_payload_len',payload_len)
    print 'done'

    print 'Setting-up destination addresses...',
    sys.stdout.flush()
    fpga.write_int('dest_ip',dest_ip)
    fpga.write_int('dest_port',fabric_port)
    print 'done'

    print 'Resetting cores and counters...',
    sys.stdout.flush()
    fpga.write_int('rst', 3)
    fpga.write_int('rst', 0)
    print 'done'

    time.sleep(2)

    if opts.arp:
        print '\n\n==============================='
        print '10GbE Transmitter core details:'
        print '==============================='
        print "Note that for some IP address values, only the lower 8 bits are valid!"
        fpga.print_10gbe_core_details(tx_core_name,arp=True)
        print '\n\n============================'
        print '10GbE Receiver core details:'
        print '============================'
        print "Note that for some IP address values, only the lower 8 bits are valid!"
        fpga.print_10gbe_core_details(rx_core_name,arp=True)

    print 'Sent %i packets already.'%fpga.read_int('gbe0_tx_cnt')
    print 'Received %i packets already.'%fpga.read_int('gbe3_rx_frame_cnt')

    print '------------------------'
    print 'Triggering snap captures...',
    sys.stdout.flush()
    fpga.write_int(tx_snap+'_ctrl',0)
    fpga.write_int(rx_snap+'_ctrl',0)
    fpga.write_int(tx_snap+'_ctrl',1)
    fpga.write_int(rx_snap+'_ctrl',1)
    print 'done'

    print 'Enabling output...',
    sys.stdout.flush()
    fpga.write_int('pkt_sim_enable', 1)
    print 'done'

    time.sleep(2)

    tx_size = fpga.read_int(tx_snap+'_addr')+1
    rx_size = fpga.read_int(rx_snap+'_addr')+1
    if tx_size <= 1:
        print ('ERR: Not transmitting anything. This should not happen. Exiting.')
        exit_clean()
    if rx_size <= 1:
        print ("ERR: Not receiving anything. Something's wrong with your setup.")
        exit_clean()

    
    tx_bram_dmp=dict()
    for bram in brams:
        bram_name = tx_snap+'_'+bram
        print 'Reading %i values from bram %s...'%(tx_size,bram_name),
        tx_bram_dmp[bram]=fpga.read(bram_name,tx_size*4)
        sys.stdout.flush()
        print 'ok'

    rx_bram_dmp=dict()
    for bram in brams:
        bram_name = rx_snap+'_'+bram
        print 'Reading %i values from bram %s...'%(rx_size,bram_name),
        rx_bram_dmp[bram]=fpga.read(bram_name,rx_size*4)
        sys.stdout.flush()
        print 'ok'

    print 'Unpacking TX packet stream...'
    tx_data=[]
    for i in range(0,tx_size):
        data_64bit = struct.unpack('>Q',tx_bram_dmp['bram_msb'][(4*i):(4*i)+4]+tx_bram_dmp['bram_lsb'][(4*i):(4*i)+4])[0]
        tx_data.append(data_64bit)
        if not opts.silent:
            oob_32bit = struct.unpack('>L',tx_bram_dmp['bram_oob'][(4*i):(4*i)+4])[0]
            print '[%4i]: data: 0x%016X'%(i,data_64bit),
            ip_mask = (2**(8+5)) -(2**5)
            print 'IP: 0.0.0.%03d'%((oob_32bit&(ip_mask))>>5),
            if oob_32bit&(2**0): print '[TX overflow]',
            if oob_32bit&(2**1): print '[TX almost full]',
            if oob_32bit&(2**2): print '[tx_active]',
            if oob_32bit&(2**3): print '[link_up]',
            if oob_32bit&(2**4): print '[eof]',
            print '' 

    print 'Unpacking RX packet stream...'
    rx_data=[]
    ip_mask = (2**(24+5)) -(2**5) #24 bits, starting at bit 5 are valid for ip address (from snap block)
    for i in range(0,rx_size):
        data_64bit = struct.unpack('>Q',rx_bram_dmp['bram_msb'][(4*i):(4*i)+4]+rx_bram_dmp['bram_lsb'][(4*i):(4*i)+4])[0]
        rx_data.append(data_64bit)
        if not opts.silent:
            oob_32bit = struct.unpack('>L',rx_bram_dmp['bram_oob'][(4*i):(4*i)+4])[0]
            print '[%4i]: data: 0x%016X'%(i,data_64bit),
            ip_string = socket.inet_ntoa(struct.pack('>L',(oob_32bit&(ip_mask))>>5))
            print 'IP: %s'%(ip_string),
            if oob_32bit&(2**0): print '[RX overrun]',
            if oob_32bit&(2**1): print '[RX bad frame]',
            if oob_32bit&(2**3): print '[rx_active]',
            if oob_32bit&(2**4): print '[link_up]',
            if oob_32bit&(2**2): print '[eof]',
            print '' 

    print 'Checking data TX vs data RX...',
    okay = True
    for i in range(0, len(tx_data)):
        try:
            assert(tx_data[i] == rx_data[i])
        except AssertionError:
            print 'TX[%i](%i) != RX[%i](%i)' % (i, tx_data[i], i, rx_data[i])
            okay = False
    if okay:
        print 'ok.'
    else:
        print 'ERROR.'

    print '=========================='

    if opts.plot:   
        import pylab
        pylab.subplot(211)
        pylab.plot(tx_data, label='TX data')
        pylab.subplot(212)
        pylab.plot(rx_data, label='RX data')
        pylab.show()

except KeyboardInterrupt:
    exit_clean()
except Exception as inst:
    print type(inst)
    print inst.args
    print inst
    exit_fail()

exit_clean()

