class XAdc(object):
    TEMP_OFFSET    = 0x0 
    VCCINT_OFFSET  = 0x1
    VCCAUX_OFFSET  = 0x2
    VCCBRAM_OFFSET = 0x6
    reg = 'xadc'
    def __init__(self, fpga):
        self.fpga = fpga
    def get_temp(self):
        """
        Get temperature in degrees C
        """
        x = self.fpga.read_int(self.reg, offset=self.TEMP_OFFSET)
        return (x >> 4) * 503.975 / 4096. - 273.15

    def get_vccint(self):
        """
        Get VCCINT voltage
        """
        x = self.fpga.read_int(self.reg, offset=self.VCCINT_OFFSET)
        return (x >> 4) / 4096. * 3
       
    def get_vccaux(self):
        """
        Get VCCAUX voltage
        """
        x = self.fpga.read_int(self.reg, offset=self.VCCAUX_OFFSET)
        return (x >> 4) / 4096. * 3

    def get_vccbram(self):
        """
        Get VCCBRAM voltage
        """
        x = self.fpga.read_int(self.reg, offset=self.VCCBRAM_OFFSET)
        return (x >> 4) / 4096. * 3
    
