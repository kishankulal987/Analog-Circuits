# ⚡ 2-Bit CMOS Current-Steering DAC — Sky130

A complete transistor-level implementation and simulation of a **2-bit current-steering DAC** using the **SkyWater SKY130 1.8 V CMOS PDK**, Xschem, and ngspice.

The project was developed from the basic CMOS building blocks upward:

**Inverter → NAND/NOR → Decoder → Current Reference/Mirror → Current-Steering Cells → 2-bit DAC → DNL/INL characterization**

---

## 📋 1. Project Overview

A current-steering DAC converts a digital input code into an analog output by steering weighted currents to the output node.

For a 2-bit DAC, the four input codes are:

| Digital Code | Decimal | Ideal Output Current |
|--------------|---------|------------------------------|
| 00 | 0 | 0 × I<sub>LSB</sub> |
| 01 | 1 | 1 × I<sub>LSB</sub> |
| 10 | 2 | 2 × I<sub>LSB</sub> |
| 11 | 3 | 3 × I<sub>LSB</sub> |

The implemented DAC uses approximately **9.906 µA per LSB**, giving a full-scale current of approximately **29.718 µA**.

> **Important:** The decoder control signals S1, S2 and S3 in this implementation are complemented according to the switching logic. Therefore, the raw S-node polarity should not be confused with the external binary input code. The results table below is organized by the actual input code A/B.

---

## 🎯 2. Objectives

- Understand CMOS transistor-level circuit design.
- Build and verify basic CMOS logic gates.
- Design a 2-to-3 decoder for the current-steering structure.
- Design and verify a MOS current reference/current mirror.
- Build current-steering branches.
- Integrate the decoder and current-steering DAC.
- Measure output current for all four digital codes.
- Calculate DNL and INL.
- Observe switching transients and settling behavior.
- Understand practical simulation issues in Xschem/ngspice.

---

## 🛠️ 3. Tools and Technology

| Item | Used |
|-----------------------|-----------------|
| Schematic Capture | Xschem |
| Circuit Simulator | ngspice |
| Process Design Kit | SkyWater SKY130 |
| Supply Voltage | 1.8 V |
| Transistor Type | NMOS / PMOS |
| DAC Resolution | 2-bit |
| Output Load | 5 kΩ |
| Analysis | Transient |
| Logic Swing | 0–1.8 V |

---

## 🔄 4. Design Flow

The project was developed progressively rather than directly drawing the complete DAC.

```text
CMOS Inverter
     ↓
NAND + NOR
     ↓
2-to-3 Decoder
     ↓
Current Reference / Current Mirror
     ↓
Current-Steering Cell
     ↓
2-bit Current-Steering DAC
     ↓
Transient Simulation
     ↓
Output Current Measurement
     ↓
DNL / INL
```

This bottom-up approach made it easier to verify each block before integrating the complete design.

---

## 🔌 5. CMOS Inverter

The first building block was a standard CMOS inverter consisting of:

- One PMOS pull-up transistor
- One NMOS pull-down transistor
- Common gate input
- Common drain output

### Function

| Vin | Vout |
|-------|-------|
| 0 | 1.8 V |
| 1.8 V | 0 V |

### Simulation

<img width="1685" height="861" alt="inverter_simulation" src="https://github.com/user-attachments/assets/18d9afa9-eee5-4c12-86d5-d15a1a0e0f38" />

The waveform verifies the expected inverting behavior.

---

## 🚪 6. NAND Gate

A 2-input CMOS NAND gate was implemented using:

- Two NMOS transistors in series
- Two PMOS transistors in parallel

The NAND output becomes LOW only when both inputs are HIGH.

### Truth Table

| A | B | NAND |
|---|---|------|
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

### Simulation

<img width="1916" height="1134" alt="nand_simulation" src="https://github.com/user-attachments/assets/f0b30479-663f-4c3f-b69f-652a98605be4" />

---

## 🚫 7. NOR Gate

A 2-input CMOS NOR gate was implemented using:

- Two NMOS transistors in parallel
- Two PMOS transistors in series

The NOR output becomes HIGH only when both inputs are LOW.

### Truth Table

| A | B | NOR |
|---|---|-----|
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 0 |

### Simulation

<img width="1920" height="1106" alt="nor_simulation" src="https://github.com/user-attachments/assets/a539966a-1eaf-42b3-9d4a-fcd2a5a705a1" />

---

## 🧭 8. Decoder

The DAC uses a decoder to generate mutually controlled switching signals for the current-steering branches.

The decoder was constructed using the previously verified CMOS logic gates.

### Decoder Inputs

- A = MSB
- B = LSB

### Decoder Verification

<img width="1213" height="906" alt="decoder_schematic" src="https://github.com/user-attachments/assets/41d5bcd3-b942-468a-95fc-6beaebfafe56" />

<img width="1420" height="1096" alt="decoder_waveform" src="https://github.com/user-attachments/assets/26c64555-dc37-4f08-b9cd-b71a42cf6ffe" />

The waveform verifies the required digital state transitions.

### ⚠️ Important Implementation Detail

During integration, Xschem reported:

```text
Error: Net shorted: A - S2
Error: undriven node: S2
```

This occurred because the design intentionally uses a relationship between A and S2, while Xschem interpreted the wiring as an electrical short rather than simply a logical relationship.

The solution was to make the intended signal relationship explicit through the decoder structure and avoid physically shorting two separately driven nets.

This was an important lesson:

> A logical equivalence such as `S2 = A` does not mean that two independently driven circuit nets should be physically connected.

---

## 🪞 9. Current Reference / Current Mirror

A MOS current reference was implemented to generate the approximately constant unit current used by the steering branches.

<img width="1592" height="800" alt="current_mirror" src="https://github.com/user-attachments/assets/a1fa0d00-6ffe-4d0a-a840-00e4c84f0ffa" />

The reference branch uses a resistor and diode-connected NMOS to establish a reference current. Additional NMOS devices mirror this current into the DAC branches.

The measured current was approximately:

**I<sub>unit</sub> ≈ 9.906 µA**

The current mirror is therefore the fundamental analog building block that determines the DAC's LSB current.

---

## 🌊 10. Current-Steering Cell

The current-steering structure uses matched NMOS devices to direct a current either toward the output/load path or away from it according to the digital control signal.

This is different from a conventional voltage-mode DAC:

- The primary quantity being generated is **current**.
- The resistor converts the output current into voltage.
- Digital signals control where the current flows.

### Current-steering verification

<img width="1831" height="1120" alt="steering_voltage_plot" src="https://github.com/user-attachments/assets/9e721636-5ee1-4680-90b5-e87f11d5f9d1" />

Additional individual steering simulations were performed for different control combinations:

<img width="1612" height="916" alt="steering_v1_1_v2_0" src="https://github.com/user-attachments/assets/723e2111-c45f-4e5f-adca-5942d6cb8429" />

<img width="1920" height="1200" alt="steering_v1_0_v2_1" src="https://github.com/user-attachments/assets/0405cd79-c0e9-4ea5-acef-5ac75ad416f1" />

These simulations were useful for confirming the switching operation before connecting all branches to the decoder.

---

## 🧩 11. DAC Integration

The decoder and current-steering branches were finally integrated into the complete 2-bit DAC.

<img width="1429" height="766" alt="dac_with_decoder_output" src="https://github.com/user-attachments/assets/82e684f0-9b45-4586-b03d-83eac0012b00" />

The input waveforms cycle through the binary combinations:

```text
00 → 01 → 10 → 11
```

The output current correspondingly increases approximately in steps of one unit current.

<img width="699" height="1092" alt="dac_output_waveform" src="https://github.com/user-attachments/assets/3bbf8386-a4e2-44a9-a76a-27aeea7543f0" />

---

## 📏 12. Output Current Measurement

The output current was calculated from the resistor voltage:

$$I_{OUT} = \frac{V_{DD} - V_{OUT}}{R_L}$$

For this design:

$$V_{DD} = 1.8V$$

$$R_L = 5k\Omega$$

Therefore:

$$I_{OUT} = \frac{1.8 - V_{OUT}}{5k\Omega}$$

The current was measured using ngspice `.meas` statements over the settled portion of each code interval.

Example:

```spice
.meas tran I00 AVG ((1.8-V(out1))/5k) FROM=50n TO=90n
.meas tran I01 AVG ((1.8-V(out1))/5k) FROM=150n TO=190n
.meas tran I10 AVG ((1.8-V(out1))/5k) FROM=250n TO=290n
.meas tran I11 AVG ((1.8-V(out1))/5k) FROM=350n TO=390n
```

The averaging windows intentionally avoid the switching edges and therefore give a more representative steady-state current.

<img width="484" height="378" alt="current_measurements" src="https://github.com/user-attachments/assets/6faf8506-46c0-4dba-8b46-28e0570a8c00" />

---

## 📊 13. Measured DAC Results

The final measured currents were:

| Code | Decimal | Measured Output Current | Approx. LSB Units |
|------|---------|--------------------------|--------------------|
| 00 | 0 | 0.00001284 µA | 0.0000013 |
| 01 | 1 | 9.910301 µA | 1.00044 |
| 10 | 2 | 19.816320 µA | 2.00044 |
| 11 | 3 | 29.717940 µA | 3.00000 |

The 00 current is approximately **12.84 pA**, effectively zero compared with the ~9.9 µA unit current.

### Key results

| Parameter | Result |
|--------------------|-----------------|
| Resolution | 2-bit |
| Supply voltage | 1.8 V |
| Load resistance | 5 kΩ |
| Unit current / LSB | **9.90598 µA** |
| Full-scale current | **29.71794 µA** |
| Full-scale code | 11 |
| Zero-code current | **12.84 pA** |

The measured code-to-current relationship is very close to the ideal:

```text
00 → ~0 µA
01 → ~9.91 µA
10 → ~19.82 µA
11 → ~29.72 µA
```

---

## 📉 14. DNL Calculation

Differential Non-Linearity measures how much each actual code step differs from the ideal 1-LSB step.

The endpoint-based LSB used for this characterization is:

$$I_{LSB} = \frac{I_{11} - I_{00}}{3}$$

Using the measured values:

$$I_{LSB} = 9.90598\,\mu A$$

For each transition:

$$DNL_k = \frac{I_{k+1} - I_k}{I_{LSB}} - 1$$

### DNL Results

| Transition | Actual Step | DNL (LSB) |
|------------|-------------|-----------------|
| 00 → 01 | 9.910288 µA | **+0.000435** |
| 01 → 10 | 9.906019 µA | **+0.000004** |
| 10 → 11 | 9.901620 µA | **−0.000440** |

Therefore:

$$DNL_{max} \approx +0.000435\ LSB$$

$$DNL_{min} \approx -0.000440\ LSB$$

The absolute maximum DNL is approximately:

$$\boxed{|DNL|_{max} \approx 0.000440\ LSB}$$

This is extremely small and indicates that the four simulated code levels are highly uniform.

---

## 📈 15. INL Calculation

Integral Non-Linearity measures the deviation of each code from the ideal straight-line transfer characteristic.

For endpoint-based INL, the line is defined using code 00 and code 11:

$$I_{ideal}(k) = I_{00} + kI_{LSB}$$

Then:

$$INL_k = \frac{I_k - I_{ideal}(k)}{I_{LSB}}$$

### INL Results

| Code | Measured Current | INL (LSB) |
|------|-------------------|-----------------|
| 00 | 0.00001284 µA | **0.000000** |
| 01 | 9.910301 µA | **+0.000435** |
| 10 | 19.816320 µA | **+0.000440** |
| 11 | 29.717940 µA | **0.000000** |

Therefore:

$$\boxed{|INL|_{max} \approx 0.000440\ LSB}$$

The endpoint codes naturally have zero INL because the endpoint method forces the fitted line through codes 00 and 11.

---

## 🔍 16. DNL / INL Interpretation

The results are extremely close to ideal because the transistor-level simulation uses matched device dimensions and a relatively simple 2-bit architecture.

### DNL

DNL tells us whether individual steps are uniform.

The measured DNL is approximately:

```text
+0.000435 LSB
+0.000004 LSB
−0.000440 LSB
```

So every code transition is almost exactly one LSB.

### INL

INL tells us how far the transfer characteristic deviates from a straight line.

The maximum measured INL is only approximately:

```text
0.000440 LSB
```

Thus the simulated DAC has an almost perfectly linear transfer characteristic at this resolution.

> These excellent numbers should be interpreted as **pre-layout transistor-level simulation results**. Real silicon will introduce mismatch, parasitics, process variation, IR drop, finite output resistance, switch resistance, and other non-idealities.

---

## ⚡ 17. DAC Output Voltage

With a 5 kΩ load:

$$V_{OUT} = V_{DD} - I_{OUT}R_L$$

The current therefore produces approximately:

| Code | Current | Approx. Output Voltage |
|------|-------------|--------------------------|
| 00 | ~0 µA | ~1.8 V |
| 01 | ~9.91 µA | ~1.750 V |
| 10 | ~19.82 µA | ~1.701 V |
| 11 | ~29.72 µA | ~1.651 V |

The output-voltage waveform therefore steps downward as the DAC code increases.

<img width="1802" height="1109" alt="output_waveform" src="https://github.com/user-attachments/assets/e9e6a8b5-6ad1-4986-988c-f7594de3b57b" />

---

## ⏱️ 18. Transient / Switching Behavior

The DAC was simulated with periodic digital input signals.

The output waveform shows:

- Correct code-dependent output levels.
- Switching transients at code transitions.
- Short ringing/settling behavior after transitions.
- Stable steady-state values after the transient.

<img width="699" height="1092" alt="dac_output_waveform" src="https://github.com/user-attachments/assets/12371669-da59-4893-a639-69e37c9bec43" />

The transient response demonstrates that the circuit does not switch instantaneously. Internal node capacitances, transistor parasitics, resistor loading and the decoder contribute to the observed settling behavior.

---

## ✅ 19. Individual Code Verification

Before using the decoder, the current-steering branches were also tested with direct control signals.

### Code 00

<img width="1889" height="970" alt="without_decoder_00" src="https://github.com/user-attachments/assets/c34b8fbe-e505-4b9b-a6d2-5f1118ba5027" />

### Code 01

<img width="1917" height="1001" alt="without_decoder_01" src="https://github.com/user-attachments/assets/608bc7da-8fd8-4032-aa7a-62d1ba3d5032" />

### Code 10

<img width="1920" height="1006" alt="without_decoder_10" src="https://github.com/user-attachments/assets/a3815622-016e-429c-b214-f99b4e353c67" />

### Code 11

<img width="1553" height="594" alt="without_decoder_11" src="https://github.com/user-attachments/assets/c2960e3c-948e-4540-943a-89eb25713972" />

These tests helped isolate the analog steering circuitry from the digital decoder and were useful for debugging.

---

## 💡 20. Important ngspice Measurement Lesson

An initial attempt used:

```spice
.meas tran I00 AVG ((1.8-V(out1))/5k)
```

ngspice reported:

```text
no such vector as '((1.8-v(out1))/5k)'
```

The issue is that `AVG` in the `.meas` syntax expects a valid expression/vector in the supported measurement form.

After correcting the measurement syntax and rerunning the simulation, ngspice successfully returned:

```text
i00 = 1.284010e-11 A
i01 = 9.910301e-06 A
i10 = 1.981632e-05 A
i11 = 2.971794e-05 A
```

This demonstrated an important practical simulation lesson:

> Always verify the ngspice `.meas` syntax and check the terminal output before using measured values for DAC performance calculations.

---

## 🎓 21. What I Learned From This Project

### CMOS Fundamentals

- How CMOS inverters operate using complementary NMOS and PMOS devices.
- Why NMOS networks are used for pull-down paths.
- Why PMOS networks are used for pull-up paths.
- How transistor series/parallel arrangements implement NAND and NOR logic.
- How transistor sizing can affect current and switching behavior.

### Xschem

- Creating hierarchical schematics.
- Creating custom symbols from subcircuits.
- Connecting subcircuits at the top level.
- Understanding pin ordering in `.subckt` definitions.
- Using net labels to simplify large schematics.
- Debugging accidental net shorts.
- Reading generated ngspice netlists.

### ngspice

- Running transient simulations.
- Using `.lib` to load the SKY130 model library.
- Using `.tran` for time-domain analysis.
- Using `.meas tran` for automated measurements.
- Inspecting device currents using expressions such as:

```text
print @m.xm1.msky130_fd_pr__nfet_01v8[id]
```

- Measuring average current over a selected time interval.
- Understanding the difference between transient values and steady-state values.

### MOS Current Mirrors

- Creating a reference current using a diode-connected MOSFET.
- Mirroring current into multiple branches.
- Understanding why transistor matching is important.
- Understanding that finite output resistance causes non-ideal current mirroring.
- Recognizing the importance of device dimensions in setting current.

### Current Steering

- Understanding the principle of steering rather than generating a new current for every code.
- Understanding how digital control signals determine which current branch contributes to the output.
- Understanding why matched current sources are important.
- Understanding the relationship between current, load resistance and output voltage.

### DAC Architecture

- Understanding how a digital code is converted into weighted analog current.
- Understanding the role of a decoder.
- Understanding why the decoder and steering logic must be verified separately.
- Understanding how binary codes map to current levels.
- Understanding why a resistor load converts current into voltage.

### DAC Characterization

- Measuring unit/LSB current.
- Measuring full-scale current.
- Calculating DNL.
- Calculating INL.
- Selecting measurement windows away from switching transients.
- Understanding why endpoint-based INL gives zero error at the endpoints.
- Interpreting the difference between current-domain and voltage-domain DAC outputs.

### Debugging

One of the most useful lessons was that a circuit can be logically correct but electrically incorrect.

For example:

```text
Net shorted: A - S2
Undriven node: S2
```

showed that the intended logical relationship between two signals must be implemented carefully at the schematic level.

---

## 🏁 22. Final Results Summary

| Specification | Simulated Result |
|--------------------|--------------------|
| DAC architecture | Current-steering |
| Resolution | 2-bit |
| Technology | SKY130 |
| Supply | 1.8 V |
| Load | 5 kΩ |
| Unit current | **9.90598 µA** |
| Full-scale current | **29.71794 µA** |
| Zero-code current | **12.84 pA** |
| Maximum DNL | **0.000440 LSB** |
| Maximum INL | **0.000440 LSB** |
| Codes verified | **00, 01, 10, 11** |
| Decoder | Verified |
| Current mirror | Verified |
| Current steering | Verified |
| Top-level DAC | Verified |

---

## ✅ 23. Conclusion

A complete **2-bit CMOS current-steering DAC** was designed and simulated using Xschem, ngspice and the SKY130 PDK.

The project progressed from individual CMOS gates to a decoder, current reference, current mirror, current-steering branches and finally the complete DAC.

The measured output current followed the expected binary relationship:

$$00 \rightarrow 0$$

$$01 \rightarrow I_{LSB}$$

$$10 \rightarrow 2I_{LSB}$$

$$11 \rightarrow 3I_{LSB}$$

with:

$$I_{LSB} \approx 9.906\,\mu A$$

and:

$$I_{FS} \approx 29.718\,\mu A$$

The calculated DNL and INL were both below approximately:

$$\boxed{0.00044\ LSB}$$

for this pre-layout simulation.

The project provided practical experience in **CMOS circuit design, hierarchical schematic design, transistor-level simulation, current mirrors, current steering, decoder design, ngspice measurements, DAC characterization, DNL/INL analysis and circuit debugging**.

---


## 📁 Project Structure

```text
current-steering-dac-2bit/
│
├── current_steering_dac_2bit.sch
├── current_steering_dac_2bit.sym
├── decoder.sch
├── decoder.sym
├── inverter.sch
├── inverter.sym
├── nand.sch
├── nand.sym
├── nor.sch
├── nor.sym
├── README.md
│
└── images/
    ├── current_mirror.png
    ├── dac_with_decoder_output.png
    ├── dac_output_waveform.png
    ├── decoder_schematic.png
    ├── decoder_waveform.png
    ├── inverter_simulation.png
    ├── nand_simulation.png
    ├── nor_simulation.png
    ├── output_waveform.png
    ├── steering_voltage_plot.png
    ├── steering_v1_1_v2_0.png
    ├── steering_v1_0_v2_1.png
    ├── current_measurements.png
    ├── without_decoder_00.png
    ├── without_decoder_01.png
    ├── without_decoder_10.png
    └── without_decoder_11.png
```

---

## 👤 Author

**Kishan K Kulal**

Electronics Engineering
NMAM Institute of Technology

### Key Areas

`VLSI` `CMOS` `Analog IC Design` `DAC` `Current Steering` `SKY130` `Xschem` `ngspice` `Circuit Simulation`
