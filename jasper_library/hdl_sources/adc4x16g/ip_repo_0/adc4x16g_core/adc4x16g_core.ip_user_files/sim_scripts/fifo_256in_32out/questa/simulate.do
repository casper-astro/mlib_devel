onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_256in_32out_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_256in_32out.udo}

run -all

quit -force
