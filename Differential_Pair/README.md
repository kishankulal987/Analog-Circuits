# MOS Differential Pair

## 📌 Overview

A MOS differential pair is a fundamental analog circuit used to compare two input voltages and control how a constant tail current is divided between two transistor branches.

In this mini-project, a basic **NMOS differential pair** was designed and simulated using the **Sky130 PDK, Xschem, and ngspice**.

The main objective was to understand **differential operation and current steering**, which is an important concept for the **Current Steering DAC** in the final-year project.

---

## 🎯 Objectives

- Understand the operation of an NMOS differential pair.
- Study current division when both inputs are equal.
- Observe current steering when a differential input is applied.
- Verify that the total tail current remains approximately constant.
- Study the relationship between input voltage and branch currents.
- Observe the corresponding change in output voltages.

---

## 🛠️ Tools and Technology

- **PDK:** Sky130
- **Schematic:** Xschem
- **Simulation:** ngspice
- **Device:** `sky130_fd_pr__nfet_01v8`

---

## 🔧 Circuit Specifications

| Parameter | Value |
|---|---:|
| Supply voltage $V_{DD}$ | 1.8 V |
| Tail current $I_{TAIL}$ | 100 µA |
| Load resistors $R_1,R_2$ | 5 kΩ |
| NMOS width $W$ | 1 µm |
| NMOS length $L$ | 0.15 µm |
| $V_{IN-}$ | 0.9 V |
| $V_{IN+}$ | 0.7 – 1.1 V |

---

## 📐 Circuit

The circuit consists of two matched NMOS transistors, M1 and M2, sharing a common source connection and biased by a 100 µA tail current source.

Equal 5 kΩ resistors are used as the loads.

<img width="588" height="454" alt="circuit1" src="https://github.com/user-attachments/assets/37f539a0-0efd-40fe-9ed6-01c5cff5bd07" />


### Circuit operation

The tail current is approximately constant:

$$
I_{TAIL}=I_{D1}+I_{D2}
$$

When the two input voltages are equal, the current divides equally:

$$
I_{D1}=I_{D2}=\frac{I_{TAIL}}{2}
$$

When a differential voltage is applied, the current is steered toward the transistor with the higher gate voltage.

---

# 🧪 Experiment 1 — Equal Input Voltages

Initially, both input voltages were set to:

$$
V_{IN+}=V_{IN-}=0.9V
$$

Since M1 and M2 are matched, the tail current divides approximately equally.

### Simulation Results

| Parameter | Result |
|---|---:|
| $V_{IN+}$ | 0.9 V |
| $V_{IN-}$ | 0.9 V |
| $I_{D1}$ | 50.00 µA |
| $I_{D2}$ | 50.00 µA |
| $I_{D1}+I_{D2}$ | 100.00 µA |
| $V_{OUT1}$ | ≈ 1.55 V |
| $V_{OUT2}$ | ≈ 1.55 V |

The two branch currents are equal because the differential input is zero.

$$
\boxed{V_{IN+}=V_{IN-}\Rightarrow I_{D1}=I_{D2}}
$$
<img width="634" height="476" alt="matched_pair_1" src="https://github.com/user-attachments/assets/eb4e3686-0592-4b52-887e-7bccff215443" />
<img width="406" height="95" alt="matched_result_withvin1vin2" src="https://github.com/user-attachments/assets/caa0b71b-504b-477b-94e0-7c2aa70c526b" />

---

# 🧪 Experiment 2 — Negative Differential Input

The inverting input was kept at:

$$
V_{IN-}=0.9V
$$

while:

$$
V_{IN+}=0.8V
$$

Therefore:

$$
V_{IN+}\lt V_{IN-}
$$

### Simulation Results

| Parameter | Result |
|---|---:|
| $V_{IN+}$ | 0.8 V |
| $V_{IN-}$ | 0.9 V |
| $I_{D1}$ | 33.83 µA |
| $I_{D2}$ | 66.17 µA |
| $I_{D1}+I_{D2}$ | 100.00 µA |
| $V_{OUT1}$ | 1.631 V |
| $V_{OUT2}$ | 1.469 V |

Since M2 has the higher gate voltage, it conducts more current:

$$
I_{D2}\gt I_{D1}
$$

The current is therefore steered toward M2.

<img width="1249" height="535" alt="differntial_in1" src="https://github.com/user-attachments/assets/698786e6-e3e3-477c-9a67-b72a548714d0" />

---

# 🧪 Experiment 3 — Positive Differential Input

The inverting input was kept at:

$$
V_{IN-}=0.9V
$$

and:

$$
V_{IN+}=1.0V
$$

Therefore:

$$
V_{IN+}\gt V_{IN-}
$$

### Simulation Results

| Parameter | Result |
|---|---:|
| $V_{IN+}$ | 1.0 V |
| $V_{IN-}$ | 0.9 V |
| $I_{D1}$ | 66.05 µA |
| $I_{D2}$ | 33.95 µA |
| $I_{D1}+I_{D2}$ | ≈ 100.00 µA |
| $V_{OUT1}$ | 1.470 V |
| $V_{OUT2}$ | 1.630 V |

Now M1 has the higher gate voltage, so more current flows through M1:

$$
I_{D1}\gt I_{D2}
$$

<img width="1170" height="544" alt="diff_in2" src="https://github.com/user-attachments/assets/84fd0bdc-ee28-47b4-a257-112e3185d23b" />

---

# 📊 Current Steering Summary

The three important operating points are summarized below.

| $V_{IN+}$ | $V_{IN-}$ | $I_{D1}$ | $I_{D2}$ | Current Steered Toward |
|---:|---:|---:|---:|---|
| 0.8 V | 0.9 V | 33.83 µA | 66.17 µA | M2 |
| 0.9 V | 0.9 V | 50.00 µA | 50.00 µA | Equal |
| 1.0 V | 0.9 V | 66.05 µA | 33.95 µA | M1 |

This demonstrates that the **100 µA tail current is redistributed between the two branches according to the differential input voltage**.

---

# 📈 DC Sweep Experiment


To observe the complete current-steering behavior, $V_{IN+}$ was swept from:

$$
0.7V\rightarrow1.1V
$$

while keeping:

$$
V_{IN-}=0.9V
$$

The following ngspice command was used:

```spice
.dc V1 0.7 1.1 0.01
```

The branch currents were calculated from the resistor voltage drops:

$$
I_{D1}=\frac{1.8-V_{OUT1}}{5k\Omega}
$$

$$
I_{D2}=\frac{1.8-V_{OUT2}}{5k\Omega}
$$

The resulting current-steering characteristic is shown below.
<img width="833" height="564" alt="diff_sweep_circuit" src="https://github.com/user-attachments/assets/446c4211-b590-4807-b9fb-00b3f148303d" />

<img width="1271" height="697" alt="diff_in_sweep_id1_2" src="https://github.com/user-attachments/assets/107d7e3a-b7bf-42ad-8c73-209089a9b425" />

### Sweep Results

| $V_{IN+}$ | $I_{D1}$ | $I_{D2}$ |
|---:|---:|---:|
| 0.70 V | ≈ 19.0 µA | ≈ 81.0 µA |
| 0.80 V | 33.83 µA | 66.17 µA |
| 0.90 V | 50.00 µA | 50.00 µA |
| 1.00 V | 66.05 µA | 33.95 µA |
| 1.10 V | ≈ 80.4 µA | ≈ 19.6 µA |

The two currents cross at approximately:

$$
V_{IN+}=V_{IN-}=0.9V
$$

where both transistors conduct approximately half of the tail current.

---

# 📈 Output Voltage Sweep

The output voltages were also observed during the same DC sweep.

<img width="1272" height="705" alt="sweep_vout1_2" src="https://github.com/user-attachments/assets/2efafe45-388f-4b5e-ab1c-60b76995bef4" />

As $V_{IN+}$ increases:

- $I_{D1}$ increases.
- Voltage drop across $R_1$ increases.
- $V_{OUT1}$ decreases.

At the same time:

- $I_{D2}$ decreases.
- Voltage drop across $R_2$ decreases.
- $V_{OUT2}$ increases.

Therefore, the two output voltages move in opposite directions.

---

# 🧠 Key Observations

### 1. Equal input voltages

When:

$$
V_{IN+}=V_{IN-}
$$

the matched transistors share the tail current equally:

$$
I_{D1}=I_{D2}\approx50\mu A
$$

### 2. $V_{IN+}\lt V_{IN-}$

M2 receives more current:

$$
I_{D2}\gt I_{D1}
$$

Therefore, current is steered toward M2.

### 3. $V_{IN+}\gt V_{IN-}$

M1 receives more current:

$$
I_{D1}\gt I_{D2}
$$

Therefore, current is steered toward M1.

### 4. Constant total current

Throughout the operating range:

$$
\boxed{I_{D1}+I_{D2}\approx100\mu A}
$$

This confirms that the differential pair primarily **redistributes the tail current rather than creating additional current**.

### 5. Output voltages

Because resistive loads are used:

$$
V_{OUT}=V_{DD}-I_DR
$$

Therefore, increasing branch current causes the corresponding output voltage to decrease.

---

# 🔗 Relevance to Current Steering DAC

The differential pair demonstrates the fundamental concept of **current steering**.

In a differential pair:

$$
\boxed{\text{Input voltage difference} \rightarrow \text{Current steering}}
$$

In a current steering DAC:

$$
\boxed{\text{Digital control} \rightarrow \text{Current steering}}
$$

The DAC will use controlled current sources and MOS switches to direct accurately defined currents to the output.

Therefore, understanding the differential pair provides the foundation for the next stage:

**Differential Pair → Current Steering Cell → Weighted Current Sources → Current Steering DAC**

---
## 🔍 Measuring MOSFET Drain Current

The drain current of the individual MOSFETs was directly obtained from the ngspice operating-point analysis using the following commands:

```spice
print @m.xm1.msky130_fd_pr__nfet_01v8[id]
print @m.xm2.msky130_fd_pr__nfet_01v8[id]
```

Here:

- `xm1` → NMOS transistor **M1**
- `xm2` → NMOS transistor **M2**
- `[id]` → drain current of the corresponding MOSFET

For the equal-input condition:

$$
V_{IN+}=V_{IN-}=0.9\,V
$$

the measured currents were approximately:

$$
I_{D1}=50\,\mu A
$$

$$
I_{D2}=50\,\mu A
$$

For example, ngspice reports:

```text
@m.xm1.msky130_fd_pr__nfet_01v8[id] = 5.000000e-05
```

which corresponds to:

$$
5\times10^{-5}\,A=50\,\mu A
$$

This method was used to directly verify the current through each MOSFET during the operating-point experiments.
# ✅ Result

A basic NMOS differential pair was successfully designed and simulated using the Sky130 PDK, Xschem, and ngspice.

The simulation verified that the **100 µA tail current is divided between the two matched MOSFETs according to the differential input voltage**. Equal inputs produced approximately 50 µA in each branch, while changing the differential input steered more current toward the transistor with the higher gate voltage.

The DC sweep further demonstrated the complete current-steering behavior and verified:

$$
\boxed{I_{D1}+I_{D2}\approx I_{TAIL}}
$$

This experiment establishes the fundamental understanding required for designing the **current steering cell and the final Current Steering DAC**.

---

## 📚 What I Learned

- Operation of a MOS differential pair
- Differential input voltage
- Tail current source
- Current division between matched MOSFETs
- Current steering
- Effect of differential input on branch currents
- Relationship between drain current and output voltage
- Importance of transistor matching
- DC sweep analysis in ngspice
- Application of current steering to DAC architecture

---

## 🚀 Next Step

The next mini-project is:

### **Current Steering Cell**

The objective will be to replace the analog differential input control with a **digital control signal** and use MOS switches to steer a constant current between two output paths.

This will be the first circuit that directly resembles the switching structure used in the final **Current Steering DAC**.
