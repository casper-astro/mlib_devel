onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+blk_mem_gen_0 -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_3 -O5 xil_defaultlib.blk_mem_gen_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {blk_mem_gen_0.udo}

run -all

endsim

quit -force
