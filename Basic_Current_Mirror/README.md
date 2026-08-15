# 🔁 Basic NMOS Current Mirror

A basic NMOS current mirror was designed and simulated using the **Sky130 PDK**, **Xschem**, and **ngspice**.

The main objective of this project is to understand:

- How a MOSFET current mirror copies a reference current
- How current can be scaled using transistor dimensions
- Why the output transistor must remain in saturation
- What compliance voltage means
- How channel-length modulation affects the output current
- How the output characteristics of a current mirror are obtained

---

## 🛠️ Tools Used

- **Xschem** — Schematic capture
- **ngspice** — Circuit simulation
- **Sky130 PDK** — MOSFET device models
- NMOS device: `nfet_01v8`

---

# 1. 📌 What is a Current Mirror?

A **current mirror** is a circuit used to copy a reference current from one branch to another.

The basic idea is:

> A reference MOSFET establishes a particular gate-to-source voltage, and another MOSFET receives the same gate-to-source voltage so that it produces approximately the same current.

A basic NMOS current mirror consists of:

1. A reference MOSFET
2. An output MOSFET
3. Commonly connected gates
4. Commonly connected sources
5. A diode-connected reference MOSFET, where its gate and drain are shorted together

In this project:

- **M2** is used as the reference MOSFET.
- **M1** is used as the output MOSFET.

The transistor names are arbitrary; the connections are what determine the operation.


<img width="692" height="702" alt="image" src="https://github.com/user-attachments/assets/fefecb01-cffd-48f0-bd01-b7b4f593c794" />

---

# 2. 🔗 Why are the Gate and Drain Shorted?

The reference transistor is called **diode-connected** because its gate and drain are electrically connected.

<img width="1024" height="682" alt="image" src="https://github.com/user-attachments/assets/d5f54cc5-6ad1-412a-b1a7-4348bd50827a" />

Because the gate and drain are connected,

$$
V_D = V_G
$$

and since the source is connected to ground,

$$
V_{DS} = V_{GS}
$$

For an NMOS transistor to operate in saturation,

$$
V_{DS} \geq V_{GS}-V_{TH}
$$

Since the diode-connected transistor has

$$
V_{DS}=V_{GS}
$$

the saturation condition becomes

$$
V_{GS} \geq V_{GS}-V_{TH}
$$

which is satisfied when the transistor is turned on.

Therefore, a diode-connected NMOS naturally operates in saturation (or at the saturation boundary when it is just turning on).

---

# 3. 🧠 How Does the Reference MOSFET Establish $V_{GS}$?

Suppose an ideal current source forces

$$
I_{REF}=100\,\mu A
$$

through the diode-connected MOSFET.

The MOSFET must establish whatever gate-to-source voltage is necessary to conduct that current.

Therefore, the circuit settles at an operating point where

$$
I_D \approx 100\,\mu A
$$

and a corresponding gate-to-source voltage is established:

$$
V_{GS}=V_X
$$

The important idea is:

> The reference current forces the diode-connected MOSFET to establish the required $V_{GS}$.

That $V_{GS}$ is then applied to the output MOSFET.

---

# 4. 🔄 Why is Another MOSFET Connected to the Reference MOSFET?

Suppose the reference branch establishes

$$
I_{REF}=100\,\mu A
$$

and another circuit also needs approximately 100 µA.

Instead of directly connecting the second circuit to the reference node, another MOSFET is used as a separate output branch.

```text
             Reference branch        Output branch

                 IREF                    IOUT
                  │                       │
                  │                       │
                 M2                      M1
            diode-connected
                  │                       │
                 GND                     GND

          Gate M2 ───────────────── Gate M1
```

Because both transistors receive the same $V_{GS}$, matched transistors operating in saturation produce approximately related currents.

For identical devices:

$$
I_{OUT}\approx I_{REF}
$$

For different transistor dimensions, the current is scaled according to the $W/L$ ratio.

---

# 5. ❓ Why Not Connect Several Loads Directly to the Reference Node?

The reference node is responsible for establishing the gate voltage.

If an additional circuit is connected directly to this node, it can draw additional current from the reference branch.

The reference circuit then has to find a new operating point.

For example, when a resistor is used to generate the reference current,

$$
I_{REF}=\frac{V_{DD}-V_X}{R}
$$

If the required current changes, the node voltage $V_X$ changes.

Since

$$
V_{GS}=V_X
$$

the MOSFET gate voltage also changes.

Therefore, the original reference operating point is disturbed.

The current mirror avoids this by creating a **separate output current path** while sharing the gate voltage.

---

# 6. ⚙️ How Does the Current Mirror Work?

The operation can be understood in the following sequence:

1. The reference current source forces $I_{REF}$.
2. M2 is diode-connected.
3. M2 establishes a particular $V_{GS}$.
4. The gate of M1 is connected to the same node.
5. Therefore, M1 receives the same $V_{GS}$.
6. M1 produces an output current determined by its $W/L$ ratio and operating conditions.

For matched devices operating in saturation:

$$
I_{OUT}\approx I_{REF}
$$

This is the fundamental operation of the current mirror.

---

# 7. 📐 Current Scaling

For an ideal long-channel MOSFET operating in saturation,

$$
I_D =
\frac{1}{2}\mu_n C_{ox}
\frac{W}{L}
(V_{GS}-V_{TH})^2
$$

Since the two transistors have the same VGS, the ideal current ratio is

IOUT / IREF = (W/L)OUT / (W/L)REF

Therefore,

IOUT = IREF × [(W/L)OUT / (W/L)REF]


If both transistors have the same channel length,

IOUT ≈ IREF × (WOUT / WREF)

### Example

If

$$
I_{REF}=100\,\mu A
$$

and the output transistor is four times wider,

$$
\frac{W_{OUT}}{W_{REF}}=4
$$

then the ideal output current is

Then the ideal output current is:

**I_OUT = 4 × 100 µA = 400 µA**
---

# 8. 🧪 Simulation Setup

An **ideal 100 µA current source** was used as the reference current.

This was intentionally chosen as the main setup because it allows the current-mirror behavior to be studied independently of the circuit used to generate the reference current.

The reference branch and output branch were supplied using 1.8 V.

The current source represents the assumption:

> A 100 µA reference current is already available. Now investigate how accurately the MOSFET mirror copies and scales it.

<img width="1033" height="517" alt="01_dc_sweep_setup" src="https://github.com/user-attachments/assets/cdd5c420-38a3-4188-86f1-550117753b45" />

---

# 9. 🔬 1:1 Current Mirror

For the 1:1 mirror, both transistors were configured with:

$$
W_{REF}=1\,\mu m
$$

$$
L_{REF}=1\,\mu m
$$

and

$$
W_{OUT}=1\,\mu m
$$

$$
L_{OUT}=1\,\mu m
$$

The reference current was

$$
I_{REF}=100\,\mu A
$$

The simulated output current was approximately

$$
I_{OUT}=100.609\,\mu A
$$

<img width="1126" height="535" alt="02_1to1_mirror" src="https://github.com/user-attachments/assets/a299f586-35c2-42d1-bd10-0da6181c3c27" />

### Result

| Parameter | Value |
|---|---:|
| Reference current | 100.000 µA |
| Simulated output current | 100.609 µA |
| Ideal output current | 100.000 µA |
| Current error | 0.61% |

The negative sign shown by ngspice for `i(V2)` is due to the voltage-source current direction convention. The magnitude is used here as the output current.

---

# 10. 📊 Current Scaling Experiments

The reference transistor was kept at

$$
W_{REF}=1\,\mu m
$$

$$
L_{REF}=1\,\mu m
$$

and the output transistor width was increased.

---

## 10.1 2:1 Current Scaling

For

$$
W_{OUT}=2\,\mu m
$$

and

$$
L_{OUT}=1\,\mu m
$$

the ideal current is

$$
I_{OUT}=2(100\,\mu A)=200\,\mu A
$$

The simulated current was approximately

$$
I_{OUT}=213.660\,\mu A
$$

<img width="1184" height="527" alt="03_2to1_mirror" src="https://github.com/user-attachments/assets/380578d1-73db-4444-bc16-c2b110c056ec" />

| Width Ratio | Ideal Current | Simulated Current | Error |
|---:|---:|---:|---:|
| 2:1 | 200 µA | 213.660 µA | 6.83% |

---

## 10.2 4:1 Current Scaling

For

$$
W_{OUT}=4\,\mu m
$$

and

$$
L_{OUT}=1\,\mu m
$$

the ideal current is

$$
I_{OUT}=4(100\,\mu A)=400\,\mu A
$$

The simulated current was approximately

$$
I_{OUT}=434.899\,\mu A
$$

<img width="1127" height="504" alt="04_4to1_mirror" src="https://github.com/user-attachments/assets/13479f17-fb9a-4d67-ad04-77c62378429f" />

| Width Ratio | Ideal Current | Simulated Current | Error |
|---:|---:|---:|---:|
| 4:1 | 400 µA | 434.899 µA | 8.72% |

---

## 10.3 8:1 Current Scaling

For

$$
W_{OUT}=8\,\mu m
$$

and

$$
L_{OUT}=1\,\mu m
$$

the ideal current is

$$
I_{OUT}=8(100\,\mu A)=800\,\mu A
$$

The simulated current was approximately

$$
I_{OUT}=888.421\,\mu A
$$

<img width="1147" height="514" alt="05_8to1_mirror" src="https://github.com/user-attachments/assets/6199552b-59fa-440a-afb2-fdcdc8e9aa54" />

| Width Ratio | Ideal Current | Simulated Current | Error |
|---:|---:|---:|---:|
| 8:1 | 800 µA | 888.421 µA | 11.05% |

---

# 11. 📋 Current Scaling Summary

| Width Ratio $W_{OUT}/W_{REF}$ | $L_{REF}=L_{OUT}$ | $I_{REF}$ | Ideal $I_{OUT}$ | Simulated $I_{OUT}$ | Error |
|---:|---:|---:|---:|---:|---:|
| 1:1 | 1 µm | 100 µA | 100 µA | 100.609 µA | 0.61% |
| 2:1 | 1 µm | 100 µA | 200 µA | 213.660 µA | 6.83% |
| 4:1 | 1 µm | 100 µA | 400 µA | 434.899 µA | 8.72% |
| 8:1 | 1 µm | 100 µA | 800 µA | 888.421 µA | 11.05% |

### Observation

The output current increases approximately according to the width ratio, but the simulated current becomes progressively higher than the ideal prediction.

This is because the ideal square-law equation is an approximation. The Sky130 BSIM model includes several non-ideal device effects, including:

- Channel-length modulation
- Short-channel effects
- Mobility effects
- Other model-dependent effects

---

# 12. 📏 Effect of Channel Length

For the ideal MOSFET equation,

$$
I_D\propto\frac{W}{L}
$$

Therefore, increasing $L$ reduces the current for the same $W$ and $V_{GS}$.

However, increasing channel length also reduces the effect of channel-length modulation.

A shorter channel generally has stronger channel-length modulation and lower output resistance.

A longer channel generally has weaker channel-length modulation and higher output resistance.

Therefore,

$$
L\uparrow
\quad\Rightarrow\quad
\text{channel-length modulation}\downarrow
$$

and

$$
L\uparrow
\quad\Rightarrow\quad
r_o\uparrow
$$

This gives an important analog-design trade-off:

> A longer channel can improve current-source accuracy, but it also reduces current for a given $W$ and $V_{GS}$.

---

# 13. 🔌 Why Doesn't the Output Current Stay Exactly Constant?

An ideal current source would provide a perfectly constant current independent of output voltage.

A real MOSFET does not behave this way.

Including channel-length modulation, the saturation current can be approximated as

$$
I_D=
\frac{1}{2}\mu_n C_{ox}
\frac{W}{L}
(V_{GS}-V_{TH})^2
(1+\lambda V_{DS})
$$

where $\lambda$ is the channel-length modulation parameter.

The term

$$
(1+\lambda V_{DS})
$$

causes the current to increase slightly as $V_{DS}$ increases.

Therefore,

$$
V_{DS}\uparrow
\quad\Rightarrow\quad
I_D\uparrow
$$

even though the MOSFET remains in saturation.

---

# 14. 🧪 Demonstrating Channel-Length Modulation

For the 8:1 mirror, the output supply was changed while keeping the reference branch unchanged.

At

$$
V_{OUT}=1.8\,V
$$

the simulated current was approximately

$$
I_{OUT}=888.421\,\mu A
$$

When the output supply was reduced to

$$
V_{OUT}=1.0\,V
$$

the simulated current became approximately

$$
I_{OUT}=860.883\,\mu A
$$

<img width="1158" height="486" alt="07_8to1_at_1V" src="https://github.com/user-attachments/assets/763ad328-0440-438c-8abf-cafa938cbfd3" />

| Output Voltage $V_{OUT}$ | Simulated Output Current |
|---:|---:|
| 1.8 V | 888.421 µA |
| 1.0 V | 860.883 µA |

The current changed by approximately

$$
888.421-860.883=27.538\,\mu A
$$

which corresponds to approximately

$$
\frac{27.538}{888.421}\times100\approx3.10\%
$$

This demonstrates that the output current is not perfectly independent of $V_{DS}$.

---

# 15. ⚡ Output Characteristics

The output voltage was swept from 0 V to 1.8 V to study how the output current changes with $V_{OUT}$.

The ngspice DC sweep used was:

```spice
.dc V2 0 1.8 0.01
```

Here, `V2` is the output voltage source.

The output current was plotted using:

```spice
plot -i(V2) vs v(vout)
```

<img width="1033" height="517" alt="01_dc_sweep_setup" src="https://github.com/user-attachments/assets/853f315e-d08f-45eb-9bb7-95da60023c3a" />

<img width="1262" height="691" alt="08_output_characteristics" src="https://github.com/user-attachments/assets/1bb2495b-2772-42fb-8a62-6f9d2c419463" />

---

# 16. 📈 Understanding the Output Characteristic

The output-characteristic curve shows how the output current changes as the output voltage is increased.

There are two important operating regions.

## 16.1 Triode Region

At low $V_{OUT}$, the output MOSFET is in the triode region.

For an NMOS, the saturation condition is

$$
V_{DS}\geq V_{GS}-V_{TH}
$$

Since the source is connected to ground,

$$
V_{DS}=V_{OUT}
$$

Therefore, the output transistor remains in saturation only when

$$
V_{OUT}\geq V_{GS}-V_{TH}
$$

When this condition is not satisfied, the transistor enters triode.

In the triode region:

- Current changes strongly with output voltage.
- The transistor behaves more like a voltage-controlled resistor.
- The current mirror does not behave like a good current source.

This is the rising portion of the output-characteristic graph.

---

# 17. 🚦 Compliance Voltage

The minimum output voltage required to keep the output transistor in saturation is called the **compliance voltage**.

For the basic NMOS current mirror,

$$
V_{OUT(min)}
\approx
V_{GS}-V_{TH}
$$

If

$$
V_{OUT}<V_{OUT(min)}
$$

the output transistor enters triode and the mirrored current falls.

If

$$
V_{OUT}\geq V_{OUT(min)}
$$

the output transistor can remain in saturation and the current becomes nearly constant.

From the simulated output-characteristic curve, the transition to the nearly constant-current region occurs at approximately **0.65–0.7 V**.

---

# 18. 📉 Channel-Length Modulation in the Output Characteristic

For an ideal MOSFET, the saturation-region curve would be perfectly flat:

```text
I_D
 │
 │       ─────────────────
 │
 │
 └────────────────────────── V_DS
```

A real MOSFET has a slight positive slope:

```text
I_D
 │             /
 │           /
 │──────────/
 │
 └────────────────────────── V_DS
```

The slight slope in the simulated saturation region is caused by **channel-length modulation**.

As $V_{DS}$ increases, the drain depletion region extends further into the channel. The effective channel length becomes slightly shorter.

Therefore, the drain current increases slightly.

The output characteristic obtained in this project clearly shows this behavior.

---

# 19. 🔋 Output Resistance

The slope of the saturation-region curve is related to the output resistance.

Approximately,

$$
r_o=
\frac{\Delta V_{DS}}{\Delta I_D}
$$

A flatter curve means a larger output resistance.

Therefore,

$$
r_o\uparrow
\quad\Rightarrow\quad
\text{better current-source behavior}
$$

A basic current mirror has finite output resistance because of channel-length modulation.

This is one of the reasons more advanced current mirrors, such as **cascode current mirrors**, are used in analog circuits.

---

# 20. 🧮 Practical Reference Current Using a Resistor

Although the main experiment uses an ideal current source, a resistor can also be used to generate the reference current.

The arrangement is:

```text
        VDD
         │
         R
         │
         ●──── Gate = Drain
         │
        MREF
         │
        GND
```

The approximate reference current is:

**I_REF = (V_DD − V_GS) / R**

Therefore, the required resistor can be estimated using:

**R = (V_DD − V_GS) / I_REF**

In one simulation, a 7.5 kΩ resistor produced approximately

$$
I_{REF}=97.88\,\mu A
$$

with the reference-node voltage approximately

$$
V_X=1.066\,V
$$

<img width="1120" height="567" alt="06_resistor_bias" src="https://github.com/user-attachments/assets/3cf8f86b-0b55-4b4c-a3c2-30156689eb6a" />

The resistor approach demonstrates how a reference current can be generated, but the ideal current source was kept as the main setup so that the current-mirror behavior could be studied independently.

---

# 21. 🤔 Important Questions and Answers

## Q1. Does a MOSFET automatically generate a fixed current?

No.

A MOSFET is not an ideal current source.

Its drain current depends on several parameters, including:

- $V_{GS}$
- $V_{DS}$
- $W/L$
- Temperature
- Process parameters

A current mirror uses the MOSFET's characteristics to create a controlled current source, but the current is not perfectly independent of all external conditions.

---

## Q2. Does the diode-connected MOSFET guarantee saturation?

For an NMOS that is turned on, the diode-connected device satisfies

$$
V_{DS}=V_{GS}
$$

while saturation requires

$$
V_{DS}\geq V_{GS}-V_{TH}
$$

Therefore, the diode-connected transistor naturally operates in saturation once it is turned on.

The output transistor is different: it requires a sufficiently high output voltage to remain in saturation.

---

## Q3. Why does the output transistor need enough drain voltage?

The output transistor must satisfy

$$
V_{DS}\geq V_{GS}-V_{TH}
$$

Since its source is at ground,

$$
V_{DS}=V_{OUT}
$$

Therefore,

$$
V_{OUT}\geq V_{GS}-V_{TH}
$$

If this condition is not satisfied, the output transistor enters triode and its current decreases.

---

## Q4. Why do both MOSFETs have approximately related currents when their gates are connected?

Connecting the gates only guarantees that both transistors have the same gate voltage.

For the currents to be approximately equal, the transistors should also have:

- Similar $W/L$ ratios
- Similar threshold voltages
- Similar process and temperature conditions
- Both devices operating in saturation

For matched devices,

$$
I_{OUT}\approx I_{REF}
$$

If the dimensions are different, the current scales approximately with $W/L$.

---

## Q5. Why can a 2× MOSFET generate approximately 2× current?

For the ideal saturation equation,

$$
I_D\propto\frac{W}{L}
$$

Therefore, if the channel length remains unchanged and the width is doubled,

$$
W_{OUT}=2W_{REF}
$$

then ideally

$$
I_{OUT}=2I_{REF}
$$

The simulation does not have to give exactly 2× because the Sky130 model includes non-ideal device effects.

---

## Q6. Why did the 8× transistor produce 888.421 µA instead of exactly 800 µA?

The ideal prediction was

$$
8\times100\,\mu A=800\,\mu A
$$

while the simulation produced

$$
888.421\,\mu A
$$

The difference occurs because the ideal square-law equation does not include all real MOSFET effects.

One important effect is channel-length modulation.

The reference and output transistors also have different $V_{DS}$ values, so their currents are not perfectly scaled only by $W/L$.

---

## Q7. Why did reducing $V_{OUT}$ from 1.8 V to 1 V reduce the output current?

Because the output current is slightly dependent on $V_{DS}$ even when the transistor is in saturation.

From the channel-length-modulation model,

$$
I_D\propto(1+\lambda V_{DS})
$$

Therefore, reducing $V_{DS}$ slightly reduces the drain current.

---

## Q8. Why not connect the output load directly to the reference node?

The reference node establishes $V_{GS}$.

Connecting an additional load directly to that node can disturb the reference operating point.

The current mirror instead creates a separate output branch. The output transistor receives the same gate voltage while its drain current flows through a separate path.

---

## Q9. Why use an ideal current source in this experiment?

The purpose of the main experiment is to study the current mirror itself.

The ideal source provides a known

$$
I_{REF}=100\,\mu A
$$

and allows the following effects to be studied independently:

- Current copying
- Current scaling
- Compliance voltage
- Channel-length modulation
- Output characteristics

The circuit used to generate the reference current can be studied separately.

---

# 22. 📊 Final Experimental Results

| Experiment | Reference Current | Output Device | Simulated Output | Main Observation |
|---|---:|---|---:|---|
| 1:1 mirror | 100 µA | $W/L=1/1$ | 100.609 µA | Very close current copying |
| 2:1 mirror | 100 µA | $W/L=2/1$ | 213.660 µA | Approximately 2× scaling |
| 4:1 mirror | 100 µA | $W/L=4/1$ | 434.899 µA | Approximately 4× scaling |
| 8:1 mirror | 100 µA | $W/L=8/1$ | 888.421 µA | Approximately 8× scaling with non-ideal error |
| 8:1 at $V_{OUT}=1.0\,V$ | 100 µA | $W/L=8/1$ | 860.883 µA | Output current depends on $V_{DS}$ |
| Resistor-biased reference | ~97.88 µA | $W/L=1/1$ | — | Demonstrated reference-current generation |

---

# 23. 🎯 Key Learnings

From this experiment, I learned that:

1. A **diode-connected MOSFET** establishes the reference $V_{GS}$.
2. Connecting the gates allows another MOSFET to receive the same $V_{GS}$.
3. A matched output transistor can approximately **copy the reference current**.
4. The output current can be **scaled using the $W/L$ ratio**.
5. The output transistor must remain in **saturation** for proper current-mirror operation.
6. The minimum output voltage required for saturation is called the **compliance voltage**.
7. A real MOSFET is not an ideal current source because of **channel-length modulation**.
8. Increasing channel length generally improves current-source behavior by increasing output resistance.
9. An ideal current source is useful for studying the current mirror independently from reference-current generation.
10. Real BSIM simulations do not exactly follow the ideal square-law equation because they include several non-ideal device effects.

---

# 24. 🚀 Conclusion

A basic NMOS current mirror was designed and characterized using the Sky130 PDK, Xschem, and ngspice.

The simulations verified current copying and current scaling by changing the $W/L$ ratio of the output transistor.

The output-current sweep demonstrated:

- The triode region
- The transition to saturation
- Compliance voltage
- The nearly constant-current region
- Channel-length modulation

The experiments also showed an important analog-design trade-off:

> **Shorter devices provide higher current density but stronger non-ideal effects, while longer devices generally provide higher output resistance and better current-source behavior.**

This basic current mirror forms the foundation for more advanced analog bias circuits such as **cascode current mirrors**, **Wilson current mirrors**, and **current-steering circuits**.

---

# 📁 Project Structure

```text
Basic_Current_Mirror/
│
├── README.md
│
├── 01_dc_sweep_setup.png
├── 02_1to1_mirror.png
├── 03_2to1_mirror.png
├── 04_4to1_mirror.png
├── 05_8to1_mirror.png
├── 06_resistor_bias.png
├── 07_8to1_at_1V.png
└── 08_output_characteristics.png
```

---

## 📷 Simulation Screenshots

All screenshots used in this README are stored in the same folder as the README so that GitHub can display them correctly.
