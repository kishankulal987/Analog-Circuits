# ⚡ MOSFET as a Switch

A detailed study of NMOS transistor operation, switching behavior, transfer characteristics, output characteristics, and ON resistance using **Sky130 PDK**, **Xschem**, and **Ngspice**.

---

## 📚 Introduction

A MOSFET (Metal-Oxide-Semiconductor Field-Effect Transistor) is one of the fundamental building blocks of modern integrated circuits. Depending on the biasing conditions, a MOSFET can operate as:

* An electronic switch
* A resistor
* A current source
* An amplifier

In digital circuits, MOSFETs primarily operate as switches.

* When `VGS < VTH`, the MOSFET is **OFF** and behaves like an **open switch**.
* When `VGS > VTH`, an inversion channel forms and the MOSFET turns **ON**, behaving like a **low resistance switch**.

This experiment explores the physics behind MOSFET operation and studies the effect of device sizing on switching performance.

---

# 🤔 Questions Explored During MOSFET Study

## ❓ Where do the electrons for channel formation come from in a P-type substrate?

### Initial Stage (Weak Inversion)

When a small positive gate voltage is applied to a p-type substrate:

Holes are repelled from the surface.
A depletion region forms.
The minority carriers (electrons already present in the p-substrate due to thermal generation) are attracted towards the surface.

So initially, the electrons forming the inversion layer come from the minority carriers of the p-substrate.

### Strong Inversion (Practical MOS Operation)

Once the channel is formed and the MOSFET is operating:

The source and drain are heavily doped N+ regions containing a huge number of electrons.
These N+ regions act as reservoirs of electrons.
The inversion layer is continuously supplied by electrons entering from the source (and to some extent from the drain).

---

## ❓ What is a Depletion Region?

To understand a depletion region, let us first consider a PN junction formed by joining a P-type semiconductor and an N-type semiconductor.

### Step 1: Before Joining the Semiconductors

The **N-type semiconductor** contains:

* Majority carriers → Electrons
* Minority carriers → Holes

The **P-type semiconductor** contains:

* Majority carriers → Holes
* Minority carriers → Electrons

Initially, both regions are electrically neutral.

---

### Step 2: Diffusion of Charge Carriers

When the P-type and N-type semiconductors are brought together, a concentration gradient exists.

Since the N-side contains a large number of electrons, electrons diffuse from the N-side to the P-side.

Similarly, holes diffuse from the P-side to the N-side.

After crossing the junction:

* Electrons recombine with holes on the P-side.
* Holes recombine with electrons on the N-side.

---

### Step 3: Formation of Fixed Ions

This naturally leads to the question:

### ❓ *If electrons and holes leave, what remains behind?*

Consider the N-type semiconductor.

N-type silicon is formed by doping pure silicon with pentavalent atoms such as phosphorus.

A phosphorus atom has five valence electrons.

* Four electrons participate in covalent bonding.
* One electron is weakly bound and becomes a free electron.

When this free electron leaves the N-side and diffuses towards the P-side, the phosphorus atom loses one electron.

Consequently, the phosphorus atom becomes positively charged:

```text
Phosphorus atom = +5 protons + 4 electrons
```

This positively charged phosphorus atom is called a **donor ion**.

Similarly, on the P-side, after holes diffuse away, negatively charged acceptor ions remain.

Thus, near the junction we get:

```text
P side                    N side

- - - - -  |  + + + + +
```

where

* `-` → Fixed acceptor ions
* `+` → Fixed donor ions

---

### ❓ *Can these ions move?*

No.

These ions are part of the semiconductor crystal lattice.

They are firmly bound to their lattice positions and therefore cannot move.

Only electrons and holes are mobile.

---

### Step 4: Formation of the Depletion Region

Near the junction:

* Most electrons and holes have recombined.
* No mobile charge carriers remain.
* Only fixed ions exist.

This region is therefore called the **depletion region** because it is:

> **depleted of mobile charge carriers.**

An important point is:

> The depletion region is not empty.

It contains immobile charged ions but almost no mobile electrons or holes.

---

### Step 5: Built-in Electric Field

The fixed ions create an electric field directed from the N-side towards the P-side.

This electric field opposes further diffusion of carriers.

Eventually, equilibrium is reached.

---

## ❓ Why does the depletion width increase during reverse bias?

When reverse bias is applied:

* The positive terminal is connected to the N-side.
* The negative terminal is connected to the P-side.

This external voltage strengthens the built-in electric field.

As a result:

* Electrons in the N-side are pulled further away from the junction.
* Holes in the P-side are also pulled away from the junction.

Consequently, more fixed ions become exposed.

Hence, the depletion region width increases.

---

## Depletion Region in a MOSFET

In an NMOS transistor:

When a positive gate voltage is applied:

1. Holes near the silicon surface are repelled away from the gate.
2. A depletion region forms beneath the gate oxide.
3. As the gate voltage increases further, minority electrons are attracted towards the surface.
4. Eventually, an inversion layer (channel) is formed.

---

## ❓ How does this lead to pinch-off?

As the drain voltage increases:

* The drain-body PN junction becomes increasingly reverse biased.
* The depletion region near the drain widens.

This naturally raises another question:

### ❓ *Why does the channel disappear when the depletion region widens?*

The inversion channel consists of mobile electrons.

As the depletion region near the drain expands, it occupies more of the channel region.

Eventually, at the drain end, the depletion region consumes the entire inversion layer.

At this point:

```math
V_{DS}=V_{GS}-V_{TH}
```

the inversion charge at the drain end becomes zero.

The channel appears to terminate near the drain.

This condition is called **pinch-off**.



<img width="1024" height="559" alt="image" src="https://github.com/user-attachments/assets/2f3187ed-a864-4a11-bdb7-5e2db3a4a86b" />


---

## ❓ If the channel disappears, why does current still flow?

Even after pinch-off:

* Electrons continue to travel from the source towards the pinch-off point.
* The strong electric field present inside the depletion region sweeps these electrons into the drain.

Therefore:

> Current does not stop after pinch-off.

Instead, the MOSFET enters the saturation region and behaves approximately as a current source.

💡 **Key Takeaway:**

> A depletion region is a region devoid of mobile charge carriers but filled with fixed ionized atoms. The electric field created by these fixed ions plays a crucial role in PN junction and MOSFET operation.


---

## ❓ Why does reverse bias increase depletion width?

Increasing reverse bias strengthens the electric field across the PN junction. This field pulls mobile carriers away from the junction, exposing more fixed ions and thereby increasing depletion width.

---

## ❓ How does pinch-off occur?

As drain voltage (`VDS`) increases, the channel potential rises from source to drain.

Near the drain,

```math
V_{GS,local}=V_G-V_D
```

As `VD` increases, the effective gate-to-channel voltage near the drain decreases.

When

```math
V_{DS}=V_{GS}-V_{TH}
```

the inversion charge at the drain end becomes zero, causing the channel to disappear locally. This condition is called **pinch-off**.

---

## ❓ Why does current continue to flow after pinch-off?

Even after pinch-off, electrons reaching the pinch-off point are swept by the strong electric field in the depletion region into the drain.

Therefore, current does not stop after pinch-off.

---

## ❓ Why does increasing `VDS` increase current in triode region?

In the triode region, a continuous channel exists between source and drain.

Increasing `VDS` increases the electric field along the channel, causing more electrons to drift from source to drain, thereby increasing drain current.

---

### 🟢 Triode Region

When

```math
V_{DS}<V_{GS}-V_{TH}
```

a continuous inversion channel exists from source to drain.

```text
                 Gate
      ─────────────────────────

 Source (N+)                    Drain (N+)
     │=============================│
     │<------ Inversion Channel -->│

            P-type Substrate
      ─────────────────────────
```

Increasing (V_{DS}) increases the electric field along the channel, causing more electrons to drift from source to drain.

---

### 🟠 Beginning of Pinch-Off

As (V_{DS}) increases, the channel potential rises towards the drain.

Eventually:

```math
V_{DS}=V_{GS}-V_{TH}
```

The inversion charge near the **drain** becomes zero and pinch-off occurs.

```text
                 Gate
      ─────────────────────────

 Source (N+)                    Drain (N+)
     │====================      │
     │                    >>>>>>│
                         ▲
                  Pinch-Off Point

Legend:
========  → Inversion Channel
>>>>>>>>  → Depletion Region
```

---

### 🔵 Increasing (V_{DS}) Further

Suppose the MOSFET is already in saturation.

Now increase (V_{DS}) further.

```text
Case 1 : Just after pinch-off

                 Gate
      ─────────────────────────

 Source (N+)                    Drain (N+)
     │====================      │
     │                    >>>>>>│
                         ▲
                  Pinch-Off Point
```

```text
Case 2 : Larger VDS

                 Gate
      ─────────────────────────

 Source (N+)                    Drain (N+)
     │================          │
     │                >>>>>>>>>>│
                       ▲
                New Pinch-Off Point
```

Observe carefully:

* The depletion region near the **drain** widens.
* The pinch-off point moves slightly towards the **source**.
* The effective channel length becomes shorter.

```text
Before increasing VDS:

|====================|

After increasing VDS:

|================|
```

The extra drain voltage mainly drops across the enlarged depletion region:

```text
Additional VDS
                      ↓

 Source                Drain
   │================>>>>>>>>>>>>│
```

Hence:

> Increasing (V_{DS}) mainly widens the depletion region rather than significantly increasing channel charge.

Therefore, the drain current remains approximately constant.

---

### 🚀 Why does current still flow?

Electrons travel from the source through the inversion channel.

After reaching the pinch-off point, they are swept by the strong electric field inside the depletion region into the drain.

```text
Source →→→→→ Channel →→→→→ Pinch-Off
                                           ↓↓↓↓↓
                                     Strong Electric Field
                                           ↓↓↓↓↓
                                         Drain
```

Therefore:

> Current continues to flow even after pinch-off occurs.



## ❓ Why does increasing gate voltage increase current in saturation?

Increasing gate voltage increases inversion charge density and widens the channel.

A wider channel can accommodate more carriers, increasing drain current even in saturation.

---

## ❓ Why does increasing transistor width reduce ON resistance?

Increasing transistor width provides more parallel paths for carrier flow.

Therefore,

```math
I_D \propto W
```

and

```math
R_{ON}\propto\frac{1}{W}
```

---

# 📊 MOSFET Operating Regions

| Region             | Condition                         | Description                                                              |
| ------------------ | --------------------------------- | ------------------------------------------------------------------------ |
| 🔴 Cutoff          | `VGS < VTH`                       | No inversion channel is formed. MOSFET is OFF.                           |
| 🟠 Triode (Linear) | `VGS > VTH` and `VDS < VGS - VTH` | Channel exists throughout device. MOSFET behaves like a resistor/switch. |
| 🟢 Saturation      | `VGS > VTH` and `VDS ≥ VGS - VTH` | Channel pinches off near drain. MOSFET behaves as a current source.      |


## 📌 MOSFET Operating Regions

### 🔴 Cutoff Region

When:

```math
V_{GS} < V_{TH}
```

No inversion channel is formed between source and drain.

```text
Source     Drain
  │           │
  │           │

(No Channel)
```

Therefore:

> No current flows through the MOSFET.

The MOSFET behaves like an **open switch**.

---

### 🟠 Triode (Linear) Region

When:

```math
V_{GS} > V_{TH}
```

and

```math
V_{DS} < V_{GS}-V_{TH}
```

a continuous inversion channel exists from source to drain.

```text
Source                    Drain
  │========================│
        Continuous Channel
```

Increasing (V_{DS}) increases the electric field along the channel, causing more electrons to drift from source to drain.

Therefore:

```math
I_D \propto V_{DS}
```

Hence:

> In the triode region, a MOSFET behaves as a voltage-controlled resistor.

---

### 🟢 Saturation Region

When:

```math
V_{DS} \geq V_{GS}-V_{TH}
```

pinch-off occurs near the drain.

```text
Source                    Drain
  │================>>>>>>│
                   ↑
              Pinch-Off
```

After pinch-off:

* The gate voltage fixes the amount of inversion charge in the channel.
* Increasing (V_{DS}) mainly widens the depletion region near the drain.
* The additional voltage is dropped across the depletion region rather than the channel.

Therefore:

```math
I_D \approx Constant
```

Hence:

> In saturation, a MOSFET behaves approximately as a current source.

---

## 📌 Channel Length Modulation (CLM)

In an ideal MOSFET, the drain current remains perfectly constant in saturation.

However, practical MOSFETs exhibit a slight increase in drain current with increasing (V_{DS}).

This happens because:

* The depletion region near the drain widens.
* The effective channel length decreases.

### Effective Channel Length

Before increasing (V_{DS}):

```text
|====================|
```

After increasing (V_{DS}):

```text
|================|
```

A shorter channel offers less resistance to carrier flow.

Consequently, drain current increases slightly.

This phenomenon is known as:

> **Channel Length Modulation (CLM)**

and is analogous to the **Early Effect** in BJTs.

Therefore, in practical MOSFETs:

```math
I_D \approx Constant
```

but not perfectly constant.

💡 **Key Takeaway:**

> A MOSFET in saturation behaves approximately as a current source, but due to Channel Length Modulation, the drain current increases slightly with increasing drain voltage.

---

# 🔧 Circuit Schematic

<p align="center">
<img width="1250" height="508" alt="MOS as switch" src="https://github.com/user-attachments/assets/7cd507d8-501e-4a1a-8b96-c2e5e20ef4cd" />
</p>

---

# 📈 Effect of Width (W) on ON Resistance

For a fixed gate voltage:

* Increasing width increases drain current.
* Increasing width decreases ON resistance.

The ON resistance is calculated as:

```math
R_{ON}=\frac{V_{DS}}{I_D}
```

| Width W (µm) | VDS (V) | ID (mA)| RON (Ω) |
| ------------ | ------- | ------ | ------- |
| 1            | 1.34    | 0.475  | 2.821k  |
| 2            | 0.809   | 0.919  | 880.3   |
| 3            | 0.5213  | 1.786  | 291.88  |
| 5            | 0.253   | 1.547  | 163.54  |
| 10           | 0.119   | 1.68   | 70.8333 |
| 20           | 0.057   | 1.74   | 32.758  |

---

## 🔍 Observations

✅ Drain current increases with transistor width.

✅ Wider transistors provide lower ON resistance.

✅ MOSFET acts as a stronger switch for larger widths.

---

# 🔧 Circuit Schematic


<p align="center">
<img width="1259" height="465" alt="Mos output char schematic" src="https://github.com/user-attachments/assets/929f5da4-91e1-4411-830f-dd4fe8957b31" />
</p>

---

# 📉 Transfer Characteristics (`ID` vs `VGS`)

Transfer characteristics are obtained by sweeping gate voltage while keeping drain voltage constant.

This plot is useful for estimating threshold voltage (`VTH`).

### Procedure

* Sweep `VGS` from `0 V` to `1.8 V`
* Keep `VDS` constant at 1.8V
* Plot `ID` versus `VGS`

### Waveform

<p align="center">
<img width="1267" height="703" alt="Transfer_char" src="https://github.com/user-attachments/assets/f1c12b35-60ac-4245-a416-a2b3a9c2dc7c" />
</p>

### Observation

* Current remains nearly zero below threshold voltage.
* Current increases rapidly once `VGS` exceeds threshold voltage.
* The threshold voltage observed from simulation is approximately **0.6 V - 0.7 V**.

---

# 📊 Output Characteristics (`ID` vs `VDS`)

Output characteristics are obtained by sweeping drain voltage for multiple gate voltages.

### Procedure

* Sweep `VDS` from `0 V` to `1.8 V`
* Repeat for different `VGS` values
* Plot `ID` versus `VDS`

### Waveform

<p align="center">
<img width="1265" height="694" alt="output_char" src="https://github.com/user-attachments/assets/f8e98b29-52db-46b9-b4c6-80271e3ace6c" />
</p>

### Observation

* Initial linear region corresponds to triode operation.
* Current increases almost linearly with drain voltage.
* Pinch-off occurs approximately when:

```math
V_{DS}=V_{GS}-V_{TH}
```

* Beyond pinch-off, the MOSFET enters saturation region.

---

# 📏 Calculating ON Resistance Using Slope of `ID` vs `VDS`

The ON resistance can also be calculated from the slope of a single output characteristic curve in the triode region.

For small drain voltages,

```math
I_D \propto V_{DS}
```

Therefore,

```math
Slope=\frac{\Delta I_D}{\Delta V_{DS}}
```

and

```math
R_{ON}=\frac{1}{Slope}
```

### Steps

1. Select a single `ID` vs `VDS` curve.
2. Choose two points in the linear region.
3. Compute:

```math
Slope=\frac{\Delta I_D}{\Delta V_{DS}}
```

4. Calculate:

```math
R_{ON}=\frac{1}{Slope}
```

### Example Calculation

Selected Points from the Linear Region:

- Point 1:

```math
V_{DS1}=0.0346\;V
```

```math
I_{D1}=0.983\;mA
```

- Point 2:

```math
V_{DS2}=0.2\;V
```

```math
I_{D2}=4.966\;mA
```

Calculate the change in drain voltage and drain current:

```math
\Delta V_{DS}=V_{DS2}-V_{DS1}
```

```math
\Delta V_{DS}=0.2-0.0346=0.1654\;V
```

```math
\Delta I_D=I_{D2}-I_{D1}
```

```math
\Delta I_D=4.966\;mA-0.983\;mA=3.983\;mA
```

Calculate the slope of the curve:

```math
Slope=\frac{\Delta I_D}{\Delta V_{DS}}
```

```math
Slope=\frac{3.983\times10^{-3}}{0.1654}
```

```math
Slope=0.0241\;A/V
```

Finally,

```math
R_{ON}=\frac{1}{Slope}
```

```math
R_{ON}=\frac{1}{0.0241}
```

```math
R_{ON}=41.5\;\Omega
```

Hence,

> The ON resistance obtained from the slope of the linear region is approximately **41.5 Ω**.
### Waveform Used

<p align="center">
<img width="1255" height="695" alt="single curve output char" src="https://github.com/user-attachments/assets/0d305575-2060-44ca-ae3d-a71f7c294312" />
</p>

---

# ✅ Conclusion

* MOSFET successfully operates as an electronic switch.
* Device operation is governed by channel formation and pinch-off.
* Wider transistors exhibit lower ON resistance.
* Transfer characteristics help determine threshold voltage.
* Output characteristics reveal triode and saturation regions.
* ON resistance can be calculated using both:

```math
R_{ON}=\frac{V_{DS}}{I_D}
```

and

```math
R_{ON}=\frac{1}{dI_D/dV_{DS}}
```

The concepts learned in this experiment form the foundation for designing analog circuits such as **Current Mirrors**, **Differential Pairs**, and **Current Steering DACs**.

---

## 🛠️ Tools Used

* Xschem
* Ngspice
* Sky130 PDK
* Ubuntu Linux

---

## 👨‍💻 Author

**Kishan K Kulal**
B.Tech Electronics and Communication Engineering
NMAM Institute of Technology, Karkala
