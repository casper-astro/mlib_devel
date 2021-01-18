onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib gtwizard_ultrascale_2_opt

do {wave.do}

view wave
view structure
view signals

do {gtwizard_ultrascale_2.udo}

run -all

quit -force
