import casperfpga
import time

class skarab_adc_rx:

	"""
	Class containing functions to control and configure the SKARAB ADC4x3G-14 mezzanine module containing the ADC32RF80 ADCs.
	"""

	def __init__(self, skarab, mezzanine_site):
		"""
		Initialises skarab_adc_rx object
		
		:param mezzanine_site: Location of mezzanine on SKARAB (0->3)
		:type mezzanine_site: int
		"""
	
		self.mezzanine_site = mezzanine_site
	
	def DirectSpiWrite(self, skarab, mezzanine_site, spi_destination, address, data):

		"""
		Low-level SPI write function used within other functions of this class.
		"""
	
		# Perform an SPI write on the SKARAB ADC mezzanine
		
		DIRECT_SPI_ADDRESS_MSB_REG = 0x20
		DIRECT_SPI_ADDRESS_LSB_REG = 0x21
		DIRECT_SPI_DATA_MSB_REG = 0x22
		DIRECT_SPI_DATA_LSB_REG = 0x23
		DIRECT_SPI_CONTROL_REG = 0x24
		START_DIRECT_SPI_ACCESS = 0x80
		STM_I2C_DEVICE_ADDRESS = 0x0C # 0x18 shifted down by 1 bit		
		i2c_interface = mezzanine_site + 1

		# Write ADDRESS
		write_byte = (address >> 8) & 0xFF
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_ADDRESS_MSB_REG, write_byte)

		write_byte = (address & 0xFF)
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_ADDRESS_LSB_REG, write_byte)

		# Write DATA
		write_byte = (data >> 8) & 0xFF;
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_DATA_MSB_REG, write_byte)

		write_byte = (data & 0xFF);
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_DATA_LSB_REG, write_byte)

		write_byte = spi_destination
		# Write, so read/not write bit is 0
		write_byte = write_byte | START_DIRECT_SPI_ACCESS;
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_CONTROL_REG, write_byte)

		# Wait for the update to complete
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_CONTROL_REG)
		read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

		timeout = 0
		while (((read_byte[0] & START_DIRECT_SPI_ACCESS) != 0) and (timeout < 1000)):
			skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_CONTROL_REG)
			read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

			timeout = timeout + 1

		if timeout == 1000:
			print("DirectSpiWrite ERROR: Timeout waiting for the SPI transaction to complete.")

		return;

	
	def DirectSpiRead(self, skarab, mezzanine_site, spi_destination, address):

		"""
		Low-level SPI read function used within other functions of this class.
		"""
	
		# Perform an SPI read on the SKARAB ADC mezzanine

		DIRECT_SPI_ADDRESS_MSB_REG = 0x20
		DIRECT_SPI_ADDRESS_LSB_REG = 0x21
		DIRECT_SPI_DATA_MSB_REG = 0x22
		DIRECT_SPI_DATA_LSB_REG = 0x23
		DIRECT_SPI_CONTROL_REG = 0x24
		START_DIRECT_SPI_ACCESS = 0x80
		DIRECT_SPI_READ_NOT_WRITE = 0x10
		STM_I2C_DEVICE_ADDRESS = 0x0C # 0x18 shifted down by 1 bit		
		i2c_interface = mezzanine_site + 1

		# Write ADDRESS
		write_byte = (address >> 8) & 0xFF
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_ADDRESS_MSB_REG, write_byte)

		write_byte = (address & 0xFF)
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_ADDRESS_LSB_REG, write_byte)


		write_byte = spi_destination | START_DIRECT_SPI_ACCESS | DIRECT_SPI_READ_NOT_WRITE
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_CONTROL_REG, write_byte)

		# Wait for the update to complete
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_CONTROL_REG)
		read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

		timeout = 0
		while (((read_byte[0] & START_DIRECT_SPI_ACCESS) != 0) and (timeout < 1000)):
			skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_CONTROL_REG)
			read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

			timeout = timeout + 1

		if timeout == 1000:
			print("DirectSpiWrite ERROR: Timeout waiting for the SPI transaction to complete.")

		# Now get the read data
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_DATA_MSB_REG)
		read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

		read_word = read_byte[0] << 8

		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DIRECT_SPI_DATA_LSB_REG)
		read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

		read_word = read_word | read_byte[0];

		return read_word;
		
	def EnableAdcRampData(self, skarab):

		"""
		Function used to configure the SKARAB ADC4x3G-14 mezzanine module to produce a ramp pattern.		
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga
		"""
		
		# Configure ADC in ramp pattern mode (Decimation Mode)
	
		SPI_DESTINATION_ADC_0 = 0x2
		SPI_DESTINATION_ADC_1 = 0x3
		mezzanine_site = self.mezzanine_site

		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x5839, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x5837, 0x44) # Pattern Code for ChB: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x5838, 0x44) # Pattern Code for ChB: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x583A, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x583A, 0x01)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x583A, 0x03)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x583A, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x5039, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x5037, 0x44) # Pattern Code for ChA: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x5038, 0x44) # Pattern Code for ChA: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x503A, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x503A, 0x01)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x503A, 0x03)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, 0x503A, 0x00)

		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x5839, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x5837, 0x44) # Pattern Code for ChB: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x5838, 0x44) # Pattern Code for ChB: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x583A, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x583A, 0x01)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x583A, 0x03)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x583A, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x5039, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x5037, 0x44) # Pattern Code for ChA: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x5038, 0x44) # Pattern Code for ChA: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x503A, 0x00)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x503A, 0x01)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x503A, 0x03)
		DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, 0x503A, 0x00)

		return;
		
	def ConfigureGain(self, skarab, gain, adc_input):
		
		"""
		Function used to set the gain of the amplifiers in the analogue channels of the SKARAB ADC4x3G-14 mezzanine module.		
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga
		:param adc_input: The ADC channel whose gain should be set (0 -> 3).
		:type adc_input: int
		:param adc_input: The gain of the ADC channel (-6 to 15 dB).
		:type adc_input: int
		"""
		
		UPDATE_GAIN = 0x80
		mezzanine_site = self.mezzanine_site
		i2c_interface = mezzanine_site + 1
		STM_I2C_DEVICE_ADDRESS = 0x0C # 0x18 shifted down by 1 bit
		GAIN_CONTROL_REG = 0x18
		ADC_GAIN_CHANNEL_0 = 0x1
		ADC_GAIN_CHANNEL_1 = 0x0
		ADC_GAIN_CHANNEL_2 = 0x3
		ADC_GAIN_CHANNEL_3 = 0x2
		gain_channel = ADC_GAIN_CHANNEL_0
		 
		if adc_input == 0:
			gain_channel = ADC_GAIN_CHANNEL_0
		elif adc_input == 1:
			gain_channel = ADC_GAIN_CHANNEL_1
		elif adc_input == 2:
			gain_channel = ADC_GAIN_CHANNEL_2
		else:
			gain_channel = ADC_GAIN_CHANNEL_3

		print("Configuring gain.")
		gain_control_word = (-1 * gain) + 15

		write_byte = gain_channel | (gain_control_word << 2) | UPDATE_GAIN

		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, GAIN_CONTROL_REG, write_byte)

		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, GAIN_CONTROL_REG)

		read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

		timeout = 0

		while (((read_byte[0] & UPDATE_GAIN) != 0) and (timeout < 1000)):
			skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, GAIN_CONTROL_REG)
			read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)
			timeout = timeout + 1

		if timeout == 1000:
			print("ERROR: Timeout waiting for configure gain to complete!")
			
	def ConfigureAdcDdc(self, skarab, adc_input, real_ddc_output_enable):
	
		"""
		Function used to configure the DDCs on the SKARAB ADC4x3G-14 mezzanine module.		
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga
		:param adc_input: The ADC channel to configure (0 -> 3).
		:type adc_input: int
		:param real_ddc_output_enable: Enable/Disable real DDC output values
		:type real_ddc_output_enable: boolean
		"""
	
		ADC = 0
		channel = 'A'
		adc_sample_rate = 3e9
		
		if adc_input == 0:
			ADC = 0
			channel = 'B'
		elif adc_input == 1:
			ADC = 0
			channel = 'A'
		elif adc_input == 2:
			ADC = 1
			channel = 'B'
		else:
			ADC = 1
			channel = 'A'
			
		mezzanine_site = self.mezzanine_site
		i2c_interface = mezzanine_site + 1		
		STM_I2C_DEVICE_ADDRESS = 0x0C # 0x18 shifted down by 1 bit
		adc_sample_rate = 3e9
		decimation_rate = 4	
		DECIMATION_RATE_REG = 0x19
		DDC0_NCO_SETTING_MSB_REG = 0x1A
		DDC0_NCO_SETTING_LSB_REG = 0x1B
		DDC1_NCO_SETTING_MSB_REG = 0x1C
		DDC1_NCO_SETTING_LSB_REG = 0x1D
		ddc0_centre_frequency = 1e9
		ddc1_centre_frequency = 0
		dual_band_mode = False
		DDC_ADC_SELECT = 0x01
		DDC_CHANNEL_SELECT = 0x02
		DUAL_BAND_ENABLE = 0x04
		REAL_DDC_OUTPUT_SELECT = 0x40 # ADD SUPPORT FOR REAL DDC OUTPUT SAMPLES
		SECOND_NYQUIST_ZONE_SELECT = 0x08
		UPDATE_DDC_CHANGE = 0x80
		DDC_CONTROL_REG = 0x1E
	
		# Configure ADC DDC
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DECIMATION_RATE_REG, decimation_rate)

		# Calculate the NCO value
		nco_register_setting = pow(2.0, 16.0) * (ddc0_centre_frequency / adc_sample_rate)
		nco_register_setting = int(nco_register_setting)

		write_byte = (nco_register_setting >> 8) & 0xFF
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DDC0_NCO_SETTING_MSB_REG, write_byte)

		write_byte = nco_register_setting & 0xFF
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DDC0_NCO_SETTING_LSB_REG, write_byte)

		# If in dual band mode, calculate the second NCO value
		if dual_band_mode == True:
			nco_register_setting = pow(2.0, 16.0) * (ddc1_centre_frequency / adc_sample_rate)
			nco_register_setting = int(nco_register_setting)

			write_byte = (nco_register_setting >> 8) & 0xFF
			skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DDC1_NCO_SETTING_MSB_REG, write_byte)

			write_byte = nco_register_setting & 0xFF
			skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DDC1_NCO_SETTING_LSB_REG, write_byte)

		# Trigger a configuration
		write_byte = 0
		if ADC == 1:
			write_byte = write_byte | DDC_ADC_SELECT

		if channel == 'B':
			write_byte = write_byte | DDC_CHANNEL_SELECT

		if dual_band_mode == True:
			write_byte = write_byte | DUAL_BAND_ENABLE
			
		# 08/08/2018 ADD SUPPORT FOR REAL DDC OUTPUT SAMPLES	
		if real_ddc_output_enable == True:
			write_byte = write_byte | REAL_DDC_OUTPUT_SELECT

		# Determine if in second nyquist zone
		if (ddc0_centre_frequency > (adc_sample_rate / 2)):
			write_byte = write_byte | SECOND_NYQUIST_ZONE_SELECT

		write_byte = write_byte | UPDATE_DDC_CHANGE

		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DDC_CONTROL_REG, write_byte)

		# Wait for the update to complete
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DDC_CONTROL_REG)
		read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

		timeout = 0
		while (((read_byte[0] & UPDATE_DDC_CHANGE) != 0) and (timeout < 1000)):
			skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, DDC_CONTROL_REG)
			read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)
			timeout = timeout + 1

		if timeout == 1000:
			print("ERROR: Timeout waiting for configure DDC to complete!")

	def PerformAdcPllSync(self, skarab):
		"""
		Function used to synchronise the ADCs and PLL on the SKARAB ADC4x3G-14 mezzanine module.
		After syncrhonisation is performed, ADC sampling begins.
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga
		"""
		
		SPI_DESTINATION_PLL = 0x0
		SPI_DESTINATION_ADC_0 = 0x2
		SPI_DESTINATION_ADC_1 = 0x3
		ADC_GENERAL_MASTER_PAGE_SEL = 0x0012
		ADC_GENERAL_ADC_PAGE_SEL = 0x0011
		SPI_DESTINATION_DUAL_ADC = 0x8
		ENABLE_PLL_SYNC = 0x01
		ENABLE_ADC_SYNC = 0x02
		HOST_PLL_GPIO_CONTROL_REG = 0x26
		MEZ_CONTROL_REG = 0x01
		STM_I2C_DEVICE_ADDRESS = 0x0C # 0x18 shifted down by 1 bit
		FIRMWARE_VERSION_MAJOR_REG = 0x7E
		FIRMWARE_VERSION_MINOR_REG = 0x7F
		PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE = 0x00E6
		PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE = 0x010E
		PLL_CLOCK_OUTPUT_PHASE_STATUS = 0x04
		ADC_MASTER_PDN_SYSREF = 0x0020
		PLL_ALARM_READBACK = 0x007D
		
		mezzanine_site = self.mezzanine_site
		i2c_interface = mezzanine_site + 1
		
		# Get embedded software version
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, FIRMWARE_VERSION_MAJOR_REG)
		major_version = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)
		skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, FIRMWARE_VERSION_MINOR_REG)
		minor_version = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)
		
		# Synchronise PLL and ADC	
		skarab.write_int('pll_sync_start_in', 0)
		skarab.write_int('adc_sync_start_in', 0)
		skarab.write_int('adc_trig', 0)	
		pll_loss_of_reference = False
		synchronise_mezzanine = [False, False, False, False]
		synchronise_mezzanine[mezzanine_site] = True

		if ((major_version == 1) and (minor_version < 3)):
			# TO DO: Implement LVDS SYSREF
			print("Synchronising PLL with LVDS SYSREF.")

			for mezzanine in range(0, 4):
				print("Checking PLL loss of reference for mezzanine: ", mezzanine)

				if synchronise_mezzanine[mezzanine] == True:

					skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, HOST_PLL_GPIO_CONTROL_REG)
					read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

					if ((read_byte[0] & 0x01) == 0x01):
						# PLL reporting loss of reference
						pll_loss_of_reference = True
						print("PLL reporting loss of reference.")
					else:
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)

						# Enable PLL SYNC
						skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, MEZ_CONTROL_REG, ENABLE_PLL_SYNC)

			# Only try to synchronise PLLs if all SKARAB ADC32RF45X2 mezzanines have reference
			if pll_loss_of_reference == False:
				# Synchronise HMC7044 first
				printf("Synchronising PLL.")

				# Trigger a PLL SYNC signal from the MB firmware
				skarab.write_int('pll_sync_start_in', 0)
				skarab.write_int('pll_sync_start_in', 1)

				# Wait for the PLL SYNC to complete
				timeout = 0
				read_reg = skarab.read_int('pll_sync_complete_out')
				while ((read_reg == 0) and (timeout < 100)):
					read_reg = skarab.read_int('pll_sync_complete_out')
					timeout = timeout + 1

				if timeout == 100:
					print("ERROR: Timeout waiting for PLL SYNC to complete!")

				for mezzanine in range(0, 4):
					if synchronise_mezzanine[mezzanine] == True:
						# Disable the PLL SYNC and wait for SYSREF outputs to be in phase
						print("Disabling ADC SYNC on mezzanine: ", mezzanine)

						skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, MEZ_CONTROL_REG, 0x0)

						spi_read_word = self.DirectSpiRead(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_ALARM_READBACK)
						timeout = 0
						while (((spi_read_word & PLL_CLOCK_OUTPUT_PHASE_STATUS) == 0x0) and (timeout < 1000)):
							spi_read_word = self.DirectSpiRead(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_ALARM_READBACK)
							timeout = timeout + 1

						if timeout == 1000:
							print("ERROR: Timeout waiting for the mezzanine PLL outputs to be in phase.")

						# Power up SYSREF input buffer on ADCs
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, ADC_GENERAL_ADC_PAGE_SEL, 0x00)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, ADC_MASTER_PDN_SYSREF, 0x00)

						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, ADC_GENERAL_ADC_PAGE_SEL, 0x00)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, ADC_MASTER_PDN_SYSREF, 0x00)

						time.sleep(1)
						
						# Need to disable both at the same time so NCOs have same phase
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_DUAL_ADC, ADC_MASTER_PDN_SYSREF, 0x10)
						
						# Disable SYSREF again
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xD0)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xD0)

		else:
			print("Synchronising PLL with LVPECL SYSREF.");
			
			# Check first to see if mezzanine has a reference clock
			for mezzanine in range(0, 4):
				print("Checking PLL loss of reference for mezzanine: ", mezzanine)

				if synchronise_mezzanine[mezzanine] == True:

					skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, HOST_PLL_GPIO_CONTROL_REG)
					read_byte = skarab.transport.read_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, 1)

					if ((read_byte[0] & 0x01) == 0x01):
						# PLL reporting loss of reference
						pll_loss_of_reference = True
						print("PLL reporting loss of reference.")
					else:
						# Change the SYNC pin to SYNC source
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x41)

						# Change SYSREF to pulse gen mode so don't generate any pulses yet
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_CHANNEL_OUTPUT_3_CONTROL_FORCE_MUTE, 0x88)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_CHANNEL_OUTPUT_7_CONTROL_FORCE_MUTE, 0x88)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xDD)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xDD)

						# Enable PLL SYNC
						skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, MEZ_CONTROL_REG, ENABLE_PLL_SYNC)

			# Only try to synchronise PLLs if all SKARAB ADC32RF45X2 mezzanines have reference
			if pll_loss_of_reference == False:
				# Synchronise HMC7044 first
				printf("Synchronising PLL.")

				# Trigger a PLL SYNC signal from the MB firmware
				skarab.write_int('pll_sync_start_in', 0)
				skarab.write_int('pll_sync_start_in', 1)

				# Wait for the PLL SYNC to complete
				timeout = 0
				read_reg = skarab.read_int('pll_sync_complete_out')
				while ((read_reg == 0) and (timeout < 100)):
					read_reg = skarab.read_int('pll_sync_complete_out')
					timeout = timeout + 1

				if timeout == 100:
					print("ERROR: Timeout waiting for PLL SYNC to complete!")

				# Wait for the PLL to report valid SYNC status
				for mezzanine in range(0, 4):
					print("Checking PLL SYNC status for mezzanine: ", mezzanine)
					
					if synchronise_mezzanine[mezzanine] == True:
						spi_read_word = self.DirectSpiRead(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_ALARM_READBACK)
						timeout = 0
						while (((spi_read_word & PLL_CLOCK_OUTPUT_PHASE_STATUS) == 0x0) and (timeout < 1000)):
							spi_read_word = self.DirectSpiRead(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_ALARM_READBACK)
							timeout = timeout + 1

						if timeout == 1000:
							print("ERROR: Timeout waiting for the mezzanine PLL outputs to be in phase.")

				# Synchronise ADCs to SYSREF next
				for mezzanine in range(0, 4):
					print("Using SYSREF to synchronise ADC on mezzanine: ", mezzanine)
					
					if synchronise_mezzanine[mezzanine] == True:
						# Change the SYNC pin to pulse generator
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_PLL, PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x81)

						# Power up SYSREF input buffer on ADCs
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, ADC_GENERAL_ADC_PAGE_SEL, 0x00)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, ADC_MASTER_PDN_SYSREF, 0x00)

						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, ADC_GENERAL_ADC_PAGE_SEL, 0x00)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, ADC_MASTER_PDN_SYSREF, 0x00)

				# Trigger a PLL SYNC signal from the MB firmware
				skarab.write_int('pll_sync_start_in', 0)
				skarab.write_int('pll_sync_start_in', 1)

				timeout = 0
				read_reg = skarab.read_int('pll_sync_complete_out')
				while ((read_reg == 0) and (timeout < 100)):
					read_reg = skarab.read_int('pll_sync_complete_out')
					timeout = timeout + 1

				for mezzanine in range(0, 4):
					print("Power down SYSREF buffer for ADC on mezzanine: ", mezzanine)

					if synchronise_mezzanine[mezzanine] == True:
						# Power down SYSREF input buffer on ADCs
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_0, ADC_MASTER_PDN_SYSREF, 0x10)
						self.DirectSpiWrite(skarab, mezzanine_site, SPI_DESTINATION_ADC_1, ADC_MASTER_PDN_SYSREF, 0x10)

		# At this point, all the PLLs across all mezzanine sites should be in sync

		# Enable the ADC SYNC
		for mezzanine in range(0, 4):
			if synchronise_mezzanine[mezzanine] == True:
				print("Enabling ADC SYNC on mezzanine: ", mezzanine)

				skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, MEZ_CONTROL_REG, ENABLE_ADC_SYNC)

		# Trigger a ADC SYNC signal from the MB firmware
		skarab.write_int('adc_sync_start_in', 0)
		skarab.write_int('adc_sync_start_in', 1)

		timeout = 0
		read_reg = skarab.read_int('adc_sync_complete_out')
		while ((read_reg == 0) and (timeout < 1000)):
			read_reg = skarab.read_int('adc_sync_complete_out')
			timeout = timeout + 1

		if timeout == 1000:
			print("ERROR: Timeout waiting for ADC SYNC to complete!")

		# Disable the ADC SYNC
		for mezzanine in range(0, 4):
			if synchronise_mezzanine[mezzanine] == True:
				print("Disabling ADC SYNC on mezzanine: ", mezzanine)

				skarab.transport.write_i2c(i2c_interface, STM_I2C_DEVICE_ADDRESS, MEZ_CONTROL_REG, 0x0)
			
# Connect to SKARAB and upload .fpg file
skarab = casperfpga.CasperFpga('10.0.0.14')
skarab.upload_to_ram_and_program('test_skarab_adc_2019-01-28_1152.fpg', legacy_reg_map=False)
skarab.listdev()
# Specify Mezzanine Site
mezzanine_site = 2
# Create SKARAB ADC receiver controller object
skarab_adc_rx_obj = skarab_adc_rx(skarab, mezzanine_site)
#skarab_adc_rx_obj.ConfigureGain(skarab, 0, 0)
#skarab_adc_rx_obj.ConfigureAdcDdc(skarab, 0, False)
#skarab_adc_rx_obj.EnableAdcRampData(skarab)		
skarab_adc_rx_obj.PerformAdcPllSync(skarab)

# Read register values
read_value = skarab.read_int('adc0_data_q_out0')
print("ADC0 Q:", read_value)
read_value = skarab.read_int('adc0_data_i_out0')
print("ADC0 I:", read_value)
read_value = skarab.read_int('pll_sync_complete_out')
print("PLL SYNC:", read_value)
read_value = skarab.read_int('adc_sync_complete_out')
print("ADC SYNC:", read_value)
read_value = skarab.read_int('adc_data_val_out')
print("ADC data val:", read_value)

# Arm ADC snapshots and trigger
print("Arming ADC snapshots.")
skarab.snapshots.adc0_out_ss.arm()
skarab.snapshots.adc1_out_ss.arm()
skarab.snapshots.adc2_out_ss.arm()
skarab.snapshots.adc3_out_ss.arm()
print("Enabling trigger.")
skarab.write_int('adc_trig', 1)

# Write each ADC channel's sample data to a separate file
adc0_in_full = skarab.snapshots.adc0_out_ss.read(arm=False)['data'] 
adc0_file = open("adc0_data.txt","w")
for array_index in range(0, 1024):
	adc0_file.write(str(adc0_in_full['i_0'][array_index]))
	adc0_file.write("\n")
	adc0_file.write(str(adc0_in_full['i_1'][array_index]))
	adc0_file.write("\n")
	adc0_file.write(str(adc0_in_full['i_2'][array_index]))
	adc0_file.write("\n")
	adc0_file.write(str(adc0_in_full['i_3'][array_index]))
	adc0_file.write("\n")
for array_index in range(0, 1024):
	adc0_file.write(str(adc0_in_full['q_0'][array_index]))
	adc0_file.write("\n")
	adc0_file.write(str(adc0_in_full['q_1'][array_index]))
	adc0_file.write("\n")
	adc0_file.write(str(adc0_in_full['q_2'][array_index]))
	adc0_file.write("\n")
	adc0_file.write(str(adc0_in_full['q_3'][array_index]))
	adc0_file.write("\n")
adc0_file.close()
adc1_in_full = skarab.snapshots.adc1_out_ss.read(arm=False)['data'] 
adc1_file = open("adc1_data.txt","w")
for array_index in range(0, 1024):
	adc1_file.write(str(adc1_in_full['i_0'][array_index]))
	adc1_file.write("\n")
	adc1_file.write(str(adc1_in_full['i_1'][array_index]))
	adc1_file.write("\n")
	adc1_file.write(str(adc1_in_full['i_2'][array_index]))
	adc1_file.write("\n")
	adc1_file.write(str(adc1_in_full['i_3'][array_index]))
	adc1_file.write("\n")
for array_index in range(0, 1024):
	adc1_file.write(str(adc1_in_full['q_0'][array_index]))
	adc1_file.write("\n")
	adc1_file.write(str(adc1_in_full['q_1'][array_index]))
	adc1_file.write("\n")
	adc1_file.write(str(adc1_in_full['q_2'][array_index]))
	adc1_file.write("\n")
	adc1_file.write(str(adc1_in_full['q_3'][array_index]))
	adc1_file.write("\n")
adc1_file.close()
adc2_in_full = skarab.snapshots.adc2_out_ss.read(arm=False)['data'] 
adc2_file = open("adc2_data.txt","w")
for array_index in range(0, 1024):
	adc2_file.write(str(adc2_in_full['i_0'][array_index]))
	adc2_file.write("\n")
	adc2_file.write(str(adc2_in_full['i_1'][array_index]))
	adc2_file.write("\n")
	adc2_file.write(str(adc2_in_full['i_2'][array_index]))
	adc2_file.write("\n")
	adc2_file.write(str(adc2_in_full['i_3'][array_index]))
	adc2_file.write("\n")
for array_index in range(0, 1024):
	adc2_file.write(str(adc2_in_full['q_0'][array_index]))
	adc2_file.write("\n")
	adc2_file.write(str(adc2_in_full['q_1'][array_index]))
	adc2_file.write("\n")
	adc2_file.write(str(adc2_in_full['q_2'][array_index]))
	adc2_file.write("\n")
	adc2_file.write(str(adc2_in_full['q_3'][array_index]))
	adc2_file.write("\n")
adc2_file.close()
adc3_in_full = skarab.snapshots.adc3_out_ss.read(arm=False)['data'] 
adc3_file = open("adc3_data.txt","w")
for array_index in range(0, 1024):
	adc3_file.write(str(adc3_in_full['i_0'][array_index]))
	adc3_file.write("\n")
	adc3_file.write(str(adc3_in_full['i_1'][array_index]))
	adc3_file.write("\n")
	adc3_file.write(str(adc3_in_full['i_2'][array_index]))
	adc3_file.write("\n")
	adc3_file.write(str(adc3_in_full['i_3'][array_index]))
	adc3_file.write("\n")
for array_index in range(0, 1024):
	adc3_file.write(str(adc3_in_full['q_0'][array_index]))
	adc3_file.write("\n")
	adc3_file.write(str(adc3_in_full['q_1'][array_index]))
	adc3_file.write("\n")
	adc3_file.write(str(adc3_in_full['q_2'][array_index]))
	adc3_file.write("\n")
	adc3_file.write(str(adc3_in_full['q_3'][array_index]))
	adc3_file.write("\n")
adc3_file.close()
