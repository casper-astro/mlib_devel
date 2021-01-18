onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib gtwizard_ultrascale_0_opt

do {wave.do}

view wave
view structure
view signals

do {gtwizard_ultrascale_0.udo}

run -all

quit -force
