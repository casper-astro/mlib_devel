import casperfpga
from casperfpga import skarab_definitions as sd

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
			
	def ConfigureAdcDdc(self, skarab, adc_input, real_ddc_output_enable):
		"""
		Function used to configure the DDCs on the SKARAB ADC4x3G-14 mezzanine module.		
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga.transport_skarab.SkarabTransport
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
		adc_sample_rate = 3e9
		decimation_rate = 4	
		ddc0_centre_frequency = 1e9
		ddc1_centre_frequency = 0
		dual_band_mode = False
		
		# Configure ADC DDC
		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.DECIMATION_RATE_REG, decimation_rate)

		# Calculate the NCO value
		nco_register_setting = pow(2.0, 16.0) * (ddc0_centre_frequency / adc_sample_rate)
		nco_register_setting = int(nco_register_setting)

		write_byte = (nco_register_setting >> 8) & 0xFF
		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.DDC0_NCO_SETTING_MSB_REG, write_byte)

		write_byte = nco_register_setting & 0xFF
		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.DDC0_NCO_SETTING_LSB_REG, write_byte)

		# If in dual band mode, calculate the second NCO value
		if dual_band_mode == True:
			nco_register_setting = pow(2.0, 16.0) * (ddc1_centre_frequency / adc_sample_rate)
			nco_register_setting = int(nco_register_setting)

			write_byte = (nco_register_setting >> 8) & 0xFF
			skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.DDC1_NCO_SETTING_MSB_REG, write_byte)

			write_byte = nco_register_setting & 0xFF
			skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.DDC1_NCO_SETTING_LSB_REG, write_byte)

		# Trigger a configuration
		write_byte = 0
		if ADC == 1:
			write_byte = write_byte | sd.DDC_ADC_SELECT

		if channel == 'B':
			write_byte = write_byte | sd.DDC_CHANNEL_SELECT

		if dual_band_mode == True:
			write_byte = write_byte | sd.DUAL_BAND_ENABLE
			
		# 08/08/2018 ADD SUPPORT FOR REAL DDC OUTPUT SAMPLES	
		if real_ddc_output_enable == True:
			write_byte = write_byte | sd.REAL_DDC_OUTPUT_SELECT

		# Determine if in second nyquist zone
		if (ddc0_centre_frequency > (adc_sample_rate / 2)):
			write_byte = write_byte | sd.SECOND_NYQUIST_ZONE_SELECT

		write_byte = write_byte | sd.UPDATE_DDC_CHANGE

		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.DDC_CONTROL_REG, write_byte)

		# Wait for the update to complete
		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.DDC_CONTROL_REG)
		read_byte = skarab.transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)

		timeout = 0
		while (((read_byte[0] & sd.UPDATE_DDC_CHANGE) != 0) and (timeout < 1000)):
			skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.DDC_CONTROL_REG)
			read_byte = skarab.transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)
			timeout = timeout + 1

		if timeout == 1000:
			print("ERROR: Timeout waiting for configure DDC to complete!")
	
	def ConfigPllDdcMode(self, skarab):
		"""
		Function used to configure the PLL IC (HMC7044) of the SKARAB ADC4x3G-14 
		mezzanine module to provide the clocks for DDC mode.
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga.transport_skarab.SkarabTransport
		"""    
		
		# Function variables
		PLL_UNCONFIGURED = 0
		PLL_CONFIGURED = 1
		mezzanine_site = self.mezzanine_site
		
				# Reset HMC7044
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_SOFT_RESET_CONTROL, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_SOFT_RESET_CONTROL, 0x00)
		
		# Configure HMC7044
		# Configure default register values
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_96, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_97, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_98, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_99, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_9A, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_9B, 0xAA)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_9C, 0xAA)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_9D, 0xAA)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_9E, 0xAA)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_9F, 0x4D)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A0, 0xDF)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A1, 0x97)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A2, 0x03)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A3, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A4, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A5, 0x06)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A6, 0x1C)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A7, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A8, 0x06)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_A9, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_AB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_AC, 0x20)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_AD, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_AE, 0x08)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_AF, 0x50)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_B0, 0x04)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_B1, 0x0D)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_B2, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_B3, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_B5, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_B6, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_B7, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_RESERVED_B8, 0x00)

		# Configure global registers
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_SOFT_RESET_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_REQUEST_AND_MODE_CONTROL_0, 0x60)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_REQUEST_AND_MODE_CONTROL_1, 0x04)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_ENABLE_CONTROL_0, 0x2F)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_ENABLE_CONTROL_1, 0x2A)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x41) 
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_CLEAR_ALARMS, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MISCELLANEOUS_CONTROL_0, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MISCELLANEOUS_CONTROL_1_SCRATCHPAD, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MISCELLANEOUS_CONTROL_2, 0x01)

		# Configure PLL 2
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_MISCELLANEOUS_CONTROL_0, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_FREQUENCY_DOUBLER_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_REFERENCE_DIVIDER_CONTROL_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_REFERENCE_DIVIDER_CONTROL_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_FEEDBACK_DIVIDER_CONTROL_LSB, 0x0F)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_FEEDBACK_DIVIDER_CONTROL_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_CHARGE_PUMP_CONTROL, 0x0F)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_PFD_CONTROL, 0x18)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_OSCOUT_PATH_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_OSCOUT0_DRIVER_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_OSCOUT1_DRIVER_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL2_MISCELLANEOUS_CONTROL_1, 0x00)

		# Configure PLL 1
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_LOCK_DETECT_CONTROL, 0x14)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CLKIN0_INPUT_PRESCALER_CONTROL, 0x01) 
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CLKIN1_INPUT_PRESCALER_CONTROL, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CLKIN2_INPUT_PRESCALER_CONTROL, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CLKIN3_INPUT_PRESCALER_CONTROL, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_OSCIN_INPUT_PRESCALER_CONTROL, 0x0A) 
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_REFERENCE_DIVIDER_CONTROL_LSB, 0x01) 
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_REFERENCE_DIVIDER_CONTROL_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_FEEDBACK_DIVIDER_CONTROL_LSB, 0x0A)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_FEEDBACK_DIVIDER_CONTROL_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_REFERENCE_PRIORITY_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_LOSS_OF_SIGNAL_CONTROL, 0x03)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_HOLDOVER_EXIT_CONTROL, 0x0C)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_HOLDOVER_DAC_ADC_CONTROL_0, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_HOLDOVER_DAC_ADC_CONTROL_1, 0x04)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_LOS_MODE_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_CHARGE_PUMP_CONTROL, 0x02)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_PFD_CONTROL, 0x18)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_REFERENCE_SWITCHING_CONTROL, 0x24)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_HOLDOFF_TIME_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CLKIN0_INPUT_BUFFER_CONTROL, 0x07) 
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CLKIN1_INPUT_BUFFER_CONTROL, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CLKIN2_INPUT_BUFFER_CONTROL, 0x06)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CLKIN3_INPUT_BUFFER_CONTROL, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_OSCIN_INPUT_BUFFER_CONTROL, 0x07)

		# Configure the GPIO
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GPI1_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GPI2_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GPI3_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GPI4_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GPO1_CONTROL, 0x15)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GPO2_CONTROL, 0x1D)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GPO3_CONTROL, 0x29)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GPO4_CONTROL, 0x31)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_SDATA_CONTROL, 0x03)

		# Configure the SYSREF
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_SYSREF_TIMER_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_SYSREF_TIMER_MSB, 0x04)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PULSE_GENERATOR_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_SYNC_CONTROL, 0x02)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_SYSREF_MISCELLANEOUS_CONTROL, 0x00)

		# Configure the clock distribution network
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_EXTERNAL_VCO_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ANALOG_DELAY_COMMON_CONTROL, 0x00)

		# Configure the alarm masks - not sure when to do this
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_PLL1_ALARM_MASK_CONTROL, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_MASK_CONTROL, 0x10)

		# Configure the outputs
		# Unused outputs
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_FORCE_MUTE, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_CHANNEL_DIVIDER_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_HIGH_PERFORMANCE_MODE, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_0_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_FORCE_MUTE, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_CHANNEL_DIVIDER_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_HIGH_PERFORMANCE_MODE, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_1_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_FORCE_MUTE, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_CHANNEL_DIVIDER_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_HIGH_PERFORMANCE_MODE, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_4_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_FORCE_MUTE, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_CHANNEL_DIVIDER_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_HIGH_PERFORMANCE_MODE, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_5_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_FORCE_MUTE, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_CHANNEL_DIVIDER_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_HIGH_PERFORMANCE_MODE, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_8_CONTROL_RESERVED, 0x00)
		
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_FORCE_MUTE, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_CHANNEL_DIVIDER_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_HIGH_PERFORMANCE_MODE, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_9_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_FORCE_MUTE, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_CHANNEL_DIVIDER_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_HIGH_PERFORMANCE_MODE, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_12_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_FORCE_MUTE, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_CHANNEL_DIVIDER_LSB, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_HIGH_PERFORMANCE_MODE, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_13_CONTROL_RESERVED, 0x00)

		# Used outputs
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_FORCE_MUTE, 0x08)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_CHANNEL_DIVIDER_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_OUTPUT_MUX_SELECTION, 0x03)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_2_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_FORCE_MUTE, 0x08)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_CHANNEL_DIVIDER_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_CHANNEL_DIVIDER_MSB, 0x04)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_FORCE_MUTE, 0x08)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_CHANNEL_DIVIDER_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_OUTPUT_MUX_SELECTION, 0x03)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_6_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_FORCE_MUTE, 0x08)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_CHANNEL_DIVIDER_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_CHANNEL_DIVIDER_MSB, 0x04)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_FORCE_MUTE, 0x08)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_CHANNEL_DIVIDER_LSB, 0x10)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_CHANNEL_DIVIDER_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_HIGH_PERFORMANCE_MODE, 0x51)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_10_CONTROL_RESERVED, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_FORCE_MUTE, 0x08)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_CHANNEL_DIVIDER_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_CHANNEL_DIVIDER_MSB, 0x04)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_HIGH_PERFORMANCE_MODE, 0x51)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_FINE_ANALOG_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_COARSE_DIGITAL_DELAY, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_MULTISLIP_DIGITAL_DELAY_LSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_MULTISLIP_DIGITAL_DELAY_MSB, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_OUTPUT_MUX_SELECTION, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_11_CONTROL_RESERVED, 0x00)

		# Wait until the VCO peak detector loop has stabilised
		time.sleep(0.01)

		# Toggle the restart dividers/FSMs bit
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_REQUEST_AND_MODE_CONTROL_0, 0x62)
		time.sleep(0.01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_REQUEST_AND_MODE_CONTROL_0, 0x60)
		time.sleep(0.01)

		# Wait for PLL2 to lock
		uTimeout = 0
		uStatus = 0
		while (((uStatus & 0x1) == 0x0) and (uTimeout < 100)):
			print("Waiting for HMC7044 PLL2 to lock...")
			uStatus = skarab.transport.direct_spi_read(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
			uTimeout = uTimeout + 1
			time.sleep(0.01)

		if (uTimeout == 100):
			print("InitialiseHMC7044: Timeout waiting for HMC7044 PLL2 to lock!")
			return PLL_UNCONFIGURED
		else:
			# Send initial SYNC request over SPI (later request from host)
			# Rising edge sensitive
			skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_REQUEST_AND_MODE_CONTROL_0, 0xE0)

			# Wait for 6 SYSREF periods
			time.sleep(0.01)

			# Wait for output phases to stabilise
			uTimeout = 0
			uStatus = 0
			while (((uStatus & 0x4) == 0x0) and (uTimeout < 100)):
				print("Waiting for HMC7044 clock output phases to stabilise...")
				uStatus = skarab.transport.direct_spi_read(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
				uTimeout = uTimeout + 1
				time.sleep(0.01)

			# Clear the reseed bit
			skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_REQUEST_AND_MODE_CONTROL_0, 0x60)
		
			if (uTimeout == 100):
				print("InitialiseHMC7044: Timeout waiting for HMC7044 clock output phases to stabilise!")
				return PLL_UNCONFIGURED
			else:
				# Wait for PLL1 to lock
				uTimeout = 0
				uStatus = 0x20
				while (((uStatus & 0x20) == 0x20) and (uTimeout < 100)):
					print("Waiting for HMC7044 PLL1 to lock...")
					skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_CLEAR_ALARMS, 0x01)
					skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_CLEAR_ALARMS, 0x00)
					uStatus = skarab.transport.direct_spi_read(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_LATCHED_ALARM_READBACK)
					uTimeout = uTimeout + 1
					time.sleep(0.01)

				if (uTimeout == 100):
					print("InitialiseHMC7044: Timeout waiting for HMC7044 PLL1 to lock!")
					return PLL_UNCONFIGURED
				else:
					print("Finished initialiseing HMC7044...")
					return PLL_CONFIGURED

	def ConfigAdcDdcMode(self, skarab):
		"""
		Function used to configure the ADC IC (ADC32RF45/ADC32RF80) of the SKARAB ADC4x3G-14 
		in DDC mode.
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga.transport_skarab.SkarabTransport
		"""    
		
		#Function Variables
		mezzanine_site = self.mezzanine_site
		
		# Enable the ADC SYSREF outputs (FPGA SYSREF always enabled)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)
		
		print("Initialising ADCs for first Nyquist zone...")
		
		# Configure ADCs while SYSREF is enabled
		# Do a software based SYNC during initialisation so that ADCs are running
		# Full system wide SYNC must be initiated by the host when ready
		for uADCSel in range(2,4):

			# ANALOG BANK
			# GENERAL REGISTER
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_RESET, 0x81)

			# ANALOG BANK
			# ADC PAGE
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_ADC_PAGE_SEL, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_22, 0xC0)    
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_32, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_33, 0x08)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_42, 0x03)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_43, 0x03)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_45, 0x58)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_46, 0xC4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_47, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_53, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_54, 0x08)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_64, 0x05)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_72, 0x84)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_8C, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_97, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_F0, 0x38)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_F1, 0xBF)
			# ANALOG BANK
			# MASTER PAGE
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_25, 0x01)    
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_26, 0x40)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_27, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_29, 0x40)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_2A, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_2C, 0x40)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_2D, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_2F, 0x40)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_34, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_3F, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_39, 0x50)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_3B, 0x28)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_40, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_42, 0x40)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_43, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_45, 0x40)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_46, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_48, 0x40)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_49, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_4B, 0x40)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_53, 0x60)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_59, 0x02)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_5B, 0x08)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_FIXED_REG_5C, 0x07)

			# ANALOG BANK
			# ADC PAGE
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_ADC_PAGE_SEL, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_83, 0x07)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_5C, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_ADC_FIXED_REG_5C, 0x01)
		
			# ANALOG BANK
			# GENERAL REGISTER
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
		
			# DIGITAL BANK
			# OFFSET CORRECTION PAGE CHA
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x61)
			# ALLOW CORRECTION AND REMOVAL OF FS/8, ETC, SPURS
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_OFFSET_CORR_FREEZE_OFFSET_CORR, 0x42)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x01)     
			# ALLOW CORRECTION AND REMOVAL OF FS/8, ETC, SPURS   
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_OFFSET_CORR_FREEZE_OFFSET_CORR, 0x42)

			# DIGITAL BANK
			# INTERLEAVING CORRECTION SETTINGS
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x68)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00) # MAIN DIGITAL PAGE CH A    
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6042, 0x38) # GLOBAL SETTINS FOR INTERLEAVING CORRECTOR
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6043, 0x26)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6044, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6045, 0x10)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6049, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604B, 0x03)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6053, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6056, 0x75)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6057, 0x75)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605A, 0x06)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605E, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6062, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6068, 0x04)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6069, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6071, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607D, 0x03)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6080, 0x0F)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6081, 0xCB)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608B, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608C, 0x08)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608D, 0x64)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608F, 0x0C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6096, 0x0F)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6097, 0x26)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6098, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6099, 0x08)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609C, 0x08)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609D, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MAIN_DIG_PAGE_NQ_ZONE_EN, 0x08)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A5, 0x7B)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A9, 0x0B)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AA, 0x03)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AB, 0x77)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AC, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AD, 0x77)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AE, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BE, 0x03)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FF, 0xC0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MAIN_DIG_DIG_RESET, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MAIN_DIG_DIG_RESET, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MAIN_DIG_DIG_RESET, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x01) # MAIN DIGITAL PAGE CH B        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x68)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6049, 0x80) # GLOBAL SETTINS FOR INTERLEAVING CORRECTOR
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6042, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MAIN_DIG_PAGE_NQ_ZONE_EN, 0x08)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AA, 0x03)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00) # MAIN DIGITAL PAGE CH A        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MAIN_DIG_DIG_RESET, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MAIN_DIG_DIG_RESET, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MAIN_DIG_DIG_RESET, 0x00)
			time.sleep(0.1)
		
			# NON_LINEARITY TRIMS FOR NYQUIST ZONE 1 CH A
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00) # MAIN DIGITAL PAGE CH A        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0xF7)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E0, 0x07)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E1, 0xF5)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E2, 0x34)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E3, 0xE3)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E4, 0xE1)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E5, 0x24)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F7, 0x0E)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F8, 0xF5)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F9, 0x43)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FA, 0xD4)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FB, 0xD9)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FC, 0x28)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0xF8)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600E, 0x07)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600F, 0xFA)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6010, 0x2E)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6011, 0xE0)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6012, 0xE4)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6013, 0x2B)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6025, 0x0D)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6026, 0xF6)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6027, 0x3E)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6028, 0xDD)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6029, 0xD9)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x602A, 0x2A)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x603C, 0xF5)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x603D, 0x01)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x603E, 0xF0)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x603F, 0x0C)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6040, 0x0A)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6041, 0xFE)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6042, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6043, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6044, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6045, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6046, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6047, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6048, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6049, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604A, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604B, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604C, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604D, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604E, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604F, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6050, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6051, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6052, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6053, 0xF5)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6054, 0x01)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6055, 0xEE)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6056, 0x0E)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6057, 0x0B)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6058, 0xFE)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6059, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605A, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605B, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605C, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605D, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605E, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605F, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6060, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6061, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6062, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6063, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6064, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6065, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6066, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6067, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6068, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6069, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x606A, 0xF4)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x606B, 0x01)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x606C, 0xF0)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x606D, 0x0B)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x606E, 0x09)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x606F, 0xFE)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6070, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6071, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6072, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6073, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6074, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6075, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6076, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6077, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6078, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6079, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607A, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607B, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607C, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607D, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607E, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607F, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6080, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6081, 0xF5)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6082, 0x01)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6083, 0xEE)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6084, 0x0D)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6085, 0x0A)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6086, 0xFE)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6087, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6088, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6089, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608A, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608B, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608C, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608D, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608E, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608F, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6090, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6091, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6092, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6093, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6094, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6095, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6096, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6097, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6098, 0xFD)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6099, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609A, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609B, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609C, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609D, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609E, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609F, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A0, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A2, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A3, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A4, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A5, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A6, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A7, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A8, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A9, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AA, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AB, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AC, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AD, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AF, 0xFF)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B0, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B1, 0x01)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B2, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B3, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B9, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BD, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BF, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C2, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C3, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C6, 0xFE)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C9, 0x02)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CD, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CF, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D2, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D3, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D9, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DD, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DF, 0x02)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E1, 0xFE)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E2, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E3, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E9, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60ED, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EF, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F2, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F3, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FB, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FC, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FD, 0x1E)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FF, 0x06)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0xF9)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6004, 0xC0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6005, 0xB4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6006, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6008, 0xC0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6009, 0xB4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600A, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600C, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600D, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6010, 0xAA)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6012, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6048, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x61)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0xF0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6078, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607C, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6080, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608C, 0xC0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608D, 0xB4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608E, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6090, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6091, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6074, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6088, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6070, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6084, 0x00)

			# NON_LINEARITY TRIMS FOR NYQUIST ZONE 1 CH B
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0xF9)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6018, 0x15)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6019, 0xF6)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601A, 0x30)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601B, 0xE6)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601C, 0xE4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601D, 0x24)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x602F, 0x14)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6030, 0xF6)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6031, 0x36)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6032, 0xE0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6033, 0xE3)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6034, 0x27)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6046, 0x0E)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6047, 0xFA)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6048, 0x2C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6049, 0xE5)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604A, 0xE5)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604B, 0x2A)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605D, 0x17)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605E, 0xF8)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x605F, 0x2F)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6060, 0xE7)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6061, 0xE2)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6062, 0x29)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6074, 0xF4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6075, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6076, 0xEF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6077, 0x0C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6078, 0x0A)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6079, 0xFE)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607A, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607B, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607C, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607D, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607E, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607F, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6080, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6081, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6082, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6083, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6084, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6085, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6086, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6087, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6088, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6089, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608A, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608B, 0xF4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608C, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608D, 0xEE)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608E, 0x0D)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608F, 0x0A)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6090, 0xFE)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6091, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6092, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6093, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6094, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6095, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6096, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6097, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6098, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6099, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609A, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609B, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609C, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609D, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609E, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x609F, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A2, 0xF4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A3, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A4, 0xEF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A5, 0x0C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A6, 0x0A)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A7, 0xFE)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A8, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60A9, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AD, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60AF, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B2, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B3, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60B9, 0xF4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BA, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BB, 0xEF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BC, 0x0D)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BD, 0x0A)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BE, 0xFE)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60BF, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C2, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C3, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60C9, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CD, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60CF, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D0, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D2, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D3, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60D9, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DD, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60DF, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E2, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E3, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E7, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60E9, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60ED, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60EF, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F0, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F1, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F2, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F3, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F4, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F5, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F6, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F7, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F8, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60F9, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FA, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FC, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FD, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FE, 0xFE)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x60FF, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0xFA)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6000, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6001, 0x02)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6002, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6003, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6004, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6005, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6006, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6007, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6008, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6009, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600A, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600B, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600C, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600D, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600E, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x600F, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6010, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6011, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6012, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6013, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6014, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6015, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6016, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6017, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6018, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6019, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601A, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601B, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601C, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601D, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601E, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x601F, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6020, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6021, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6022, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6023, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6024, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6025, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6026, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6027, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6028, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6029, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x602A, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x602B, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x602C, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x602D, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x602E, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x602F, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6030, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6033, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6034, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6035, 0x1E)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6037, 0x06)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x603C, 0xC0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x603D, 0xB4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x603E, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6040, 0xC0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6041, 0xB4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6042, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6044, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6045, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6048, 0xAA)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x604A, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x06)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6084, 0x3F)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6086, 0x3F)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x20)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6049, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x61)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0xF1)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6078, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x607C, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6080, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608C, 0xC0)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608D, 0xB4)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x608E, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6090, 0xFF)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6091, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6074, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6088, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6070, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6084, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x4001, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x68)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x6068, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, 0x005C, 0x87)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x00)        
		
			# DIGITAL BANK
			# MAIN JESD DIGITAL PAGE
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00)        
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x69)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_SYNC_REG, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_SYNC_REG, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_sd.PLL_MODE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_sd.PLL_MODE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_CTRL_K, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_CTRL_K, 0x80)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_FRAMES_PER_MULTIFRAME, 0x0F)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_FRAMES_PER_MULTIFRAME, 0x0F)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_LINK_LAYER_TESTMODE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_LINK_LAYER_TESTMODE, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_SEL_EMP_LANE_0, 0x3C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_SEL_EMP_LANE_0, 0x3C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_SEL_EMP_LANE_1, 0x3C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_SEL_EMP_LANE_1, 0x3C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_SEL_EMP_LANE_2, 0x3C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_SEL_EMP_LANE_2, 0x3C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_SEL_EMP_LANE_3, 0x3C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_B_SEL_EMP_LANE_3, 0x3C)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_CMOS_SYNCB, 0x40) # SET FOR SINGLE ENDED SYNC
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_JESD_CHAN_A_EN_CMOS_SYNCB, 0x01) # SET FOR SINGLE ENDED SYNC
			# CH BIT MUST BE HIGH FOR THIS TO WORK SO ONLY CHAN A SET
		
			# DIGITAL BANK
			# DIRECT ADDRESSING
			# DDC PAGES
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC_EN, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DECIM_FACTOR, 0x00) # DECIMATE BY 4
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DUAL_BAND_EN, 0x00) # SINGLE BAND
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_REAL_OUT_EN, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC_MUX, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC0_NCO1_LSB, 0x55) # NCO1 = 21845 = 1GHz CF
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC0_NCO1_MSB, 0x55)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC0_NCO2_LSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC0_NCO2_MSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDCO_NCO3_LSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC0_NCO3_MSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC1_NCO4_LSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC1_NCO4_MSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_WBF_6DB_GAIN, 0x01) # USING WB DDC SO ADD 6DB GAIN
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC0_6DB_GAIN, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC1_6DB_GAIN, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_NCO_SEL_PIN, 0x00) # NCO SELECTED THROUGH SPI
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_NCO_SEL, 0x00) # NCO 1 SELECTED
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_LMFC_RESET_MODE, 0x00) # ALL DDCS AND NCOS RESET WITH EVERY LMFC
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_A_DDC_DET_LAT, 0x50) # ENSURE DETERMINISTIC LATENCY FOR DEC BY 4
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC_EN, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DECIM_FACTOR, 0x00) # DECIMATE BY 4
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DUAL_BAND_EN, 0x00) # SINGLE BAND
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_REAL_OUT_EN, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC_MUX, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC0_NCO1_LSB, 0x55) # NCO1 = 21845 = 1GHZ CF
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC0_NCO1_MSB, 0x55)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC0_NCO2_LSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC0_NCO2_MSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDCO_NCO3_LSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC0_NCO3_MSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC1_NCO4_LSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC1_NCO4_MSB, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC0_6DB_GAIN, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC1_6DB_GAIN, 0x01)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_WBF_6DB_GAIN, 0x01) # USING WB DDC SO ADD 6DB GAIN
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_NCO_SEL_PIN, 0x00) # NCO SELECTED THROUGH SPI
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_NCO_SEL, 0x00) # NCO 1 SELECTED
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_LMFC_RESET_MODE, 0x00) # ALL DDCS AND NCOS RESET WITH EVERY LMFC
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_DEC_CHAN_B_DDC_DET_LAT, 0x50) # ENSURE DETERMINISTIC LATENCY FOR DEC BY 4        
			time.sleep(0.1)
		
			# Power down SYSREF input buffer on ADCs now that synchronised
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
			skarab.transport.direct_spi_write(mezzanine_site, uADCSel, sd.ADC_MASTER_PDN_SYSREF, 0x10)

		print("Disabling SYSREF...")
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xD0)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xD0)

	def PerformAdcPllSync(self, skarab):
		"""
		Function used to synchronise the ADCs and PLL on the SKARAB ADC4x3G-14 mezzanine module.
		After syncrhonisation is performed, ADC sampling begins.
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga.transport_skarab.SkarabTransport
		"""
		
		mezzanine_site = self.mezzanine_site
		i2c_interface = mezzanine_site + 1
		
		# Get embedded software version
		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.ADC_FIRMWARE_MAJOR_VERSION_REG)
		major_version = skarab.transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)
		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.ADC_FIRMWARE_MINOR_VERSION_REG)
		minor_version = skarab.transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)
		
		# Synchronise PLL and ADC	
		skarab.write_int('pll_sync_start_in', 0)
		skarab.write_int('adc_sync_start_in', 0)
		#skarab.write_int('adc_trig', 0)	
		pll_loss_of_reference = False
		synchronise_mezzanine = [False, False, False, False]
		synchronise_mezzanine[mezzanine_site] = True

		if ((major_version == 1) and (minor_version < 3)):
			# TO DO: Implement LVDS SYSREF
			print("Synchronising PLL with LVDS SYSREF.")

			for mezzanine in range(0, 4):
				print("Checking PLL loss of reference for mezzanine: ", mezzanine)

				if synchronise_mezzanine[mezzanine] == True:

					skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.HOST_PLL_GPIO_CONTROL_REG)
					read_byte = skarab.transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)

					if ((read_byte[0] & 0x01) == 0x01):
						# PLL reporting loss of reference
						pll_loss_of_reference = True
						print("PLL reporting loss of reference.")
					else:
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xD1)

						# Enable PLL SYNC
						skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, sd.ENABLE_PLL_SYNC)

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

						skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, 0x0)

						spi_read_word = self.DirectSpiRead(skarab, mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
						timeout = 0
						while (((spi_read_word & sd.PLL_CLOCK_OUTPUT_PHASE_STATUS) == 0x0) and (timeout < 1000)):
							spi_read_word = self.DirectSpiRead(skarab, mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
							timeout = timeout + 1

						if timeout == 1000:
							print("ERROR: Timeout waiting for the mezzanine PLL outputs to be in phase.")

						# Power up SYSREF input buffer on ADCs
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_MASTER_PDN_SYSREF, 0x00)

						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_MASTER_PDN_SYSREF, 0x00)

						time.sleep(1)
						
						# Need to disable both at the same time so NCOs have same phase
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_DUAL_ADC, sd.ADC_MASTER_PDN_SYSREF, 0x10)
						
						# Disable SYSREF again
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xD0)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xD0)

		else:
			print("Synchronising PLL with LVPECL SYSREF.");
			
			# Check first to see if mezzanine has a reference clock
			for mezzanine in range(0, 4):
				print("Checking PLL loss of reference for mezzanine: ", mezzanine)

				if synchronise_mezzanine[mezzanine] == True:

					skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.HOST_PLL_GPIO_CONTROL_REG)
					read_byte = skarab.transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)

					if ((read_byte[0] & 0x01) == 0x01):
						# PLL reporting loss of reference
						pll_loss_of_reference = True
						print("PLL reporting loss of reference.")
					else:
						# Change the SYNC pin to SYNC source
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x41)

						# Change SYSREF to pulse gen mode so don't generate any pulses yet
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_FORCE_MUTE, 0x88)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_FORCE_MUTE, 0x88)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xDD)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xDD)

						# Enable PLL SYNC
						skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, sd.ENABLE_PLL_SYNC)

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
						spi_read_word = self.DirectSpiRead(skarab, mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
						timeout = 0
						while (((spi_read_word & sd.PLL_CLOCK_OUTPUT_PHASE_STATUS) == 0x0) and (timeout < 1000)):
							spi_read_word = self.DirectSpiRead(skarab, mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
							timeout = timeout + 1

						if timeout == 1000:
							print("ERROR: Timeout waiting for the mezzanine PLL outputs to be in phase.")

				# Synchronise ADCs to SYSREF next
				for mezzanine in range(0, 4):
					print("Using SYSREF to synchronise ADC on mezzanine: ", mezzanine)
					
					if synchronise_mezzanine[mezzanine] == True:
						# Change the SYNC pin to pulse generator
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x81)

						# Power up SYSREF input buffer on ADCs
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_MASTER_PDN_SYSREF, 0x00)

						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_MASTER_PDN_SYSREF, 0x00)

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
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_MASTER_PDN_SYSREF, 0x10)
						skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_MASTER_PDN_SYSREF, 0x10)

		# At this point, all the PLLs across all mezzanine sites should be in sync

		# Enable the ADC SYNC
		for mezzanine in range(0, 4):
			if synchronise_mezzanine[mezzanine] == True:
				print("Enabling ADC SYNC on mezzanine: ", mezzanine)

				skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, sd.ENABLE_ADC_SYNC)

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

				skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, 0x0)
		
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
		
		mezzanine_site = self.mezzanine_site
		i2c_interface = mezzanine_site + 1
		gain_channel = sd.ADC_GAIN_CHANNEL_0
		 
		if adc_input == 0:
			gain_channel = sd.ADC_GAIN_CHANNEL_0
		elif adc_input == 1:
			gain_channel = sd.ADC_GAIN_CHANNEL_1
		elif adc_input == 2:
			gain_channel = sd.ADC_GAIN_CHANNEL_2
		else:
			gain_channel = sd.ADC_GAIN_CHANNEL_3

		print("Configuring gain.")
		gain_control_word = (-1 * gain) + 15

		write_byte = gain_channel | (gain_control_word << 2) | sd.UPDATE_GAIN

		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.GAIN_CONTROL_REG, write_byte)

		skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.GAIN_CONTROL_REG)

		read_byte = skarab.transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)

		timeout = 0

		while (((read_byte[0] & UPDATE_GAIN) != 0) and (timeout < 1000)):
			skarab.transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.GAIN_CONTROL_REG)
			read_byte = skarab.transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)
			timeout = timeout + 1

		if timeout == 1000:
			print("ERROR: Timeout waiting for configure gain to complete!")
	
	def EnableAdcRampData(self, skarab):

		"""
		Function used to configure the SKARAB ADC4x3G-14 mezzanine module to produce a ramp pattern.		
		
		:param skarab: The casperfpga object created for the SKARAB.
		:type skarab: casperfpga
		"""
		
		# Configure ADC in ramp pattern mode (Decimation Mode)

		mezzanine_site = self.mezzanine_site

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x5839, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x5837, 0x44) # Pattern Code for ChB: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x5838, 0x44) # Pattern Code for ChB: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x583A, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x583A, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x583A, 0x03)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x583A, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x5039, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x5037, 0x44) # Pattern Code for ChA: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x5038, 0x44) # Pattern Code for ChA: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x503A, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x503A, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x503A, 0x03)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, 0x503A, 0x00)

		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x5839, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x5837, 0x44) # Pattern Code for ChB: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x5838, 0x44) # Pattern Code for ChB: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x583A, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x583A, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x583A, 0x03)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x583A, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x5039, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x5037, 0x44) # Pattern Code for ChA: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x5038, 0x44) # Pattern Code for ChA: all_0=0x11, all_1=0x22, toggle(16h'AAAA/16h'5555)=0x33, Ramp=0x44, custom_single_pattern1=0x66, custom_double_pattern1&2=0x77
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x503A, 0x00)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x503A, 0x01)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x503A, 0x03)
		skarab.transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, 0x503A, 0x00)

		return


# Connect to SKARAB and upload .fpg file
skarab = casperfpga.CasperFpga('10.0.0.24')
skarab.upload_to_ram_and_program('tut_spec.fpg')
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
print(("ADC0 Q:", read_value))
read_value = skarab.read_int('adc0_data_i_out0')
print(("ADC0 I:", read_value))
read_value = skarab.read_int('pll_sync_complete_out')
print(("PLL SYNC:", read_value))
read_value = skarab.read_int('adc_sync_complete_out')
print(("ADC SYNC:", read_value))
read_value = skarab.read_int('adc_data_val_out')
print(("ADC data val:", read_value))

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
