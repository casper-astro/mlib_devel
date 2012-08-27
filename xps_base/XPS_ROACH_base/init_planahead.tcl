hdi::project new -name p1 -dir ./planahead_proj/p1 -netlist ./implementation/system.ngc -search_path ./XPS_ROACH_base/implementation/
hdi::project setPart -name p1 -part {xc5vsx95tff1136-2}
hdi::floorplan new -name floorplan_1 -part {xc5vsx95tff1136-2}  -project p1
hdi::pconst import -project p1 -floorplan floorplan_1 -file ./implementation/system.ucf
hdi::floorplan importPlacement -floorplan floorplan_1 -project p1 -file ./implementation/system.ncd
hdi::timing import -name results_1 -project p1 -floorplan floorplan_1 -file ./implementation/system.twx
hdi::floorplan save -name floorplan_1 -project p1
