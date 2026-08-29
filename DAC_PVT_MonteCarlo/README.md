# 2-Bit Current-Steering DAC — PVT and Monte Carlo Analysis

## 1. Project Overview

This project implements and analyzes a **2-bit current-steering DAC** using the **SkyWater SKY130** device models and **ngspice**.

The DAC accepts a 2-bit digital input:

| Digital Code | Decimal | Ideal DAC Output |
|---|---:|---:|
| 00 | 0 | 0 × ILSB |
| 01 | 1 | 1 × ILSB |
| 10 | 2 | 2 × ILSB |
| 11 | 3 | 3 × ILSB |

The important idea of a current-steering DAC is that the digital input does not directly create an analog voltage. Instead, the decoder controls transistor switches that **steer accurately generated current sources toward the output**.

In this implementation, the output current is converted into a measurable output voltage using a **5-kΩ load resistor**:

$$V_{out}=V_{DD}-I_{out}R_L$$

and therefore the output current is extracted in the simulation using:

$$I_{out}=\frac{V_{DD}-V_{out}}{5k\Omega}$$

The transient simulation applies all four digital codes sequentially and measures the average output current during a stable portion of each code interval.

---

# 2. Why Do We Need PVT and Monte Carlo Analysis?

<img width="1728" height="874" alt="dac_schematic" src="https://github.com/user-attachments/assets/1c2fb414-8bd8-428d-8bb2-34eff8b8d57c" />

*Figure: Current-steering DAC schematic used for the simulations.*

A nominal simulation answers:

> "Does my DAC work under the particular conditions I selected?"

For example, a nominal simulation may use:

- VDD = 1.8 V
- Temperature = 27 °C
- Typical process model
- Nominal transistor parameters

If the DAC produces approximately:

- Code 00 → 0 µA
- Code 01 → 10 µA
- Code 10 → 20 µA
- Code 11 → 30 µA

we know that the circuit works under that particular condition.

However, a real manufactured IC will **not** operate at exactly one set of conditions.

There are three major sources of variation:

1. **Process variation** — manufacturing changes transistor parameters.
2. **Voltage variation** — the supply voltage changes.
3. **Temperature variation** — the circuit operates over a temperature range.

These are investigated using **PVT analysis**.

There is another important variation:

4. **Random device-to-device mismatch** — two supposedly identical transistors are never perfectly identical after fabrication.

This is investigated using **Monte Carlo analysis**.

Therefore:

> **PVT tells us how the DAC behaves when operating conditions and process corners change.**
>
> **Monte Carlo tells us how the DAC behaves when random device variations/mismatch change from one manufactured chip instance to another.**

These analyses are important because a DAC must maintain correct current ratios and acceptable linearity, not merely work at one nominal operating point.

---

# 3. Basic Working of the DAC

## 3.1 Digital Inputs

The circuit uses two digital inputs:

- A = MSB/one digital control input
- B = LSB/second digital control input

The input pulses are arranged so that the DAC experiences:

```text
00 → 01 → 10 → 11
```

The decoder converts these two input bits into control signals for the current-steering branches.

The decoder contains CMOS logic including:

- NOR
- NAND
- Inverters

This can be seen in the extracted SPICE netlist.

---

## 3.2 Current-Steering Principle

The core DAC contains matched transistor branches.

The idea is:

```text
                 VDD
                  |
             Current source
                  |
          +-------+-------+
          |               |
       Switch          Switch
          |               |
         OUT             OUT
```

Depending on the decoder output, a current branch is turned ON and its current is steered toward the output.

For a 2-bit DAC, the expected relationship is approximately:

$$I_{01}\approx I_{LSB}$$

$$I_{10}\approx 2I_{LSB}$$

$$I_{11}\approx 3I_{LSB}$$

The simulation results confirm this behavior approximately.

---

# 4. Nominal DAC Simulation

The transient analysis is:

```spice
.tran 1n 800n
```

The four codes are measured over separate time windows:

```spice
.meas tran I00 AVG par('(VDD-V(out1))/5k') FROM=50n TO=90n
.meas tran I01 AVG par('(VDD-V(out1))/5k') FROM=150n TO=190n
.meas tran I10 AVG par('(VDD-V(out1))/5k') FROM=250n TO=290n
.meas tran I11 AVG par('(VDD-V(out1))/5k') FROM=350n TO=390n
```

The averaging windows are deliberately placed inside each code interval rather than directly at the switching edge.

This avoids measuring the transient switching behavior and gives a better estimate of the settled DAC output current.

The simulation structure and measurement equations are present in the Monte Carlo SPICE setup.

---

# 5. What Should We Expect from a 2-Bit DAC?

For an ideal 2-bit current-steering DAC:

```text
Code     Ideal normalized current
---------------------------------
00       0 ILSB
01       1 ILSB
10       2 ILSB
11       3 ILSB
```

Therefore, the most important characteristic is not simply the absolute current.

The important question is:

> Are the current steps approximately equal?

For example:

```text
I00 ≈ 0
I01 ≈ 10 µA
I10 ≈ 20 µA
I11 ≈ 30 µA
```

The steps are:

```text
I01 - I00 ≈ 10 µA
I10 - I01 ≈ 10 µA
I11 - I10 ≈ 10 µA
```

Equal steps indicate good DAC linearity.

---

# 6. PVT Analysis

PVT stands for:

- **P = Process**
- **V = Voltage**
- **T = Temperature**

The purpose of PVT analysis is to determine whether the DAC maintains predictable operation when these parameters vary.

The PVT script evaluates:

### Supply voltage

```text
1.62 V
1.80 V
1.98 V
```

### Temperature

```text
-40 °C
27 °C
125 °C
```

### Process corners

```text
SS
TT
FF
SF
FS
```

The generated PVT plots are:

```text
PVT_VDD.png
PVT_Temperature.png
PVT_Process.png
```

---

# 7. PVT — Supply Voltage Analysis

<img width="2048" height="1280" alt="PVT_VDD" src="https://github.com/user-attachments/assets/01bc8201-eca4-4a9f-a290-0b2445b7c415" />

*Figure: Simulated DAC output current versus VDD.*

The supply-voltage sweep uses:

| VDD | Code 01 | Code 10 | Code 11 |
|---:|---:|---:|---:|
| 1.62 V | 8.165 µA | 16.433 µA | 24.591 µA |
| 1.80 V | 9.910 µA | 19.816 µA | 29.718 µA |
| 1.98 V | 11.692 µA | 23.251 µA | 34.933 µA |

### What does the graph show?

All three output-current curves increase as VDD increases.

This means the DAC output current is **not perfectly supply-independent**.

For example, Code 11 changes from approximately:

$$24.59\mu A \rightarrow 34.93\mu A$$

when VDD changes from 1.62 V to 1.98 V.

### Why does this happen?

The transistor current depends on transistor operating voltage.

Changing VDD changes:

- transistor drain-source voltage
- output voltage
- transistor operating region
- current-source compliance
- voltage across the load resistor

Therefore, the current generated by the MOS devices changes.

### What is good about the result?

The three curves remain approximately proportional:

```text
Code 01 ≈ 1 × current unit
Code 10 ≈ 2 × current unit
Code 11 ≈ 3 × current unit
```

So although the absolute current changes with VDD, the DAC still maintains approximately correct code-to-code scaling.

### Important interpretation

This graph tells us:

> The DAC's absolute output current has supply dependence, but the relative current relationship between the digital codes remains reasonably consistent.

This is an important result for understanding the robustness of the current-steering architecture.

---

# 8. PVT — Temperature Analysis

<img width="2048" height="1280" alt="PVT_Temperature" src="https://github.com/user-attachments/assets/9b54921c-11b4-47fa-a2c3-42057fedd7a3" />

*Figure: Simulated DAC output current versus temperature.*

The temperature sweep uses:

```text
-40 °C
27 °C
125 °C
```

The results are:

| Temperature | Code 01 | Code 10 | Code 11 |
|---:|---:|---:|---:|
| -40 °C | 9.777 µA | 19.549 µA | 29.317 µA |
| 27 °C | 9.910 µA | 19.816 µA | 29.718 µA |
| 125 °C | 10.077 µA | 20.150 µA | 30.219 µA |

### What does the graph show?

The current increases gradually with temperature.

For Code 11:

$$29.317\mu A \rightarrow 30.219\mu A$$

from -40 °C to 125 °C.

The change is relatively small compared with the much larger change seen during the VDD sweep.

### What does this mean?

The DAC shows **moderate temperature dependence**, but the code relationship remains close to:

```text
01 : 10
10 : 20
11 : 30 µA
```

The three curves also move together, which indicates that the temperature variation affects the current-source branches in a reasonably similar way.

### Engineering interpretation

A good DAC should ideally have low temperature sensitivity.

This result shows that the present circuit has some temperature coefficient, but the current ratios remain relatively well behaved over the simulated temperature range.

---

# 9. PVT — Process Corner Analysis

<img width="2048" height="1280" alt="PVT_Process" src="https://github.com/user-attachments/assets/d694339a-7949-4a0b-8260-9666b5123edc" />

*Figure: Simulated DAC output current versus process corner.*

Process corners represent systematic manufacturing variations.

The analysis uses:

```text
SS
TT
FF
SF
FS
```

Typically:

- **TT** = typical NMOS / typical PMOS
- **SS** = slow devices
- **FF** = fast devices
- **SF / FS** = mixed-speed corners

The exact naming convention for mixed corners depends on the model/PDK convention.

The results are:

| Corner | Code 01 | Code 10 | Code 11 |
|---|---:|---:|---:|
| SS | 9.363 µA | 18.722 µA | 28.079 µA |
| TT | 9.910 µA | 19.816 µA | 29.718 µA |
| FF | 10.425 µA | 20.844 µA | 31.257 µA |
| SF | 10.556 µA | 21.107 µA | 31.651 µA |
| FS | 9.239 µA | 18.474 µA | 27.707 µA |

### What does the graph show?

The absolute output current changes significantly with process corner.

The highest current occurs around the SF corner in this simulation, while the lowest current occurs around the FS corner.

For Code 11:

```text
SF ≈ 31.65 µA
FS ≈ 27.71 µA
```

This is a significant difference.

### Why?

Fabrication changes transistor characteristics such as:

- threshold voltage
- carrier mobility
- effective transistor strength
- current capability

Because the DAC relies on MOS transistor current generation and matching, process variation directly affects the output current.

### Most important observation

Even though the absolute current changes, the three code currents remain approximately:

```text
I01 : I10 : I11 ≈ 1 : 2 : 3
```

That means the architecture preserves the intended current scaling reasonably well across the tested process corners.

---

# 10. PVT — Overall Interpretation

The three PVT plots answer three different questions.

### VDD plot

> What happens if the supply voltage changes?

Answer:

**Output current changes noticeably with VDD.**

### Temperature plot

> What happens if the operating temperature changes?

Answer:

**Output current changes gradually with temperature.**

### Process plot

> What happens if fabrication parameters change?

Answer:

**Output current changes significantly between process corners.**

Therefore:

```text
Supply variation     → noticeable current variation
Temperature variation → relatively smaller current variation
Process variation     → significant current variation
```

However, the current ratio between the DAC codes remains approximately maintained.

---

# 11. Why PVT Alone Is Not Enough

PVT analysis considers **systematic/global conditions**.

For example, at the FF corner, the devices are collectively represented by a particular fast-process model.

But real chips also contain **random local mismatch**.

Imagine two transistors designed to be identical:

```text
Designed:
M1 = M2

Real silicon:
M1 ≠ M2 slightly
```

This can happen because of random fabrication effects.

For a current-steering DAC, this matters greatly because the circuit depends on matched current branches.

A small mismatch can cause:

```text
Ideal:
10 µA
20 µA
30 µA

Actual:
9.9 µA
20.2 µA
29.7 µA
```

The DAC still works, but its linearity is degraded.

This is why Monte Carlo analysis is required.

---

# 12. Monte Carlo Analysis

Monte Carlo analysis repeatedly runs the circuit with randomly varied device parameters.

In this project:

```text
200 Monte Carlo runs
```

are performed.

The shell script contains:

```bash
for i in {1..200}
do
    ...
    ngspice -b mc_dac.spice
    ...
done
```

The measured results from each run are stored in:

```text
mc_results.txt
```

The file contains:

```text
run,I00,I01,I10,I11
```

with one row for each Monte Carlo run.

Thus, instead of asking:

> "What is the DAC output current?"

we ask:

> "What range of DAC output currents can occur because of random variation?"

This is much closer to the question of manufacturing yield.

---

# 13. Monte Carlo I01 Distribution

<img width="2048" height="1280" alt="monte_carlo_I01" src="https://github.com/user-attachments/assets/7eeb048d-c6b7-445b-b5c7-7b7ee92070ff" />

*Figure: Distribution of Code 01 output current over the Monte Carlo runs.*

The first Monte Carlo histogram is for Code 01.

The measured statistics are approximately:

```text
Mean = 9.924 µA
Sigma = 0.344 µA
```

The distribution is centered close to the nominal value of approximately 10 µA.

The plotted ±3σ limits are approximately:

```text
-3σ = 8.891 µA
+3σ = 10.957 µA
```

### What does the histogram mean?

Each bar represents the number of Monte Carlo runs whose Code 01 current falls within a particular current range.

The center of the distribution represents the most typical behavior.

The width represents variation.

A narrow distribution means:

```text
small mismatch → good consistency
```

A wide distribution means:

```text
large mismatch → more chip-to-chip variation
```

The mean is approximately 9.924 µA, while the nominal TT result is approximately 9.910 µA.

Therefore, the Monte Carlo mean is very close to the nominal operating point.

---

# 14. What Does Sigma Mean?

The standard deviation, σ, is a measure of spread.

For Code 01:

$$\sigma \approx 0.344\mu A$$

Approximately:

```text
Mean ± 1σ → typical spread
Mean ± 2σ → larger spread
Mean ± 3σ → very wide statistical range
```

For a roughly Gaussian distribution, ±3σ represents a very high fraction of the expected population.

Therefore, the ±3σ lines are useful for estimating the practical variation range.

Important:

> ±3σ is a statistical indicator; it is not a guarantee that no fabricated chip will ever fall outside those limits.

---

# 15. Monte Carlo DNL Analysis

<img width="2048" height="1280" alt="monte_carlo_DNL" src="https://github.com/user-attachments/assets/afedbfd2-fec1-4058-ba9d-642faedf3dc3" />

*Figure: Monte Carlo DNL distribution.*

DNL means:

**Differential Non-Linearity**

DNL tells us how much each actual DAC step differs from the ideal one-LSB step.

For the three steps:

$$Step_1=I_{01}$$

$$Step_2=I_{10}-I_{01}$$

$$Step_3=I_{11}-I_{10}$$

The script calculates the average LSB for each Monte Carlo run:

$$LSB=\frac{Step_1+Step_2+Step_3}{3}$$

Then:

$$DNL_1=\frac{Step_1}{LSB}-1$$

$$DNL_2=\frac{Step_2}{LSB}-1$$

$$DNL_3=\frac{Step_3}{LSB}-1$$

The three DNL distributions are combined into one histogram.

---

# 16. Understanding the DNL Histogram

<img width="2048" height="1280" alt="monte_carlo_DNL" src="https://github.com/user-attachments/assets/69b69724-b5eb-4ba4-9c36-3f427cee23f3" />

*The DNL distribution is centered close to 0 LSB.*

The DNL histogram is centered extremely close to zero:

```text
Mean DNL ≈ 0 LSB
Sigma ≈ 0.0212 LSB
```

The plotted limits are approximately:

```text
-3σ ≈ -0.0636 LSB
+3σ ≈ +0.0636 LSB
```

### What does DNL = 0 mean?

If:

$$DNL=0$$

then:

$$Actual\ Step = Ideal\ LSB$$

Therefore, zero DNL means perfect step size.

### What does positive DNL mean?

Positive DNL means:

```text
Actual step > ideal LSB
```

### What does negative DNL mean?

Negative DNL means:

```text
Actual step < ideal LSB
```

### What does this result tell us?

The distribution is concentrated around zero and has a relatively small standard deviation.

Therefore:

> The current-steering DAC maintains good step-size uniformity under the random variations represented by this Monte Carlo simulation.

The worst observed DNL from the supplied 200-run data is approximately:

```text
Max |DNL| ≈ 0.075 LSB
```

This is still relatively small compared with 1 LSB.

---

# 17. Monte Carlo INL Analysis

<img width="2048" height="1280" alt="monte_carlo_INL" src="https://github.com/user-attachments/assets/85bbf886-6db5-4fc3-83f3-226feba003f6" />

*Figure: Monte Carlo INL distribution.*

INL means:

**Integral Non-Linearity**

INL tells us how far the DAC output codes deviate from the ideal transfer characteristic.

The analysis uses the endpoint method.

For each Monte Carlo run:

```text
Code 00 ≈ 0
Code 11 = I11
```

Therefore:

$$LSB_{endpoint}=\frac{I_{11}}{3}$$

The ideal outputs are:

$$I_{01,ideal}=LSB_{endpoint}$$

$$I_{10,ideal}=2LSB_{endpoint}$$

Then:

$$INL_1=\frac{I_{01}-I_{01,ideal}}{LSB_{endpoint}}$$

$$INL_2=\frac{I_{10}-I_{10,ideal}}{LSB_{endpoint}}$$

This is the endpoint-method INL calculation implemented in the analysis script.

---

# 18. Understanding the INL Histogram

<img width="2048" height="1280" alt="monte_carlo_INL" src="https://github.com/user-attachments/assets/8ae4facd-08ff-4d87-bd50-2d4c9d90c372" />

*The INL distribution is centered close to 0 LSB.*

The Monte Carlo INL histogram has approximately:

```text
Mean INL ≈ +0.0013 LSB
Sigma ≈ 0.0209 LSB
```

The plotted limits are approximately:

```text
-3σ ≈ -0.0613 LSB
+3σ ≈ +0.0639 LSB
```

The distribution is centered very close to zero.

This is desirable.

### Why?

If INL is close to zero:

```text
Actual DAC transfer
        ↓
close to
        ↓
Ideal straight-line transfer
```

Therefore:

> The Monte Carlo results indicate that random mismatch produces only a small deviation from the ideal DAC transfer characteristic.

The maximum absolute INL observed in the supplied 200-run data is approximately:

```text
Max |INL| ≈ 0.0651 LSB
```

---

# 19. DNL vs INL — Important Difference

It is important not to confuse DNL and INL.

## DNL

Looks at:

```text
ONE STEP
```

Question:

> Is this individual DAC step equal to 1 LSB?

Example:

```text
Ideal step = 10 µA
Actual step = 10.2 µA

DNL > 0
```

---

## INL

Looks at:

```text
OVERALL TRANSFER
```

Question:

> How far is the actual DAC code from the ideal straight-line characteristic?

Example:

```text
Ideal Code 10 = 20 µA
Actual Code 10 = 20.3 µA

INL > 0
```

So:

```text
DNL → step-size error
INL → accumulated/overall transfer-linearity error
```

---

# 20. Monte Carlo Results Summary

The supplied 200-run Monte Carlo data gives approximately:

| Parameter | Mean | Sigma | Observed Range / Max Error |
|---|---:|---:|---:|
| I01 | 9.924 µA | 0.344 µA | 9.009–10.813 µA |
| I10 | 19.835 µA | 0.562 µA | 18.558–21.371 µA |
| I11 | 29.732 µA | 0.759 µA | 27.654–31.859 µA |
| DNL | ~0 LSB | 0.0212 LSB | Max \|DNL\| ≈ 0.0751 LSB |
| INL | 0.0013 LSB | 0.0209 LSB | Max \|INL\| ≈ 0.0651 LSB |

The Monte Carlo mean current for Code 01 is very close to the nominal TT result.

The three average current steps are approximately:

```text
Step 1 = 9.924 µA
Step 2 = 9.911 µA
Step 3 = 9.897 µA
```

The average LSB from the three steps is approximately:

$$LSB\approx9.911\mu A$$

This shows that the three current steps are very close to one another.

---

# 21. Why Do I10 and I11 Have Larger Absolute Sigma?

Notice:

```text
I01 sigma ≈ 0.344 µA
I10 sigma ≈ 0.562 µA
I11 sigma ≈ 0.759 µA
```

The absolute variation increases as more current branches contribute to the output.

This does **not automatically mean that Code 11 is worse**.

For DAC performance, normalized errors such as DNL and INL are more informative than absolute current sigma alone.

The DNL and INL results are both centered close to zero with relatively small spread.

Therefore, the important result is that the **relative matching between current steps remains good**.

---

# 22. How PVT and Monte Carlo Complement Each Other

These two analyses answer different questions.

## PVT

```text
Process
Voltage
Temperature
```

asks:

> Does the DAC continue to operate correctly when global operating conditions change?

---

## Monte Carlo

```text
Random device variation
Mismatch
Statistical spread
```

asks:

> How much can individual fabricated DAC instances differ from one another?

---

Together:

```text
                 DAC Verification
                       |
             +---------+---------+
             |                   |
            PVT              Monte Carlo
             |                   |
       Global variation      Random variation
             |                   |
       VDD / Temp /          Mismatch /
       Process corners       statistical spread
             |                   |
             +---------+---------+
                       |
                 Robustness
                  assessment
```

This is why performing both analyses gives much stronger evidence than a nominal transient simulation alone.

---

# 23. What the Complete Set of Graphs Tells Us

### PVT figures

<img width="2048" height="1280" alt="PVT_VDD" src="https://github.com/user-attachments/assets/8daa3ca6-9a6b-4c18-a274-d3bebd260bbb" />

<img width="2048" height="1280" alt="PVT_Temperature" src="https://github.com/user-attachments/assets/66c04ef7-2de9-4a0b-9c9f-41ab31e5c5d9" />

<img width="2048" height="1280" alt="PVT_Process" src="https://github.com/user-attachments/assets/dbb5f77a-54d8-45b5-81e2-33758cb24b7f" />

### Monte Carlo figures

<img width="2048" height="1280" alt="monte_carlo_I01" src="https://github.com/user-attachments/assets/d76f83b8-4f06-4bec-988f-6263c9bddc86" />

<img width="2048" height="1280" alt="monte_carlo_DNL" src="https://github.com/user-attachments/assets/885870d8-1b1c-4d82-9540-41479173fdef" />

<img width="2048" height="1280" alt="monte_carlo_INL" src="https://github.com/user-attachments/assets/eb79a2d7-31f9-46b8-94cd-f532fa623b52" />

## Graph 1 — PVT VDD

Shows supply sensitivity.

Observation:

> Output current increases with VDD, while the code-to-code current ratio remains approximately preserved.

---

## Graph 2 — PVT Temperature

Shows temperature sensitivity.

Observation:

> Output current changes gradually with temperature, and the three DAC code currents remain approximately proportional.

---

## Graph 3 — PVT Process

Shows manufacturing process sensitivity.

Observation:

> Process corner has a significant effect on absolute output current, but the intended 1:2:3 code relationship remains reasonably preserved.

---

## Graph 4 — Monte Carlo I01

Shows random output-current variation.

Observation:

> Code 01 is centered near 9.924 µA with σ ≈ 0.344 µA over 200 simulations.

---

## Graph 5 — Monte Carlo DNL

Shows random variation in DAC step sizes.

Observation:

> DNL is centered essentially at zero with σ ≈ 0.0212 LSB, indicating good step-size matching.

---

## Graph 6 — Monte Carlo INL

Shows random variation in overall DAC linearity.

Observation:

> INL is centered near zero with σ ≈ 0.0209 LSB, indicating small deviation from the ideal transfer characteristic.

---

# 24. What Does "Robust DAC" Mean Here?

A robust DAC does not necessarily mean:

```text
Output current never changes.
```

Instead, it means:

```text
Output current changes predictably
+
DAC code relationships remain correct
+
Linearity remains acceptable
+
Random mismatch does not cause large errors
```

Your simulations show that:

- Absolute current is sensitive to VDD.
- Absolute current changes with temperature.
- Absolute current changes significantly with process corner.
- The intended code scaling remains approximately 1:2:3.
- Monte Carlo DNL remains close to zero.
- Monte Carlo INL remains close to zero.
- Code 01 has a relatively compact statistical distribution.
- The supplied 200-run Monte Carlo data provides evidence of good current-step matching.

---

# 25. Important Limitation of the Present Analysis

The results should be described accurately.

The current simulations demonstrate:

- transient DAC operation
- PVT sensitivity
- Monte Carlo current variation
- DNL
- INL

However, these results alone do **not** establish every possible DAC specification.

For a more complete DAC characterization, additional analyses could include:

- monotonicity
- offset error
- gain error
- settling time
- glitch energy
- power consumption
- output compliance
- PSRR
- supply sensitivity
- temperature coefficient
- mismatch versus device area
- larger Monte Carlo sample count
- post-layout parasitic simulation

Therefore, the correct conclusion is not:

> "The DAC is perfect."

Instead:

> "The simulated DAC demonstrates correct 2-bit current-steering operation and shows relatively small DNL/INL variation under the performed Monte Carlo analysis, while PVT analysis reveals the expected dependence of absolute output current on supply, temperature, and process."

---

# 26. Final Conclusion

The 2-bit current-steering DAC was successfully simulated using the SKY130 device models and ngspice.

The nominal operation demonstrates the expected four-code behavior, with the active DAC output currents approximately following:

$$0,\;1I_{LSB},\;2I_{LSB},\;3I_{LSB}$$

The PVT analysis shows that the **absolute output current is sensitive to supply voltage, temperature, and process corner**. Supply and process variations produce noticeable changes in output current, while temperature produces a comparatively smaller change in the simulated range.

Despite these absolute-current variations, the DAC maintains an approximately proportional relationship between Code 01, Code 10, and Code 11.

The 200-run Monte Carlo analysis investigates random device variation. The Code 01 current has a mean of approximately **9.924 µA** with a standard deviation of approximately **0.344 µA**. The DNL distribution has a mean essentially equal to zero and σ ≈ **0.0212 LSB**, while the INL distribution has a mean of approximately **0.0013 LSB** and σ ≈ **0.0209 LSB**.

The maximum absolute DNL and INL observed in the supplied 200-run dataset are approximately **0.075 LSB** and **0.065 LSB**, respectively.

Therefore, the overall simulation indicates:

```text
Correct DAC functionality
        +
Approximately 1:2:3 current scaling
        +
Expected PVT dependence
        +
Small Monte Carlo DNL
        +
Small Monte Carlo INL
        =
Good simulated robustness for the analyzed conditions
```

The most important engineering conclusion is:

> **The DAC does not produce a perfectly constant absolute current under all conditions, but it preserves its intended digital-to-current relationship reasonably well, and the Monte Carlo results indicate that random mismatch produces only small DNL and INL errors in the simulated 200-run population.**

---

# 27. Simulation Pictures and Evidence

### DAC schematics

<img width="1728" height="874" alt="dac_schematic" src="https://github.com/user-attachments/assets/2d18233e-aa92-4aad-bdf3-47afb6786c66" />

<img width="1811" height="915" alt="dac_schematic_detail" src="https://github.com/user-attachments/assets/810ee482-91d6-45ad-9023-78c27c51c238" />

<img width="1861" height="990" alt="voltage_variation_circuit" src="https://github.com/user-attachments/assets/7d993c5d-b573-409c-be98-ca1ca85622b3" />

### Representative ngspice measurement output

<img width="901" height="252" alt="nominal_measurements" src="https://github.com/user-attachments/assets/53995cfc-2598-4a95-8f20-d1a3a2c8e223" />

<img width="839" height="740" alt="simulation_setup" src="https://github.com/user-attachments/assets/280766c3-a528-4d85-8f8a-576d11193563" />

<img width="1410" height="444" alt="measurement_result_1" src="https://github.com/user-attachments/assets/ee52595f-1b76-422e-b956-8d1cfe527a5f" />

<img width="1778" height="532" alt="measurement_result_2" src="https://github.com/user-attachments/assets/c45897ca-3cdc-485d-99ef-62cfc05dad18" />

<img width="1401" height="417" alt="measurement_result_3" src="https://github.com/user-attachments/assets/9ce4b936-9b69-4835-9799-c4c3655f83b4" />

<img width="1382" height="433" alt="measurement_result_4" src="https://github.com/user-attachments/assets/9f7ccd20-b637-470e-a91c-1e3e60e00ee2" />

### Representative PVT raw outputs

<img width="2048" height="1280" alt="pvt_vdd_raw" src="https://github.com/user-attachments/assets/1ef42b12-8837-4da0-8920-18f77babe343" />

<img width="1374" height="513" alt="vdd_1 63v_raw" src="https://github.com/user-attachments/assets/4dea09b7-02ee-4c10-9094-32a6c3894ee4" />

<img width="1325" height="507" alt="vdd_1 98v_raw" src="https://github.com/user-attachments/assets/3804524d-f078-4e87-8164-39bc197200cb" />

<img width="1644" height="459" alt="temp_minus40_raw" src="https://github.com/user-attachments/assets/05a7c793-86b3-4e90-9049-cb46879475ea" />

<img width="1778" height="532" alt="temp_125_raw" src="https://github.com/user-attachments/assets/3b3f8ac7-de89-4d25-accc-48b29dcbcb82" />

<img width="1446" height="478" alt="process_ss_raw" src="https://github.com/user-attachments/assets/0edae566-12da-4d0e-b7e3-e8da2d510343" />

<img width="1382" height="433" alt="process_ff_raw" src="https://github.com/user-attachments/assets/c7c26d14-dfe3-4085-aacc-51cd78f94135" />

<img width="1401" height="417" alt="process_fs_raw" src="https://github.com/user-attachments/assets/f6ebff1d-dc4c-46c0-8ed1-138e4aa47a79" />

<img width="1410" height="444" alt="process_sf_raw" src="https://github.com/user-attachments/assets/e96cdb37-3618-4bb6-9c94-426b70871d02" />

# 28. Files Generated in This Analysis

## PVT

```text
PVT_VDD.png
PVT_Temperature.png
PVT_Process.png
```

These correspond to:

```text
Output current vs Supply Voltage
Output current vs Temperature
Output current vs Process Corner
```

## Monte Carlo

```text
monte_carlo_I01.png
monte_carlo_DNL.png
monte_carlo_INL.png
```

These correspond to:

```text
Code 01 output-current distribution
DNL distribution
INL distribution
```

## Simulation/data files

```text
mc_dac.spice
mc_results.txt
mc_results generation script
plot_pvt.py
plot_mc.py
```

The Monte Carlo data contains 200 simulation runs, with I00, I01, I10 and I11 recorded for each run.

---

# 28. One-Sentence Explanation for a Viva/Presentation

If asked:

### "Why did you perform PVT and Monte Carlo analysis?"

Answer:

> **"PVT analysis checks whether the DAC maintains correct operation under process, supply-voltage, and temperature variations, while Monte Carlo analysis checks the effect of random device mismatch and statistically evaluates output-current variation and DAC linearity through DNL and INL."**

### "What does your Monte Carlo result show?"

Answer:

> **"For 200 random simulations, the DNL and INL distributions remain centered close to zero with small standard deviations, indicating that the current-steering branches maintain good matching and the DAC retains good simulated linearity."**

### "What is the main conclusion from PVT?"

Answer:

> **"The absolute output current varies with VDD, temperature, and process corner, but the approximately 1:2:3 current relationship between DAC codes is maintained reasonably well."**
