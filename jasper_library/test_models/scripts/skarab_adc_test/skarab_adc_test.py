#--------------------------------------------------------------------------------------
# COMPANY              : PERALEX ELECTRONICS (PTY) LTD
#--------------------------------------------------------------------------------------
# COPYRIGHT NOTICE :
#
# The copyright, manufacturing and patent rights stemming from this document
# in any form are vested in PERALEX ELECTRONICS (PTY) LTD.
#
# (c) PERALEX ELECTRONICS (PTY) LTD 2021
#
# PERALEX ELECTRONICS (PTY) LTD has ceded these rights to its clients
# where contractually agreed.
#--------------------------------------------------------------------------------------
# DESCRIPTION :
#
# This script uploads an fpg file to a one or more SKARAB systems that contain one 
# or more SKARAB ADC boards, and then captures and stores synchronised ADC sample data.
# The user of this script needs to provide the test parameters under the "2. SCRIPT 
# CONFIG" code section. Some of these test parameters include the IPs of the
# SKARAB systems used in the test, the directory of the fpg file to upload to them, 
# and the channels of the SKARAB ADC boards to plot data from. The script then uses 
# the provided test parameters along with the information in the fpg file to 
# (automatically) identify the Master and Slave SKARAB ADC boards (if any) among the 
# SKARAB systems, their corresponding SKARAB ADC Yellow Blocks and their bandwidth 
# modes (DDC or Bypass). The script then uses the identified information to create a 
# SkarabAdc object (from the casperfpga Python library) for each SKARAB ADC board. 
# These objects are used to provide a simple means of controlling and configuring the
# SKARAB ADC boards so that synchronised sample data can be captured. Finally, the 
# sample data is written to text files so that it can be plotted/examined.
#	
# Prerequisites:
# - Ensure that all of the steps listed in the SKARAB ADC Board Read the Docs 
#   tutorial was understood and followed:
#     https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/
#     tutorials/skarab/tut_adc.html
# - Ensure that the script configuration under "2. SCRIPT CONFIG" is set 
#   according to the hardware setup requirements
#
# casperfpga Python Library Information:
#   For more information on the casperfpga functions used in this script, please 
#   review the skarabadc.py source file in the casperfpga library sources:
#     https://github.com/ska-sa/casperfpga/tree/peralex_adc/src/skarabadc.py
# Sample data plotting
# - When using the Bypass bandwidth mode, the sample data of each ADC channel is 
#   stored in a separate text file under the adc_data_byp directory. The naming
#   convention is as follows:
#     sk<SKARAB Index>_sa<Index of ADC Board in SKARAB>_ch<ADC Channel Index>.txt
#     Examples: sk0_sa1_ch2.txt
#               sk1_sa0_ch3.txt
#     The plot_adc_data_byp.m MATLAB script can be used to plot the sample data.
# - When using the DDC bandwidth mode, the I and Q sample data of each ADC channel 
#   is stored in a separate text file under the adc_data_ddc directory. The naming
#   convention is as follows:
#     sk<SKARAB Index>_sa<Index of ADC Board in SKARAB>_ch<ADC Channel Index>_<i or q>.txt
#     Examples: sk0_sa1_ch2_i.txt
#               sk0_sa1_ch2_q.txt
#               sk1_sa0_ch3_i.txt
#               sk1_sa0_ch3_q.txt
#     The plot_adc_data_ddc.m MATLAB script can be used to plot the sample data.
#
# Prebuilt fpg files:
#   A set of prebuilt fpg files are provided under https://github.com/ska-sa/
#   mlib_devel/tree/peralex_adc/jasper_library/test_models/scripts/
#   skarab_adc_test/fpg_files. These fpg files include the following:
#     - One Bypass Mode Yellow Block for mezzanine site 1 with the User IP clock
#       source as sys_clk 
#         test_skarab_adc_byp_sysclk.fpg
#     - One Bypass Mode Yellow Block for mezzanine site 1 with the User IP clock
#       source as adc_clk 
#         test_skarab_adc_byp_adcclk.fpg
#     - One DDC Mode Yellow Block for mezzanine site 1 with the User IP clock
#       source as sys_clk 
#         test_skarab_adc_sysclk.fpg
#     - One DDC Mode Yellow Block for mezzanine site 1 with the User IP clock
#       source as adc_clk 
#         test_skarab_adc_adcclk.fpg
#     - Two Bypass Mode Yellow Blocks for mezzanine site 1 (Master) and site 0 (Slave)
#       with the User IP clock source as adc_clk 
#         test_skarab_adc_byp_x2_adcclk.fpg
#     - Two Bypass Mode Yellow Blocks for mezzanine site 1 (Master) and site 0 (Slave)
#       with the User IP clock source as sys_clk 
#         test_skarab_adc_byp_x2_sysclk.fpg
#     - Two DDC Mode Yellow Blocks for mezzanine site 1 (Master) and site 0 (Slave)
#       with the User IP clock source as adc_clk 
#         test_skarab_adc_x2_adcclk.fpg
#     - Two DDC Mode Yellow Blocks for mezzanine site 1 (Master) and site 0 (Slave)
#       with the User IP clock source as sys_clk 
#         test_skarab_adc_x2_sysclk.fpg
#    
#--------------------------------------------------------------------------------------

import casperfpga
from casperfpga import skarab_definitions as sd
import sys
import os.path
from os import path

# -----------------------------------------------------------------
# 1. PRINT TEST HEADER
# -----------------------------------------------------------------
print("-------------------------------------")
print("SKARAB ADC SYNCHRONISED SAMPLING TEST")
print("-------------------------------------")

# -----------------------------------------------------------------
# 2. SCRIPT CONFIG
# -----------------------------------------------------------------
# 2.1 SET THE FPG FILE DIRECTORY
fpg_file_dir = "fpg_files/test_skarab_adc_byp_sysclk.fpg"

# 2.2 ENABLE FPG FILE UPLOAD OR NOT 
# - If the fpg file is already uploaded it is not required to 
#   do it again. This allows the script to execute faster.
upload_fpg_file = 'y' # Other options: 'n'

# 2.3 SET THE SKARAB IP(s)
# - If there are more than one SKARAB systems in the hardware setup, 
#   the IP of the Master SKARAB system should be listed first
#   (leftmost). The SKARAB ADC board that has a corresponding
#   Master SKARAB ADC Yellow Block in the fpg file uploaded to 
#   its SKARAB system will be the master while all other SKARAB ADC 
#   boards in the hardware setup will be the slaves.
skarab_ips = ['10.0.7.3', '10.0.7.4'] # Other options: ['10.0.7.3']; etc

# 2.4 SET THE NYQUIST ZONE FOR WHICH THE SKARAB ADC BOARDS SHOULD BE OPTIMISED
# - Available Options: sd.FIRST_NYQ_ZONE  (First Nyquist zone)
#                      sd.SECOND_NYQ_ZONE (Second Nyquist zone)
nyquist_zone = sd.FIRST_NYQ_ZONE # Other options: sd.SECOND_NYQ_ZONE

# 2.5 SET THE SKARAB ADC BOARD DATA MODE 
# - Available Options: sd.ADC_DATA_MODE:  Default ADC sample data mode
#                      sd.RAMP_DATA_MODE: Ramp pattern test mode
# - Note that if the data mode is set to RAMP MODE, the 
#   ramp patterns will not be synchronised since the ramp pattern 
#   generators of the SKARAB ADC boards are not synchronised.
data_mode=sd.ADC_DATA_MODE # Other options: sd.RAMP_DATA_MODE

# 2.6 SET THE GAIN OF THE SKARAB ADC BOARD AMPLIFIERS
# - Available gain options (dB): -6 to 15 (must be integers)
#   where [ch0 gain, ch1 gain, ch2 gain, ch3 gain]
channels_gain = [15, 15, 15, 15] # Other options: [0, -6, 0, -6]; etc

# 2.7 SET THE DDC CENTRE FREQUENCY
# - This only has effect when the SKARAB ADC boards are used 
#   in the DDC bandwidth mode.
# - Note that the accuracy of the DDC frequency is limited by
#   a 16-bit register value. Please review the skarabadc.py
#   source file from the casperfpga library for more 
#   information.
channels_ddc_centre_freq = 1000000000 # Other options: 400000000; etc

# 2.8 SET THE CHANNELS (0 TO 3) THAT SHOULD BE INCLUDED IN TEST
channels_to_test = [0, 1, 2, 3] # Other options: [0]; [0, 2]; etc

# -----------------------------------------------------------------
# 3. CONNECT TO SKARAB HARDWARE AND UPLOAD FPG FILE
# -----------------------------------------------------------------
if upload_fpg_file == 'y':
	print("------------------")
	print("UPLOAD FPG FILE(s)")
	print("------------------")
skarab_num = len(skarab_ips)
skarabs = [None] * 4
for i in range(skarab_num):
	skarabs[i] = casperfpga.CasperFpga(skarab_ips[i])
	if upload_fpg_file == 'y':
		skarabs[i].upload_to_ram_and_program(fpg_file_dir)
	else:
		skarabs[i].get_system_information(fpg_file_dir)
if upload_fpg_file == 'y':
	print("FPG files uploaded to SKARAB(s) successfully")
raw_input("Press Enter to continue with the ADC data captures")

# -----------------------------------------------------------------
# 4. DETERMINE TEST PARAMATERS
# - Note that the Yellow Block tags are used to identify the  
#   SKARAB ADC Yellow Blocks from the fpg file
#     DDC Mode SKARAB ADC Yellow Block tag: xps:skarab_adc4x3g_14
#     Bypass Mode SKARAB ADC Yellow Block tag: xps:skarab_adc4x3g_14
# -----------------------------------------------------------------
# 4.1 GET NUMBER OF ADCS PER SKARAB
adcs_per_skarab_num = 0
for memory_device_name in skarabs[0].memory_devices:
	memory_device = skarabs[0].memory_devices[memory_device_name]
	if hasattr(memory_device, 'device_info'):
		if memory_device.device_info['tag'] == 'xps:skarab_adc4x3g_14' or memory_device.device_info['tag'] == 'xps:skarab_adc4x3g_14_byp':
			adcs_per_skarab_num = adcs_per_skarab_num + 1
if adcs_per_skarab_num == 0:
	print("ERROR: No SKARAB ADC Yellow Blocks found in uploaded design")
	exit()

# 4.2 GET SKARAB ADC YELLOW BLOCK NAMES AND MEZZANINE SITES
skarab_adc_yb_names = [None] * adcs_per_skarab_num
skarab_mez_sites = [None] * adcs_per_skarab_num
itr = 0
device_tag = ''
for memory_device_name in skarabs[0].memory_devices:
	memory_device = skarabs[0].memory_devices[memory_device_name]
	if hasattr(memory_device, 'device_info'):
		if memory_device.device_info['tag'] == 'xps:skarab_adc4x3g_14' or memory_device.device_info['tag'] == 'xps:skarab_adc4x3g_14_byp':
			if memory_device.master_slave == 'Master':
				device_tag = memory_device.device_info['tag']
				skarab_adc_yb_names[itr] = memory_device.name
				skarab_mez_sites[itr] = memory_device.mezzanine_site
				itr = itr + 1
for memory_device_name in skarabs[0].memory_devices:
	memory_device = skarabs[0].memory_devices[memory_device_name]
	if hasattr(memory_device, 'device_info'):
		if memory_device.device_info['tag'] == 'xps:skarab_adc4x3g_14' or memory_device.device_info['tag'] == 'xps:skarab_adc4x3g_14_byp':
			if memory_device.master_slave == 'Slave':
				skarab_adc_yb_names[itr] = memory_device.name
				skarab_mez_sites[itr] = memory_device.mezzanine_site
				itr = itr + 1				

# 4.3 GET NUMBER of SKARAB ADC Yellow BLOCKS PER SKARAB
skarab_adc_yb_per_skarab_num = len(skarab_adc_yb_names)

# 4.4 GET NUMBER OF SKARABS
skarab_adc_num = skarab_num * adcs_per_skarab_num

# 4.5 GET USER IP CLOCK SOURCE
user_ip_clock_source = skarabs[0].system_info['clk_src']

# -----------------------------------------------------------------
# 5 CREATE SKARAB ADC OBJECT FOR EACH SKARAB ADC BOARD
# ----------------------------------------------------------------- 
# 5.1 CREATE SKARAB ADC OBJECTS
skarab_adcs = [None]*skarab_adc_num
for i in range(skarab_num):
	for j in range(adcs_per_skarab_num):
		skarab_adcs[adcs_per_skarab_num*i+j] = skarabs[i].memory_devices[skarab_adc_yb_names[j]]

# 5.2 CREATE SKARAB ADC SLAVE OBJECTS
skarab_adc_slaves = []
if skarab_adc_num > 1:
	skarab_adc_slave_num = skarab_adc_num-1
	skarab_adc_slaves = [None]*skarab_adc_slave_num
	for i in range(skarab_adc_slave_num):
		skarab_adc_slaves[i]=skarab_adcs[i+1]
yb_type = skarab_adcs[0].yb_type

# -----------------------------------------------------------------
# 6. CONFIGURE SKARAB ADC BOARD
# - Note that the configure_skarab_adc function automatically 
#   determines the bandwidth (sampling) mode for which the SKARAB   
#   ADC board(s) need to be configured based on the specific SKARAB   
#   ADC Yellow Block in the fpg file. Thus, no argument except the   
#   Nyquist zone is provided.
# -----------------------------------------------------------------
print("")
print("------------------------")
print("SETTING UP SKARAB ADC(s)")
print("------------------------")
print("Configuring SKARAB ADC boards...")
for i in range(skarab_adc_num):
	skarab_adcs[i].configure_skarab_adc(nyquist_zone)

# -----------------------------------------------------------------
# 7. SET DATA MODE
# -----------------------------------------------------------------
print("Setting data mode of SKARAB ADC boards...")
for i in range(skarab_adc_num):
	skarab_adcs[i].set_skarab_adc_data_mode(data_mode)

# -----------------------------------------------------------------
# 8. SET CHANNEL GAIN
# -----------------------------------------------------------------
print("Setting channel gain of SKARAB ADC boards...")
for i in range(skarab_adc_num):
	for j in range(4):
		skarab_adcs[i].set_skarab_adc_channel_gain(j, channels_gain[j])

# -----------------------------------------------------------------
# 9. SET DDC FREQUENCY
# - Note that the DDCs are tuned to 1 GHz by default, and 
#   thus, it is not required to run this function to set it 
#   again if this is already the desired DDC frequency.
# -----------------------------------------------------------------
actual_channels_ddc_centre_freq = 0
if yb_type == sd.YB_SKARAB_ADC4X3G_14:
	print("Setting DDC centre frequency of SKARAB ADC boards...")
	for i in range(skarab_adc_num):
		for j in range(4):
			actual_channels_ddc_centre_freq = skarab_adcs[i].configure_skarab_adc_ddcs(j, channels_ddc_centre_freq)[0]

# -----------------------------------------------------------------
# 10. RESET ALL SNAPSHOT BLOCK CAPTURE COMPONENTS
# -----------------------------------------------------------------
# 10.1 IF THE USER IP CLOCK SOURCE IS SET TO SYS_CLK, RESET THE 
#      SKARAB ADC BOARDS BEFORE ARMING SNAPSHOT COMPONENTS
if user_ip_clock_source == 'sys_clk':
	for i in range(skarab_adc_num):
		skarab_adcs[i].reset_skarab_adc()

# 10.2 ARM ALL SNAPSHOT BLOCK CAPTURE COMPONENTS
for i in range(skarab_num):
	skarabs[i].write_int('clr_bc', 1)
	skarabs[i].write_int('clr_bc', 0)
	for snapshot in skarabs[i].snapshots:
		if "adc" in snapshot.name:
			snapshot.arm()

# 10.3 IF THE USER IP CLOCK SOURCE IS SET TO ADC_CLK, RESET THE 
#      SKARAB ADC BOARDS AFTER ARMING SNAPSHOT COMPONENTS
if user_ip_clock_source == 'adc_clk':
	for i in range(skarab_adc_num):
		skarab_adcs[i].reset_skarab_adc()

# -----------------------------------------------------------------
# 11. PERFORM A SYNCHRONISED CAPTURE
# -----------------------------------------------------------------
print("")
print("----------------")
print("ADC DATA CAPTURE")
print("----------------")
skarab_adcs[0].sync_skarab_adc(skarab_adc_slaves)

# -----------------------------------------------------------------
# 12. PRINT TEST PARAMETERS
# -----------------------------------------------------------------
print("")
print("---------------")
print("TEST PARAMETERS")
print("---------------")

print(str("FPG file directory: " + str(fpg_file_dir)))

print(str("Number of SKARABS: " + str(skarab_num)))

print(str("SKARAB IP(s): " + str(skarab_ips).strip('[]')))

print(str("Number of SKARAB ADCs per SKARAB: " + str(adcs_per_skarab_num)))

print(str("SKARAB ADC Yellow Block Names: " + str(skarab_adc_yb_names).strip('[]')))

print(str("SKARAB ADC Mezzanine Sites: " + str(skarab_mez_sites).strip('[]')))

if yb_type == sd.YB_SKARAB_ADC4X3G_14:
	print("SKARAB ADC Yellow Block type: 3 GHz, dec-by-4, DDC mode (YB_SKARAB_ADC4X3G_14)")
elif yb_type == sd.YB_SKARAB_ADC4X3G_14_BYP:
	print("SKARAB ADC Yellow Block type: 2.8 GHz, full-bandwidth   (YB_SKARAB_ADC4X3G_14_BYP)")

print(str("Total Number of SKARAB ADCs: " + str(skarab_adc_num)))

if user_ip_clock_source == 'sys_clk':
	print("User IP clock source: SYS_CLK")
elif user_ip_clock_source == 'adc_clk':
	print("User IP clock source: ADC_CLK")

if yb_type == sd.YB_SKARAB_ADC4X3G_14:
	print(str("Specified DDC Centre Frequency: " + str(channels_ddc_centre_freq)))
	print(str("Actual DDC Centre Frequency: " + str(actual_channels_ddc_centre_freq)))

if nyquist_zone == sd.ADC_DATA_MODE:
	print("SKARAB ADC data mode: ADC DATA")
elif nyquist_zone == sd.RAMP_DATA_MODE:
	print("SKARAB ADC data mode: Ramp")
	
print(str("Channel 0 gain (dB): " + str(channels_gain[0])))
print(str("Channel 1 gain (dB): " + str(channels_gain[1])))
print(str("Channel 2 gain (dB): " + str(channels_gain[2])))
print(str("Channel 3 gain (dB): " + str(channels_gain[3])))

if nyquist_zone == sd.FIRST_NYQ_ZONE:
	print("Nyquist zone optimisation: First")
elif nyquist_zone == sd.SECOND_NYQ_ZONE:
	print("Nyquist zone optimisation: Second")

# -----------------------------------------------------------------
# 13. GET SYNCHRONISED SAMPLE DATA FROM SNAPSHOT BLOCK CAPTURE
#     COMPONENTS
# -----------------------------------------------------------------
sample_data_array_i = []
sample_data_array_q = []
sample_data_array_n = []
sample_data_arrays_num = 0
for skarab_index in range(skarab_num):
	for yb_index in range(adcs_per_skarab_num):
		for ch_index in channels_to_test:
			sample_data_i = []
			sample_data_q = []
			sample_data_n = 'sk' + str(skarab_index) + '_sa' + str(yb_index) + '_ch' + str(ch_index)

			if yb_type == sd.YB_SKARAB_ADC4X3G_14:
				snapshot_name_l = ''
				if adcs_per_skarab_num > 1:
					snapshot_name_l = 'sa' + str(yb_index) + '_adc' + str(ch_index) + '_bc_ss'
				else:
					snapshot_name_l = 'adc' + str(ch_index) + '_bc_ss'
				sample_array = skarabs[skarab_index].snapshots[snapshot_name_l].read(arm=False)['data']
				
				for j in range(1024):
					sample_data_i.append(sample_array['i_0'][j] )
					sample_data_i.append(sample_array['i_1'][j] )
					sample_data_i.append(sample_array['i_2'][j] )
					sample_data_i.append(sample_array['i_3'][j] )
					sample_data_q.append(sample_array['q_0'][j] )
					sample_data_q.append(sample_array['q_1'][j] )
					sample_data_q.append(sample_array['q_2'][j] )
					sample_data_q.append(sample_array['q_3'][j] )
			
			elif yb_type == sd.YB_SKARAB_ADC4X3G_14_BYP:
				snapshot_name_l = ''
				snapshot_name_h = ''
				if adcs_per_skarab_num > 1:
					snapshot_name_l = 'sa' + str(yb_index) + '_adc' + str(ch_index) + '_bc_l_ss'
					snapshot_name_h = 'sa' + str(yb_index) + '_adc' + str(ch_index) + '_bc_h_ss'
				else:
					snapshot_name_l = 'adc' + str(ch_index) + '_bc_l_ss'
					snapshot_name_h = 'adc' + str(ch_index) + '_bc_h_ss'
				sample_array_l = skarabs[skarab_index].snapshots[snapshot_name_l].read(arm=False)['data']
				sample_array_h = skarabs[skarab_index].snapshots[snapshot_name_h].read(arm=False)['data']
				
				for j in range(256):
					sample_data_i.append(sample_array_l['d0'][j] )
					sample_data_i.append(sample_array_l['d1'][j] )
					sample_data_i.append(sample_array_l['d2'][j] )
					sample_data_i.append(sample_array_l['d3'][j] )
					sample_data_i.append(sample_array_l['d4'][j] )
					sample_data_i.append(sample_array_l['d5'][j] )
					sample_data_i.append(sample_array_l['d6'][j] )
					sample_data_i.append(sample_array_l['d7'][j] )
					sample_data_i.append(sample_array_h['d8'][j] )
					sample_data_i.append(sample_array_h['d9'][j] )
					sample_data_i.append(sample_array_h['d10'][j])
					sample_data_i.append(sample_array_h['d11'][j])
					sample_data_i.append(sample_array_h['d12'][j])
					sample_data_i.append(sample_array_h['d13'][j])
					sample_data_i.append(sample_array_h['d14'][j])
					sample_data_i.append(sample_array_h['d15'][j])
			
			sample_data_array_i.append(sample_data_i)
			sample_data_array_q.append(sample_data_q)
			sample_data_array_n.append(sample_data_n)
			sample_data_arrays_num = sample_data_arrays_num + 1

# -----------------------------------------------------------------
# 14. WRITE CAPTURED ADC DATA TO FILES
# - Note that the sample values are floating point values 
#   that vary from -1.0 to 1.0 
# -----------------------------------------------------------------
if yb_type == sd.YB_SKARAB_ADC4X3G_14:
	for i in range(sample_data_arrays_num):
		adc_samples_file_i = open(str('adc_data_ddc/'+sample_data_array_n[i]+'_i.txt'), "w")
		adc_samples_file_q = open(str('adc_data_ddc/'+sample_data_array_n[i]+'_q.txt'), "w")
		for j in range(len(sample_data_array_i[i])):
			adc_samples_file_i.write(str(sample_data_array_i[i][j])+str('\n'))
			adc_samples_file_q.write(str(sample_data_array_q[i][j])+str('\n'))
		adc_samples_file_i.close()
		adc_samples_file_q.close()
elif yb_type == sd.YB_SKARAB_ADC4X3G_14_BYP:
	for i in range(sample_data_arrays_num):
		adc_samples_file = open(str('adc_data_byp/'+sample_data_array_n[i]+'.txt'), "w")
		for j in range(len(sample_data_array_i[i])):
			adc_samples_file.write(str(sample_data_array_i[i][j])+str('\n'))
		adc_samples_file.close()

# -----------------------------------------------------------------
# 15. PRINT TEST FOOTER
# -----------------------------------------------------------------
print("----------------------------------------------")
print("SKARAB ADC SYNCHRONISED SAMPLING TEST COMPLETE")
print("----------------------------------------------")