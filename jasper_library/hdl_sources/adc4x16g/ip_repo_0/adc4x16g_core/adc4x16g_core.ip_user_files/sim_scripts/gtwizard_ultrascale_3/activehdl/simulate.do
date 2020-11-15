onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+gtwizard_ultrascale_3 -L xpm -L gtwizard_ultrascale_v1_7_7 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.gtwizard_ultrascale_3 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {gtwizard_ultrascale_3.udo}

run -all

endsim

quit -force
