import casperfpga,time

#Tutorial HMC (SKARAB) Python Script to read back the HMC snap shot data and the registers

#parameters
#snapshot read length (can be adjusted)
read_length = 600; 


#Connecting to the SKARAB
print('connecting to SKARAB...')
f=casperfpga.CasperFpga('192.168.14.70')
print('done')

#program the SKARAB
print('programming the SKARAB...')
f.upload_to_ram_and_program('top_tut_hmc_2018_2_rev1.fpg')
print('done')

#Set the data rate control
#False = write and read every 2nd clock cycle (HMC can handle the data rate: 230MHz x 256 bits/2 = 29.44Gbps)
#True = write and read every clock cycle (HMC can't handle the data rate: 230MHz x 256 bits = 58.88Gbps)
f.registers.reg_cntrl.write(data_rate_sel= False)

#arm the snap shots
print('arming snapshot blocks...')
f.snapshots.hmc_in_snap_ss.arm()
f.snapshots.hmc_out_snap_ss.arm()
f.snapshots.hmc_reorder_snap_ss.arm()
print('done')

#start the snap shot triggering and reset the counters
print('triggering the snapshots and reset the counters...')
f.registers.reg_cntrl.write(rst = 'pulse')
print('done')

#wait a few seconds for triggering 
#time.sleep(2)

#enable the HMC write and read process
print('enabling the HMC write and read process...')
f.registers.reg_cntrl.write(wr_rd_en= True)
print('done')

#wait a few seconds for snap shots to fill
#time.sleep(3)

#grab the snapshots
print('reading the snapshots...')
hmc_in = f.snapshots.hmc_in_snap_ss.read(arm=False)['data'] 
hmc_out = f.snapshots.hmc_out_snap_ss.read(arm=False)['data']
hmc_reorder = f.snapshots.hmc_reorder_snap_ss.read(arm=False)['data']
print('done')

#disable the HMC write ad read process
print('disabling the HMC write and read process...')
f.registers.reg_cntrl.write(wr_rd_en = False)
print('done')

#read back the status registers
print('reading back the status registers...')

print("hmc rd cnt:",f.registers.hmc_rd_cnt.read_uint())
print("hmc wr cnt:",f.registers.hmc_wr_cnt.read_uint())
print("hmc out cnt:",f.registers.hmc_out_cnt.read_uint())
print("hmc wr err:",f.registers.hmc_wr_err.read_uint())
print("hmc rd err:",f.registers.hmc_rd_err.read_uint())
print("hmc status:",f.registers.hmc_status.read_uint())

print('done')
#read back the snapshot captured data
print('Displaying the snapshot block data...')
print('HMC SNAPSHOT CAPTURED INPUT')
print('-----------------------------')
print('Num wr_en wr_addr wr_data wr_rdy rd_en rd_addr rd_tag rd_rdy') 
for i in range(0, read_length):
  print('[%i] %i %i %i %i %i %i %i %i'% \
                                      (i, hmc_in['wr_en'][i], hmc_in['wr_addr'][i], \
                                       hmc_in['data'][i], hmc_in['wr_rdy'][i], \
                                       hmc_in['rd_en'][i], hmc_in['rd_addr'][i], \
                                        hmc_in['tag'][i], hmc_in['rd_rdy'][i] ))
#print 'write enable:'
#print hmc_in['wr_en'][0:read_length]
#print 'write address:'
#print hmc_in['wr_addr'][0:read_length]
#print 'write data:'
#print hmc_in['data'][0:read_length]
#print 'write ready:'
#print hmc_in['wr_rdy'][0:read_length]
#print 'read enable:'
#print hmc_in['rd_en'][0:read_length]
#print 'read address:'
#print hmc_in['rd_addr'][0:read_length]
#print 'read tag:'
#print hmc_in['tag'][0:read_length]
#print 'read ready:'
#print hmc_in['rd_rdy'][0:read_length]
print('HMC SNAPSHOT CAPTURED OUTPUT')
print('-----------------------------')
print('Num hmc_read_tag_out hmc_data_out')
for i in range(1, read_length):
  print('[%i] %i %i'%(i, hmc_out['tag'][i], hmc_out['data'][i] ))
#print 'hmc data out:'
#print hmc_out['data'][0:read_length]
#print 'hmc read tag out:'
#print hmc_out['tag'][0:read_length]
print('HMC REORDER SNAPSHOT CAPTURED OUTPUT')
print('-------------------------------------')
print('Num rd_en rd_addr data_out')
for i in range(1, read_length):
  print('[%i] %i %i %i'%(i, hmc_reorder['rd_en'][i], hmc_reorder['rd_addr'][i], hmc_reorder['data'][i] ))
#print 'hmc reorder output enable:'
#print hmc_reorder['rd_en'][0:read_length]
#print 'hmc reorder output address:'
#print hmc_reorder['rd_addr'][0:read_length]
#print 'hmc reorder output data:'
#print hmc_reorder['data'][0:read_length]
print('done')





