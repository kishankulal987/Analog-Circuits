# Current Steering Cell — Complete Design, Questions, Simulations & Results

## 1. Project Overview

This project implements and verifies a **100 µA current-steering cell** using the Sky130A NMOS model in Xschem/ngspice.

The goal was not just to draw the circuit, but to understand and verify the complete design flow:

1. Characterize the NMOS.
2. Observe channel-length modulation.
3. Select a longer channel length for the current-source transistor.
4. Find the gate voltage required for a 100 µA current.
5. Build the current-steering cell.
6. Recalculate the bias voltage in the complete circuit.
7. Verify DC steering.
8. Verify transient steering.
9. Understand the operating regions of the current-source and steering MOSFETs.
10. Use the verified cell as the unit cell for the next current-steering DAC stage.

---

## 2. Final Circuit

The cell contains:

- **M1:** current-source NMOS
- **M2/M3:** steering NMOS transistors
- **R1/R2:** 5 kΩ output loads
- **VDD:** 1.8 V
- **Target unit current:** 100 µA

### Device sizes

| Device | Function | W | L |
|--------|----------------|------|---------|
| M1 | Current source | 1 µm | 1 µm |
| M2 | Steering switch | 1 µm | 0.15 µm |
| M3 | Steering switch | 1 µm | 0.15 µm |

M1 is intended to behave as the current source, while M2 and M3 select which output receives the current.

---

## 3. NMOS Characterization

### Question: Why did we characterize the NMOS first?

Before designing the current-steering cell, we needed to know how the NMOS behaves as a current source.

For the current-source transistor, we want operation in saturation with reasonably high output resistance.

A short-channel MOSFET shows stronger channel-length modulation, so its drain current changes more with drain voltage.

---

### Screenshot 1 — Poor output characteristic due to channel-length modulation

<img width="1251" height="699" alt="01_poor_curve_minimum_length" src="https://github.com/user-attachments/assets/b3ec8fe6-0a4f-48d2-834a-b666225d104f" />

**What this screenshot demonstrates:**

The minimum-length NMOS shows a relatively sloped saturation region. This indicates stronger channel-length modulation.

For a current source, this is undesirable because the current should remain as constant as possible when the drain voltage changes.

---

### Question: Why did we choose L = 1 µm?

Increasing channel length reduces the effect of channel-length modulation.

We had already studied different channel lengths earlier, so instead of repeating the entire length sweep, we fixed:

$$\boxed{L = 1\,\mu m}$$

for the final current-source transistor.

This was a design choice rather than another characterization exercise.

---

### Screenshot 2 — Output characteristic with L = 1 µm

<img width="1265" height="703" alt="02_output_characteristic_L1um" src="https://github.com/user-attachments/assets/248f0b9e-936a-4143-a996-08a6b924c7c0" />

**What this screenshot demonstrates:**

With $L = 1\,\mu m$, the saturation region is considerably flatter.

Therefore:

$$\boxed{L = 1\,\mu m}$$

was selected for M1.

This gives a higher output resistance and a more stable unit current.

---

## 4. Finding the Gate Voltage for 100 µA

### Question: How do we find the VGS required for 100 µA?

Instead of estimating the voltage from the graph manually, ngspice can locate the exact crossing.

For the standalone NMOS, a DC sweep was used:

```spice
.dc V1 0 1.8 0.01
```

The current was plotted against the swept gate voltage.

The ngspice measurement was based on the voltage-source branch current:

```spice
meas dc VBIAS FIND v-sweep WHEN v2#branch=-100u
```

The negative sign occurs because ngspice defines the current through the voltage source according to its branch-current reference direction.

---

### Screenshot 3 — ngspice measurement for 100 µA at L = 1 µm

<img width="390" height="47" alt="03_nmos_bias_measurement_L1um" src="https://github.com/user-attachments/assets/478fc2ab-8801-4711-bc9f-61582ad16bfb" />

**Result:**

$$\boxed{V_{BIAS} = 1.655626\,V}$$

This was the initial bias obtained from the **standalone NMOS**.

---

### Screenshot 4 — 100 µA point on the NMOS transfer curve

<img width="482" height="46" alt="04_nmos_bias_plot" src="https://github.com/user-attachments/assets/579b5e69-3e34-4f3b-b793-30884e023e17" />

**What this screenshot demonstrates:**

The current reaches approximately 100 µA at a gate voltage near the measured value.

The exact ngspice result is:

$$\boxed{V_{BIAS} = 1.655626\,V}$$

---

### Question: Why didn't we simply use 1.655626 V in the final cell?

Because the standalone NMOS and the complete current-steering cell do not have the same drain voltage.

When M1 is placed inside the complete cell, its drain is connected to the steering network.

Therefore, its operating point changes.

So:

$$\boxed{\text{Standalone NMOS bias} \neq \text{necessarily final cell bias}}$$

This is why we recalculated the bias after building the complete cell.

---

## 5. Standalone NMOS Schematic

### Screenshot 5 — NMOS used for characterization

<img width="1051" height="511" alt="05_standalone_nmos_circuit" src="https://github.com/user-attachments/assets/9ea2d63d-2c28-4ee4-9f4d-697273aecc2b" />

**What to explain in the report:**

This schematic is used only to characterize the current-source NMOS.

The gate voltage is swept from 0 to 1.8 V while the drain is biased at a fixed voltage.

The objective is to find the gate voltage corresponding to the desired 100 µA current.

---

## 6. Current-Steering Cell Concept

### Question: What is the purpose of M1, M2 and M3?

The three transistors have different jobs.

#### M1 — Current source

M1 generates approximately:

$$\boxed{100\,\mu A}$$

It should operate in saturation.

#### M2/M3 — Steering devices

M2 and M3 decide which output receives the current.

They are digitally controlled:

$$V_G = 0V \rightarrow \text{OFF}$$

$$V_G = 1.8V \rightarrow \text{ON}$$

Therefore:

$$\boxed{\text{M1 generates the current}}$$

while:

$$\boxed{\text{M2/M3 steer the current}}$$

---

## 7. MOSFET as a Switch — Operating Region

### Question: If I want a MOSFET to work as a switch, should I bias it in triode?

Yes, when the MOSFET is **ON**, the desired switch behavior corresponds to the triode/linear region.

For an NMOS:

$$V_{GS} > V_{TH}$$

and:

$$V_{DS} < V_{GS} - V_{TH}$$

Then the MOSFET behaves approximately as a low resistance.

$$R_{ON} \downarrow \quad \text{when} \quad V_{GS} \uparrow$$

When the MOSFET is OFF:

$$V_{GS} < V_{TH}$$

and it behaves approximately as an open switch.

---

### Question: Is the resistance infinite in saturation?

Not literally.

In ideal saturation, the drain current is independent of $V_{DS}$:

$$\frac{\partial I_D}{\partial V_{DS}} = 0$$

so the small-signal output resistance would be:

$$r_o = \frac{1}{g_{ds}} \rightarrow \infty$$

But a real MOSFET has channel-length modulation:

$$I_D \approx I_{D0}(1 + \lambda V_{DS})$$

so:

$$\boxed{r_o \approx \frac{1}{\lambda I_D}}$$

Therefore saturation gives **high but finite** output resistance.

For our design:

$$\boxed{M1 \rightarrow \text{saturation/current source}}$$

and:

$$\boxed{M2, M3 \rightarrow \text{steering switches}}$$

---

## 8. Initial DC Steering

The steering control was first tested with fixed DC values.

One transistor was turned ON while the other was turned OFF.

### Screenshot 6 — First DC steering state

<img width="1351" height="574" alt="06_initial_steering_dc_state" src="https://github.com/user-attachments/assets/b2bd95f6-5c23-492e-a8be-256d15ce90d9" />

**What to explain:**

One steering transistor is ON and the other is OFF.

The current flows through the selected output branch.

This verifies the basic steering mechanism.

---

### Screenshot 7 — Reverse DC steering state

<img width="1341" height="598" alt="07_reverse_steering_dc_state" src="https://github.com/user-attachments/assets/590bedc6-bcf8-4de3-a4a6-b34b847943d4" />

**What to explain:**

The control voltages are reversed.

The current therefore moves to the opposite output.

This demonstrates that the current can be directed to either branch.

---

## 9. Recalculating the Bias in the Complete Current-Steering Cell

### Question: Why did we need a new bias voltage?

The standalone value:

$$1.655626\,V$$

was not guaranteed to generate exactly 100 µA in the complete cell.

Therefore, the complete cell was used to find the correct bias.

The output current was calculated from the resistor:

```spice
let iout1 = (1.8-v(out1))/5k
```

Then ngspice was asked to find the gate voltage corresponding to 100 µA:

```spice
meas dc VBIAS FIND v-sweep WHEN iout1=100u
```

The result was:

$$\boxed{V_{BIAS} = 1.768104\,V}$$

---

### Screenshot 8 — Bias extraction in the complete cell

<img width="1786" height="907" alt="08_new_bias_extraction_schematic" src="https://github.com/user-attachments/assets/d8340b9c-c37a-4fef-a689-e137eccdba60" />

**What to explain:**

This screenshot shows the complete steering circuit while the bias is being extracted.

The important point is that the current is measured through the actual output branch rather than through the isolated NMOS.

---

### Screenshot 9 — Complete-cell 100 µA result

<img width="1916" height="1115" alt="09_complete_cell_100uA_result" src="https://github.com/user-attachments/assets/fae197a9-291d-4b9c-aa84-76728271d91a" />

**What to explain:**

The extracted bias is applied to M1.

The complete cell now produces the desired unit current.

Final bias:

$$\boxed{V_{BIAS} = 1.768104\,V}$$

---

## 10. DC Operating-Point Verification

At:

$$V_{BIAS} = 1.768104\,V$$

the operating point gave:

| Quantity | Simulated result |
|-------------|------------------------|
| $I_{M1}$ | **100.0009 µA** |
| $I_{M2}$ | **2.10 × 10⁻²² A ≈ 0** |
| $I_{M3}$ | **100.0010 µA** |
| $V_{OUT1}$ | **1.800000 V** |
| $V_{OUT2}$ | **1.299995 V** |

This is an excellent verification.

The expected active output voltage is:

$$V_{OUT} = V_{DD} - IR$$

$$= 1.8 - (100\,\mu A)(5\,k\Omega)$$

$$\boxed{V_{OUT} = 1.3\,V}$$

The simulated value:

$$\boxed{1.299995\,V}$$

matches the theoretical value extremely closely.

---

## 11. Common Node Voltage

### Question: What is Vx?

$V_X$ is the common source node of the steering pair and the drain node of M1.

The measured operating-point value was:

$$\boxed{V_X = 0.616529\,V}$$

---

### Screenshot 10 — Vx operating point

<img width="1893" height="951" alt="10_vx_operating_point" src="https://github.com/user-attachments/assets/79c4066c-0fc6-4c71-9c2b-0e9b5363262a" />

**Why this is useful:**

This voltage allows us to understand the operating conditions of M1 and the steering MOSFET.

For example, for an ON steering NMOS:

$$V_{GS} = 1.8 - V_X$$

so approximately:

$$V_{GS} = 1.8 - 0.616529$$

$$\boxed{V_{GS} \approx 1.1835\,V}$$

This confirms that the steering device is strongly turned ON.

---

## 12. Why We Do Not Use `.op` to Observe a Pulse

### Question: I am giving PULSE as input. When does `.op` start reading the output?

`.op` performs **one DC operating-point calculation**.

It does not simulate time.

Therefore:

```text
.op
```

is appropriate for fixed DC input values.

For pulse inputs, use transient analysis:

```spice
.tran 1n 1u
```

The transient simulation evaluates the circuit repeatedly with time:

$$t = 0,\ 1ns,\ 2ns,\ \ldots,\ 1\mu s$$

and the PULSE source changes according to its timing parameters.

Therefore:

$$\boxed{.op \rightarrow \text{one operating point}}$$

$$\boxed{.tran \rightarrow \text{time-domain waveform}}$$

---

## 13. Transient Current Steering

### Screenshot 11 — Transient current-steering circuit

<img width="1287" height="795" alt="11_transient_cell_schematic" src="https://github.com/user-attachments/assets/77a0ea1c-5879-4125-8698-46c7c841ef34" />

The steering transistors were driven with complementary pulse signals.

Example:

```spice
PULSE(0 1.8 0 1n 1n 100n 200n)
```

and complementary:

```spice
PULSE(1.8 0 0 1n 1n 100n 200n)
```

Transient analysis:

```spice
.tran 1n 1u
```

---

### Screenshot 12 — Transient current steering result

<img width="1807" height="1116" alt="12_transient_current_steering" src="https://github.com/user-attachments/assets/69340ffa-4444-47e5-a7d7-eb2fdb1c9f0a" />

The output currents were plotted using:

```spice
(1.8-v(out1))/5k
(1.8-v(out2))/5k
```

The result shows:

#### State 1

$$I_{OUT1} \approx 100\,\mu A$$

$$I_{OUT2} \approx 0$$

#### State 2

$$I_{OUT1} \approx 0$$

$$I_{OUT2} \approx 100\,\mu A$$

The two currents repeatedly exchange positions.

Therefore:

$$\boxed{100\,\mu A \text{ is successfully steered between OUT1 and OUT2}}$$

Small glitches/spikes around the switching edges are expected because real MOSFETs have parasitic capacitances and finite switching time.

---

## 14. Why Output Compliance Was Not Made a Separate Mini-Project

### Question: Is output compliance necessary?

Yes, output compliance is important for a real current-steering DAC because the current source should remain in its intended operating region while the output voltage changes.

However, the NMOS ($I_D$–$V_{DS}$) characterization already showed the fundamental effect.

The flatter saturation curve obtained with:

$$L = 1\,\mu m$$

already demonstrates why longer channel length helps the current source.

Therefore, output compliance was not treated as a separate mini-project at this stage.

It can be analyzed later when evaluating the final DAC's output accuracy.

---

## 15. Final Results Table

| Parameter | Result |
|--------------------------------|------------------------|
| Technology | Sky130A |
| Supply ($V_{DD}$) | 1.8 V |
| M1 width | 1 µm |
| M1 length | **1 µm** |
| M2/M3 width | 1 µm |
| M2/M3 length | 0.15 µm |
| Target unit current | **100 µA** |
| Standalone bias, $L = 1µm$ | **1.655626 V** |
| Final cell bias | **1.768104 V** |
| Common node ($V_X$) | **0.616529 V** |
| M1 current | **100.0009 µA** |
| OFF steering current | **≈ 0 A** |
| ON steering current | **100.0010 µA** |
| Active output voltage | **1.299995 V ≈ 1.3 V** |
| Inactive output voltage | **1.800000 V** |
| Transient steering | **Verified** |

---

## 16. Complete Question-and-Answer Summary

### Q1. Why did we characterize the NMOS?

To determine its current behavior and choose a suitable operating point for use as a current source.

### Q2. Why increase L?

To reduce channel-length modulation and obtain a flatter ($I_D$–$V_{DS}$) curve and higher output resistance.

### Q3. Why did we select L = 1 µm?

Because it provided a significantly flatter characteristic and was already established from the earlier length study.

### Q4. How did we find the voltage for 100 µA?

By sweeping the gate voltage and using ngspice's `meas` command.

### Q5. What was the standalone 100 µA bias?

$$\boxed{1.655626\,V}$$

### Q6. Why did the complete cell need a different bias?

Because placing M1 in the complete steering network changes its drain voltage and operating point.

### Q7. What was the final cell bias?

$$\boxed{1.768104\,V}$$

### Q8. Why is M1 different from M2/M3?

M1 generates the current; M2/M3 steer it.

### Q9. Which region should M1 operate in?

Saturation, because it is being used as a current source.

### Q10. Which region should an ON MOSFET switch ideally operate in?

Triode/linear region, because it provides a low ON resistance.

### Q11. Is saturation resistance infinite?

Ideally ($r_o \rightarrow \infty$), but in a real MOSFET channel-length modulation makes $r_o$ finite.

### Q12. Why use 1.8 V on the steering gate?

To strongly turn the NMOS ON.

### Q13. Why not use `.op` with PULSE?

`.op` gives one operating point and has no time axis. Pulse behavior requires `.tran`.

### Q14. What analysis verifies switching?

Transient analysis:

```spice
.tran 1n 1u
```

### Q15. What did the transient result prove?

That approximately 100 µA can be repeatedly switched between OUT1 and OUT2.

### Q16. Is output compliance necessary?

It is important for the final DAC, but a separate compliance experiment is not necessary at this stage because the NMOS output characteristics have already established the underlying behavior.

---

## 17. Final Conclusion

The current-steering cell is complete.

The design successfully generates and steers a:

$$\boxed{100\,\mu A}$$

unit current.

The final measured bias is:

$$\boxed{V_{BIAS} = 1.768104\,V}$$

The DC simulation confirms:

$$I_{M1} \approx 100\,\mu A$$

and the transient simulation confirms:

$$\boxed{100\,\mu A \text{ is alternately directed to OUT1 and OUT2}}$$

The cell is therefore ready to be used as the **unit current cell of the actual current-steering DAC**.

---

## 18. Recommended Screenshot Order in the GitHub README

Use the screenshots in this order:

1. `01_poor_curve_minimum_length.png` — Show the problem of channel-length modulation.
2. `02_output_characteristic_L1um.png` — Show the selected ($L = 1µm$).
3. `03_nmos_bias_measurement_L1um.png` — Show the ngspice command/result for 100 µA.
4. `04_nmos_bias_plot.png` — Show the 100 µA point visually.
5. `05_standalone_nmos_circuit.png` — Show the characterization circuit.
6. `08_new_bias_extraction_schematic.png` — Show why the complete cell needs recalibration.
7. `09_complete_cell_100uA_result.png` — Show the final 100 µA operating point.
8. `10_vx_operating_point.png` — Show ($V_X = 0.616529V$).
9. `06_initial_steering_dc_state.png` — Show one DC steering state.
10. `07_reverse_steering_dc_state.png` — Show the opposite DC steering state.
11. `11_transient_cell_schematic.png` — Show the pulse-driven cell.
12. `12_transient_current_steering.png` — Show the final current-steering waveform.

`13_100uA_bias_plot.png` can be included as an additional supporting figure if desired.

---

## 19. Next Project

The verified cell now becomes the **unit cell** for the next stage:

$$\boxed{\text{Current-Steering Cell}} \rightarrow \boxed{\text{Multiple Unit Cells}} \rightarrow \boxed{\text{Multi-bit Current-Steering DAC}}$$

The next stage will focus on digital code-to-current conversion, LSB, monotonicity, DNL, INL, and the DAC transfer characteristic.
