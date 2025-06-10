README.txt: COEN313 Digital Design Project

Name: Fabio Binu Koshy
ID: 40231803
Date: Winter 2025-04-04

File Description:

1) Fabio_BinuKoshy_40231803: Is the report of the COEN313 Project in the pdf form.

2) Projectwf: Is the PostScript waveform of my Modelsim after running my codes.

3) room_occupancy_monitor.vhd: Contains the main VHDL code for the room occupancy monitoring system.

4) Synthesis_Schematic.pdf: Is the synthesis schematic downloaded as pdf.

5) RTL_Schematic.pdf: is the RTL schematic downloaded as pdf.

6) tb_room_occupancy_monitor.vhd: Contains the testbench for verifying the functionality of room_occupancy_monitor.

7) Vivado Log files: The runme.log file from both the implementation and synthesis folder under runs folder is downloaded 


Execution Instructions:

Modelsim:
1. Create a folder on linux and download my room_occupancy_monitor.vhd and tb_room_occupancy_monitor.vhd into it.2. Open terminal and run the following command: source /CMC/ENVIRONMENT/modelsim.env
3. Next step is to compile both .vhd files using vcom
4. Next steps is to simulate the testbench file using the following command: vsim tb_room_occupancy_monitor
5. This opens Modelsim. Next steps is to add the all inputs into the waveform region and then running the following command inside modelsim: run -all

Xilinx Vivado:
1.Run the following command on linux terminal: source /CMC/tools/xilinx/Vivado_2018.2/Vivado/2018.2/settings64_CMC_central_license.csh
2.Run this next command : Vivado &
3.Create a new RTL project, add the room_occupancy_monitor.vhd file. Set the device to: device: xc7a100tcsg324-1.
4.Set room_occupancy_monitor.vhd as the top in Project manger pane.
5.You can now run the simulation, synthesis and implementation and get the schematics as well.
 