'''
Functions to calibration the x64_adc interface.
To be replaced with an automatic firmware solution.
Eventually
'''

def adc_bitdump(self, fpga, calreg):
    # Some Addresses...
    CTRL       = 0
    DELAY_CTRL = 0x4
    DATASEL    = 0x8
    DATAVAL    = 0xc

    for j in range(0,4):
        print '%d: '%(j)
        #select bit
        fpga.blindwrite(calreg, '%c%c%c%c'%(0x0,0x0,0x0,j), DATASEL)
        #reset dll
        fpga.blindwrite(calreg, '%c%c%c%c'%(0x0,0x0,0x0,0xff), DELAY_CTRL)
        print "ready\tstable\tval0\t\t\tready\tstable\tval1\n" 
        for i in range(0,63):
            fpga.blindwrite(calreg, '%c%c%c%c'%(0x0,0xff, 0xff,0x0), DELAY_CTRL)
            #val = numpy.fromstring(fpga.read(calreg,4,DATAVAL), count=4, dtype='uint8')
            val = struct.unpack('>L', (fpga.read(calreg,4,DATAVAL)))[0]
            val0 = val & (0x0000ffff)
            val1 = (val & (0xffff0000))>>16
            print '%d\t%d\t%s\t\t%d\t%d\t%s' %((val0&0x2000)>>13, (val0&0x1000)>>12, self.bit_string((val0&0x0fff),12),(val1&0x2000)>>13, (val1&0x1000)>>12, self.bit_string((val1&0x0fff),12))
        print ''

def adc_cal(self, fpga, calreg):
    # Some Addresses...
    CTRL       = 0
    DELAY_CTRL = 0x4
    DATASEL    = 0x8
    DATAVAL    = 0xc

    for j in range(0,8):
        print '%d: '%(j)
        #select bit
        fpga.blindwrite(calreg, '%c%c%c%c'%(0x0,0x0,0x0,j//2), DATASEL)
        #reset dll
        fpga.blindwrite(calreg, '%c%c%c%c'%(0x0,0x0,0x0,(1<<j)), DELAY_CTRL)
        print "ready\tstable\tval0"
        stable = 1
        prev_val = 0
        while(stable==1):
            fpga.blindwrite(calreg, '%c%c%c%c'%(0x0,0xff,(1<<j),0x0), DELAY_CTRL)
            #val = numpy.fromstring(fpga.read(calreg,4,DATAVAL), count=4, dtype='uint8')
            val    = struct.unpack('>L', (fpga.read(calreg,4,DATAVAL)))[0]
            val0   = (val & ((0xffff)<<(16*(j%2))))>>(16*(j%2))
            stable = (val0&0x1000)>>12
            ready  = (val0&0x2000)>>13
            fclk_sampled = self.bit_string((val0&0x0fff),12)
            if val0 != prev_val and prev_val != 0:
                break
            prev_val = val0
            print '%d\t%d\t%s' %(ready, stable, fclk_sampled)
        print ''
        for i in range(10):
            fpga.blindwrite(calreg, '%c%c%c%c'%(0x0,0xff,(1<<j),0x0), DELAY_CTRL)
            #val = numpy.fromstring(fpga.read(calreg,4,DATAVAL), count=4, dtype='uint8')
            val    = struct.unpack('>L', (fpga.read(calreg,4,DATAVAL)))[0]
            val0   = (val & ((0xffff)<<(16*(j%2))))>>(16*(j%2))
            stable = (val0&0x1000)>>12
            ready  = (val0&0x2000)>>13
            fclk_sampled = self.bit_string((val0&0x0fff),12)
            print '%d\t%d\t%s' %(ready, stable, fclk_sampled)
        print ''

