
#################
#DEFAULT CLOCK CONSTRAINTS

############################################################
# Clock Period Constraints                                 #
############################################################



#-----------------------------------------------------------
# PCS/PMA Clock period Constraints: please do not relax    -
#-----------------------------------------------------------

create_clock -name gtrefclk -period 8.000 [get_ports gtrefclk_p]


create_clock -name independent_clock_bufg -period 5.000 [get_ports independent_clock_bufg]



