# 🚪 Room Occupancy Monitor - COEN 313

## 📌 About the Project
This digital system monitors the real-time occupancy of a room using **entrance and exit photocell sensors**. Implemented in **VHDL**, it counts people entering and leaving, tracks the current occupancy, and asserts a `max_capacity` signal when a user-defined threshold is reached.

Developed for the **Winter 2025 COEN313 Digital Design course** using **ModelSim** for simulation and **Vivado 2018.2** for synthesis and implementation on the **Xilinx Nexys A7 FPGA**.

---

## ✨ Features

✅ Real-time occupancy tracking using photocell-based entry/exit sensors  
✅ 8-bit configurable maximum occupancy threshold (0–255)  
✅ `max_capacity` signal activated when threshold is reached  
✅ Asynchronous system reset for safe initialization  
✅ Synthesis and implementation-ready VHDL architecture  
✅ Simulated and verified with ModelSim  
✅ Synthesized and implemented using Vivado 2018.2  
✅ Output occupancy shown on 8 LEDs; alert LED for full capacity

---

## 📁 Project Files

| File | Description |
|------|-------------|
| `room_occupancy_monitor.vhd` | Main VHDL logic for the occupancy monitor |
| `tb_room_occupancy_monitor.vhd` | Testbench for simulation |
| `Fabio_BinuKoshy_40231803.pdf` | Project report with methodology, code, and results |
| `Projectwf.png` | ModelSim waveform screenshot |
| `Synthesis_schematic.pdf` | Synthesized logic view from Vivado |
| `RTL_schematic.pdf` | Elaborated RTL view from Vivado |
| `(Synthesis) runme.log` | Vivado synthesis log |
| `(Implemetation) runme.log` | Vivado implementation log |
| `nexys_a7_constraints.xdc` | Constraints file for Nexys A7 (I/O pin mapping) |

---

## 🧪 How to Run the Simulation

### ModelSim

1. Create a directory and place both VHDL files inside:
   - `room_occupancy_monitor.vhd`
   - `tb_room_occupancy_monitor.vhd`

2. Run the ModelSim environment:
```bash
source /CMC/ENVIRONMENT/modelsim.env
```

3. Compile files:
```bash
vcom room_occupancy_monitor.vhd
vcom tb_room_occupancy_monitor.vhd
```

4. Start simulation:
```bash
vsim tb_room_occupancy_monitor
```

5. In ModelSim GUI:
   - Add all signals to the waveform
   - Run the simulation:
```tcl
run -all
```

---

## 🛠 FPGA Synthesis Instructions (Vivado)

### Vivado 2018.2 (Linux @ CMC)

1. Open Vivado:
```bash
source /CMC/tools/xilinx/Vivado_2018.2/Vivado/2018.2/settings64_CMC_central_license.csh
vivado &
```

2. Create a new RTL project.
3. Add `room_occupancy_monitor.vhd` as the top module.
4. Set FPGA part to: `xc7a100tcsg324-1` (Nexys A7).
5. Add `nexys_a7_constraints.xdc` as the constraints file.
6. Run Synthesis, Implementation, and Generate Bitstream.
7. View `RTL` and `Synthesis` schematics for hardware architecture.

---

## 🖼 Design Diagrams

### 🔧 RTL Schematic (Elaborated)
![RTL](https://github.com/FabioKoshy/Room-Occupancy-Monitor/blob/main/RTL_schematic.png)

### 🔩 Synthesis Schematic
![Synth](https://github.com/FabioKoshy/Room-Occupancy-Monitor/blob/main/Synthesis_schematic.png)

### 📊 Simulation Waveform
![Waveform](https://github.com/FabioKoshy/Room-Occupancy-Monitor/blob/main/Projectwf.png)

---

## ⚙️ Hardware Used

- ✅ **Target FPGA**: Xilinx Nexys A7 (Artix-7 XC7A100T)
- ✅ **Photocell Input Simulation**: Binary input emulation via testbench
- ✅ **LED Output**: 8-bit occupancy display + 1 LED alert for full capacity

---

## 👨‍💻 Author

**Fabio Binu Koshy**  
Winter 2025 – COEN 313  
Instructor: Dr. Sébastien Le Beux

---

## 📝 License

This project is submitted as part of a university course. All rights reserved. Redistribution or reuse without permission is prohibited.
