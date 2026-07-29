# 🔋 MOSFET as a Current Source

<div align="center">

![Sky130](https://img.shields.io/badge/Technology-Sky130-blue)
![Xschem](https://img.shields.io/badge/Simulator-Xschem-success)
![Ngspice](https://img.shields.io/badge/Simulation-ngspice-orange)
![Analog IC](https://img.shields.io/badge/Domain-Analog%20IC-red)

### Understanding MOSFET Saturation, Channel Length Modulation and Practical Current Sources

</div>

---

# 📖 Overview

This project demonstrates how an **NMOS transistor** can be used as a **practical current source** by operating it in the **saturation region**.

Unlike the previous project (**MOSFET as a Switch**), where the objective was to obtain a **small ON resistance (RON)**, this project focuses on designing a **high output resistance (ro)** device capable of supplying nearly constant current.

During this project, the following concepts were explored:

- ✅ MOSFET Output Characteristics
- ✅ Saturation Region
- ✅ Channel Length Modulation
- ✅ Output Resistance (ro)
- ✅ Effect of Channel Length
- ✅ Load Regulation
- ✅ Practical Current Source Behaviour

---

# 🎯 Objectives

- Study the output characteristics of an NMOS transistor.
- Verify MOSFET operation in the saturation region.
- Calculate the output resistance (ro).
- Observe channel-length modulation.
- Study the effect of channel length on current-source performance.
- Verify load regulation using different load resistances.
- Understand why long-channel MOSFETs are preferred in Analog IC design.

---

# 📚 Background

A current source is a circuit that attempts to deliver **constant current**, independent of the voltage across it.

An **ideal current source** maintains exactly the same current regardless of load.

A **practical current source** allows a very small variation in current.

MOSFETs operating in the saturation region behave approximately like practical current sources.

Because of this property, MOSFET current sources are widely used in

- Current Mirrors
- Differential Amplifiers
- Operational Amplifiers
- Current Steering DACs
- Analog Bias Circuits

---

# ⚙️ Theory

## MOSFET Operating Regions

The operation of an NMOS transistor can be divided into three regions.

### 1️⃣ Cutoff Region

Condition

```
VGS < VT
```

Characteristics

- No inversion channel forms.
- Drain current is approximately zero.
- MOSFET behaves like an open switch.

---

### 2️⃣ Triode (Linear) Region

Condition

```
VDS < VGS − VT
```

Characteristics

- A conductive channel exists.
- Current depends strongly on VDS.
- MOSFET behaves like a voltage-controlled resistor.

Applications

- Analog switches
- Digital switches

---

### 3️⃣ Saturation Region

Condition

```
VDS ≥ VGS − VT
```

Characteristics

- Pinch-off occurs near the drain.
- Current becomes almost independent of VDS.
- MOSFET behaves like a current source.

Applications

- Current Mirrors
- Bias Circuits
- Differential Amplifiers

---

# 🌊 What is Pinch-off?

When the drain voltage increases, the inversion channel becomes thinner near the drain.

Eventually, the channel disappears at one end.

This point is called **Pinch-off**.

Although the channel is pinched off, **current does not stop flowing**.

Electrons entering the channel are swept across the depletion region by the strong electric field near the drain.

Therefore,

- Current continues to flow.
- Drain current becomes nearly constant.

---

# 💡 Why does the MOSFET behave like a Current Source?

After pinch-off,

Increasing **VDS** no longer significantly increases the amount of inversion charge inside the channel.

Instead,

the extra voltage mainly expands the depletion region.

Therefore,

Drain current changes only slightly.

This makes the MOSFET behave approximately like a **constant current source**.

---

# 📈 Channel Length Modulation (CLM)

In an ideal MOSFET,

Drain current should remain perfectly constant in saturation.

However,

Increasing **VDS** moves the pinch-off point slightly towards the source.

Therefore,

The effective channel length decreases.

Since

```
ID ∝ 1/L
```

a shorter channel allows slightly more current to flow.

This phenomenon is called

> **Channel Length Modulation**

Because of CLM,

the output characteristics have a small positive slope instead of being perfectly horizontal.

---

# 📏 Output Resistance (ro)

The finite slope of the output characteristic is represented using the **output resistance**.

```
ro = ΔVDS / ΔID
```

Interpretation

- Large ro → Better Current Source ✅
- Small ro → Poor Current Source ❌

An ideal current source would have

```
ro = ∞
```

---

# 🧪 Simulation Environment

| Parameter | Value |
|-----------|-------|
| Technology | Sky130 PDK |
| Simulator | Xschem |
| SPICE Engine | ngspice |
| Supply Voltage | 1.8 V |
| Device | NMOS |
| Width | ______ |
| Length | 0.15 µm & 1 µm |

---

# 📝 Experiments Performed

This project consists of three experiments.

## 🔹 Experiment 1

Output Characteristics

- Plot ID vs VDS
- Observe saturation region
- Calculate output resistance (ro)

---

## 🔹 Experiment 2

Effect of Channel Length

- Compare L = 0.15 µm and L = 1 µm
- Study the effect on channel-length modulation
- Compare output resistance

---

## 🔹 Experiment 3

Load Regulation

- Vary the load resistance.
- Observe drain current.
- Observe drain voltage.
- Verify practical current-source behaviour.

---


# 🧪 Experiment 1 – Output Characteristics

## 🎯 Objective

- Plot the output characteristics of an NMOS transistor.
- Observe the transition from the triode region to the saturation region.
- Verify Channel Length Modulation.
- Calculate the output resistance (`r_o`).

---

## ⚙️ Circuit Diagram

<img width="1185" height="556" alt="circuit_diagram" src="https://github.com/user-attachments/assets/f4858368-0a51-45ee-8aea-2a5d7d555380" />


```text
images/output_characteristics_circuit.png
```


---

## 📈 Output Characteristics (L = 0.15 µm)

<img width="1260" height="695" alt="output_chara" src="https://github.com/user-attachments/assets/9322f028-6ef2-438c-9a1b-40223d91be7e" />

```text
images/output_characteristics_L015.png
```


---

## 🔍 Observation

From the graph, three important regions can be identified.

### 🔹 Triode Region

At low values of **VDS**, the drain current increases almost linearly with voltage.

The MOSFET behaves like a **voltage-controlled resistor**.

---

### 🔹 Saturation Region

When

```
VDS ≥ VGS − VT
```

the channel pinches off near the drain.

The drain current becomes almost constant.

This region is used for designing **current sources**.

---

### 🔹 Channel Length Modulation

Although the drain current is almost constant,

the graph is **not perfectly horizontal**.

A slight increase in drain current is observed with increasing **VDS**.

This indicates the presence of **Channel Length Modulation (CLM)**.

---

## 📊 Measured Values

| Parameter | Value |
|-----------|-------|
| VGS | 1.2 |
| VT | 0.6-0.7 |
| Width (W) | 1u |
| Length (L) | 0.15 µm |

---

# 📏 Output Resistance (rₒ)

The output resistance is calculated from the slope of the saturation region.

```
rₒ = ΔVDS / ΔID
```

---

## 📷 Cursor Measurement

<img width="482" height="352" alt="ro" src="https://github.com/user-attachments/assets/69f63514-67c9-4f11-89c5-d685e2d91533" />


```text
images/ro_calculation.png
```



---

## 📋 Calculation

| Quantity | Value |
|----------|-------|
| VDS₁ | 1.4 |
| ID₁ | 0.000170508 |
| VDS₂ | 1.60164 |
| ID₂ | 0.000176949 |
| ΔVDS | 0.20164 |
| ΔID | 6.441e-6 |
| **Calculated rₒ** | 31.3K |

---

## 💬 Discussion

A perfectly ideal current source would have a horizontal output characteristic.

However,

the measured graph shows a small positive slope.

This indicates that the drain current still changes slightly with drain voltage.

The finite slope is represented using the output resistance (`rₒ`).

A **larger value of `rₒ` indicates a better current source**.

---

# 🧪 Experiment 2 – Effect of Channel Length

## 🎯 Objective

To study how increasing the MOSFET channel length affects

- Channel Length Modulation
- Output Characteristics
- Output Resistance
- Current Source Performance

---

## 📷 Output Characteristics (L = 1 µm)

<img width="1251" height="694" alt="o_char_1u" src="https://github.com/user-attachments/assets/7207cfed-5113-45c6-953a-251d0416ebc1" />


```text
images/output_characteristics_L1.png
```

---

# 📊 Comparison Table

| Parameter | L = 0.15 µm | L = 1 µm |
|------------|-------------|-----------|
| Width (W) | 1u | 1u|
| Drain Current | vary | 40u |
| Output Resistance (rₒ) | 31.3K | 529.1K |
| Channel Length Modulation | Higher | Lower |
| Saturation Curve | Steeper | Flatter |
| Current Source Quality | Good | Better |

---

## 🔍 Observation

Increasing the channel length produces a noticeable improvement in current-source behaviour.

Compared to the minimum-length transistor,

the **L = 1 µm** transistor exhibits

- A flatter output characteristic
- Reduced Channel Length Modulation
- Larger output resistance
- Better current regulation

---

## 💡 Why does increasing channel length increase rₒ?

When the channel is longer,

the movement of the pinch-off point represents a much smaller percentage of the total channel length.

As a result,

the effective channel length changes less with increasing drain voltage.

This reduces Channel Length Modulation.

Therefore,

the drain current varies less with **VDS**,

making the output characteristics flatter and increasing the output resistance.

---

## 📌 Result

Increasing the MOSFET channel length significantly improves its behaviour as a practical current source.

This is the reason why **long-channel MOSFETs are widely used in Current Mirrors, Bias Circuits and Analog Integrated Circuits**, where a high output resistance is desirable.

---
# 🧪 Experiment 3 – Load Regulation

## 🎯 Objective

The objective of this experiment is to verify the **load regulation capability** of the MOSFET current source.

A practical current source should maintain an almost constant drain current even when the load resistance changes.

---

## ⚙️ Circuit Diagram

<img width="878" height="456" alt="comstant_current_load_schematic" src="https://github.com/user-attachments/assets/f7dd28b7-e0d0-4486-b1c2-c3b29c803970" />



---

## 🧪 Procedure

The MOSFET was biased in the **saturation region** with

- **Channel Length = 1 µm**
- **Width = 1u**
- **Supply Voltage = 1.8V**

The load resistance was varied while observing

- Drain Current (ID)
- Drain-to-Source Voltage (VDS)

The following load resistances were tested.

- 1 kΩ
- 2 kΩ
- 5 kΩ
- 10 kΩ

---

# 📷 Simulation Results

## 🔹 Load = 1 kΩ

<img width="485" height="359" alt="constant_CURRENT_L1k" src="https://github.com/user-attachments/assets/14055ab5-f762-4b0e-9734-13d14190f367" />



---

## 🔹 Load = 2 kΩ

<img width="483" height="356" alt="constant_current_2K" src="https://github.com/user-attachments/assets/d5696de2-2964-4650-b187-5b57f70f910d" />



---

## 🔹 Load = 5 kΩ

<img width="493" height="360" alt="constant_currnt_5k" src="https://github.com/user-attachments/assets/5bc711b4-09b0-4494-8726-a37c6dc94962" />

---

## 🔹 Load = 10 kΩ

<img width="491" height="344" alt="comstant_current_10k" src="https://github.com/user-attachments/assets/a28d8e4f-6120-42c9-badb-5618dfef5609" />



---

# 📊 Results Table

| Load Resistance | Drain Current (ID) | Drain Voltage (VDS) | Region of Operation |
|----------------|--------------------|---------------------|---------------------|
| 1 kΩ | 40.69u | 1.7593 | Saturation |
| 2 kΩ | 40.63u | 1.7187 | Saturation |
| 5 kΩ | 40.44u | 1.5977 | Saturation |
| 10 kΩ | 40.10u | 1.398 | Saturation |

---

# 📈 Observation

As the load resistance increases,

- the voltage drop across the resistor increases,
- the voltage across the MOSFET decreases,
- while the drain current remains almost constant.

This demonstrates that the MOSFET automatically adjusts its **drain-to-source voltage** to maintain nearly constant current, provided it remains in the saturation region.

---

# 📖 Discussion

For a MOSFET operating as a current source,

Kirchhoff's Voltage Law gives

```
VDD = ID × RL + VDS
```

Since the drain current is approximately constant,

an increase in load resistance increases the voltage drop across the resistor.

Because the supply voltage is fixed,

the MOSFET compensates by reducing its own drain-to-source voltage.

Therefore,

the MOSFET continuously adjusts **VDS** while attempting to maintain the same current.

This behaviour is the fundamental principle behind MOSFET current sources.

---

# ⚠️ Compliance Voltage

A MOSFET can regulate current only while it remains in saturation.

If the load resistance becomes too large,

```
VDS < VGS − VT
```

the transistor enters the **triode region**.

Once this happens,

the current source loses regulation and the drain current starts decreasing.

The minimum drain voltage required to keep the MOSFET in saturation is known as the **Compliance Voltage**.

---

# 📋 Summary of Experimental Results

| Experiment | Observation |
|------------|-------------|
| Output Characteristics | Triode and Saturation regions verified |
| Channel Length Modulation | Small increase in current with increasing VDS |
| Output Resistance | Successfully calculated |
| Channel Length Variation | Increasing L increased rₒ |
| Load Regulation | Drain current remained nearly constant with varying load resistance |

---

# 🎯 Key Learnings

✅ MOSFET behaves as a practical current source in saturation.

✅ Channel Length Modulation makes the current source non-ideal.

✅ Output resistance quantifies the quality of the current source.

✅ Increasing channel length improves current-source performance.

✅ The MOSFET automatically adjusts its drain voltage to maintain current.

✅ A practical current source has a finite output resistance.

---

# 🚀 Applications

MOSFET current sources are one of the most fundamental building blocks in Analog IC Design.

Some important applications include:

### 🔹 Current Mirrors

Used to replicate a reference current across multiple branches with high accuracy.

---

### 🔹 Differential Amplifiers

Provide constant tail current, improving gain and common-mode rejection.

---

### 🔹 Operational Amplifiers

Used as active loads and bias circuits to increase voltage gain.

---

### 🔹 Bias Networks

Generate stable bias currents independent of load variations.

---

### 🔹 Current Steering DACs

Each digital bit controls a precisely matched current source.

The total output current is obtained by steering these currents to the output node.

---

### 🔹 Bandgap Reference Circuits

Used to generate temperature-independent reference currents and voltages.

---

# 🏁 Conclusion

In this project, an NMOS transistor was successfully operated as a **practical current source** by biasing it in the saturation region.

The output characteristics clearly demonstrated the transition from the triode region to the saturation region and highlighted the effect of **Channel Length Modulation**.

The output resistance (`rₒ`) was calculated from the slope of the saturation region, confirming that a practical current source has a finite output resistance.

A comparison between **L = 0.15 µm** and **L = 1 µm** showed that increasing the channel length significantly improves current-source performance by reducing Channel Length Modulation and increasing `rₒ`.

Finally, the load regulation experiment verified that the MOSFET maintained an almost constant drain current over a range of load resistances by automatically adjusting its drain-to-source voltage while remaining in saturation.

These concepts form the foundation of many analog integrated circuits such as **Current Mirrors, Differential Amplifiers, Operational Amplifiers, Bandgap References, and Current Steering DACs**, making this experiment an essential step toward understanding Analog CMOS Design.

---
# ❓ Frequently Asked Questions (Conceptual Understanding)

This section contains some of the conceptual questions that arose during this project along with their explanations.

---

# ❓ 1. Why does the MOSFET behave like a current source in saturation?

When the MOSFET enters saturation, a **pinch-off point** forms near the drain.

Although the channel is pinched off, electrons continue to flow from the source to the drain because they are swept across the depletion region by the strong electric field.

Increasing **VDS** beyond this point mainly increases the depletion region rather than creating more inversion charge.

Therefore, the drain current changes very little with **VDS**, making the MOSFET behave approximately like a current source.

---

# ❓ 2. If the channel is pinched off, why doesn't the current become zero?

The word **pinch-off** can be misleading.

It does **not** mean the channel is completely broken.

Instead,

the inversion channel disappears only near the drain.

Electrons that reach the pinch-off point are accelerated across the depletion region by the electric field and reach the drain.

Therefore,

current continues to flow even though the channel is pinched off.

---

# ❓ 3. Why does the current still increase slightly in saturation?

Ideally,

the current should remain perfectly constant.

In reality,

increasing **VDS** shifts the pinch-off point slightly towards the source.

This shortens the effective channel length.

Since

```
ID ∝ 1/L
```

a shorter effective channel offers less resistance to carrier flow.

As a result,

the drain current increases slightly.

This effect is called **Channel Length Modulation (CLM)**.

---

# ❓ 4. Why did we calculate output resistance (rₒ) in this project?

The purpose of this project is to study the MOSFET as a **current source**.

A good current source should maintain constant current even when the drain voltage changes.

The parameter that measures this ability is the **output resistance (rₒ)**.

```
Large rₒ
↓

Smaller change in current

↓

Better Current Source
```

Therefore,

calculating **rₒ** provides a quantitative measure of how ideal the current source is.

---

# ❓ 5. Why was RON calculated in the previous project instead of rₒ?

The previous project studied the MOSFET as a **switch**.

A good switch should have

- very small ON resistance
- very small voltage drop

Therefore,

the important parameter was

```
RON
```

In contrast,

a current source should **oppose changes in current**.

Hence,

the important parameter becomes

```
rₒ
```

---

# ❓ 6. Is rₒ equal to VDS / ID?

**No.**

This is one of the most common misconceptions.

The ratio

```
VDS / ID
```

represents only the **DC operating-point resistance**.

Output resistance is **not** obtained from a single operating point.

Instead,

it is calculated from the slope of the output characteristic.

```
rₒ = ΔVDS / ΔID
```

Therefore,

```
VDS / ID ≠ rₒ
```

Although the numerical values may occasionally appear similar, they represent completely different physical quantities.

---

# ❓ 7. If rₒ is not VDS / ID, what exactly is it?

Think of the output characteristic.

If the curve is almost horizontal,

a large change in voltage produces only a tiny change in current.

That means

```
Large ΔVDS

Small ΔID
```

Therefore,

```
rₒ = ΔVDS / ΔID
```

becomes very large.

Hence,

**rₒ simply represents the slope of the saturation curve.**

---

# ❓ 8. Does the voltage across the MOSFET drop across rₒ?

No.

The voltage across the MOSFET is

```
VDS
```

There is **no physical resistor called rₒ inside the transistor**.

The resistor **rₒ** appears only in the **small-signal equivalent model**.

It is used to mathematically represent the finite slope caused by Channel Length Modulation.

Therefore,

```
Voltage across MOSFET ≠ Voltage across rₒ
```

because **rₒ is not a real resistor**.

---

# ❓ 9. How does Kirchhoff's Voltage Law work if the MOSFET is a current source?

Kirchhoff's Voltage Law still holds.

For the circuit,

```
VDD = ID × RL + VDS
```

Only two actual voltage drops exist:

- Load resistor
- MOSFET

The quantity **rₒ** does not appear in this equation because it is **not a physical resistor**.

---

# ❓ 10. Why does VDS change when the load resistance changes?

Suppose the current source tries to maintain the same current.

If the load resistance increases,

```
VR = ID × RL
```

also increases.

Since

```
VDD = VR + VDS
```

and **VDD** is fixed,

the MOSFET automatically reduces its own

```
VDS
```

to satisfy Kirchhoff's Voltage Law.

Therefore,

the MOSFET adjusts its drain voltage while maintaining nearly constant current.

---

# ❓ 11. Can increasing the load resistance force the MOSFET out of saturation?

Yes.

As the load resistance increases,

the resistor requires more voltage.

Consequently,

the voltage across the MOSFET keeps decreasing.

Eventually,

```
VDS < VGS − VT
```

At this point,

the MOSFET leaves saturation and enters the **triode region**.

Once this happens,

the drain current is no longer constant.

This is known as exceeding the **compliance voltage** of the current source.

---

# ❓ 12. What is Compliance Voltage?

A current source can regulate current only while the MOSFET remains in saturation.

The **minimum drain-to-source voltage required to maintain saturation** is called the **Compliance Voltage**.

If

```
VDS
```

falls below this value,

current regulation is lost.

---

# ❓ 13. Why does increasing channel length increase rₒ?

Channel Length Modulation occurs because the pinch-off point moves slightly towards the source.

For a **short-channel MOSFET**, this movement represents a significant percentage of the total channel length.

For a **long-channel MOSFET**, the same movement is relatively small.

Therefore,

long-channel devices experience less Channel Length Modulation.

Hence,

- flatter output characteristics
- larger output resistance
- better current-source behaviour

---

# ❓ 14. Why were all load-regulation experiments performed using L = 1 µm?

The purpose of the load-regulation experiment is to demonstrate the behaviour of a **good practical current source**.

Since increasing the channel length increases **rₒ**, the **L = 1 µm** transistor provides better current regulation than the minimum-length device.

Therefore, the improved device was chosen for the load-regulation study.

This also reflects real analog IC design practice, where designers often use longer-channel transistors for current sources and current mirrors to improve output resistance.

---

# 🎯 Key Takeaways

✔️ Saturation region enables current-source operation.

✔️ Channel Length Modulation makes practical current sources non-ideal.

✔️ Output resistance (rₒ) measures current-source quality.

✔️ Increasing channel length increases rₒ.

✔️ A MOSFET automatically adjusts VDS to maintain nearly constant current.

✔️ Load regulation is possible only while the MOSFET remains in saturation.

✔️ Current mirrors, differential amplifiers, operational amplifiers, and current steering DACs all rely on these principles.

---

# 📚 References

1. Behzad Razavi – *Design of Analog CMOS Integrated Circuits*
2. Sedra & Smith – *Microelectronic Circuits*
3. SkyWater SKY130 PDK Documentation
4. ngspice User Manual
5. Xschem Documentation

---

# 👨‍💻 Author

**Kishan K Kulal**

**Project:** Analog Circuits Series

> *"Every analog integrated circuit begins with a strong understanding of the MOSFET."*
