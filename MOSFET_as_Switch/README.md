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

A depletion region is a region inside a semiconductor that is **depleted of mobile charge carriers** (free electrons and holes). It contains only **immobile ionized atoms**.

To understand how it forms, consider a PN junction.

### Step 1: Joining P-type and N-type Semiconductors

- The **P-type** region contains:
  - Majority carriers → Holes
  - Minority carriers → Electrons

- The **N-type** region contains:
  - Majority carriers → Electrons
  - Minority carriers → Holes

When the two regions are brought together, a concentration gradient exists.

### Step 2: Diffusion of Carriers

Due to the concentration gradient:

- Electrons diffuse from the N-side to the P-side.
- Holes diffuse from the P-side to the N-side.

When these carriers cross the junction, they recombine.

### Step 3: Formation of Fixed Ions

After recombination:

- The electrons leaving the N-side expose positively charged donor ions.
- The holes leaving the P-side expose negatively charged acceptor ions.

These ions are fixed in the crystal lattice and cannot move.

The charge distribution near the junction becomes:

```text
P-side                 N-side

- - - - - | + + + + +
```

The absence of free carriers gives rise to an electric field.

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

## ❓ Why does increasing `VDS` not significantly increase current in saturation?

Once pinch-off occurs, the channel charge is fixed primarily by the gate voltage.

Additional drain voltage mainly increases depletion width rather than channel charge, so drain current remains approximately constant.

---

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

---

# 🔧 Circuit Schematic

Insert the Xschem schematic screenshot below.

<p align="center">
<img src="images/mos_switch_schematic.png" width="700">
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

| Width W (µm) | VDS (V) | ID (A) | RON (Ω) |
| ------------ | ------- | ------ | ------- |
| 1            |         |        |         |
| 2            |         |        |         |
| 3            |         |        |         |
| 5            |         |        |         |
| 10           |         |        |         |
| 20           |         |        |         |

---

## 🔍 Observations

✅ Drain current increases with transistor width.

✅ Wider transistors provide lower ON resistance.

✅ MOSFET acts as a stronger switch for larger widths.

---

# 📉 Transfer Characteristics (`ID` vs `VGS`)

Transfer characteristics are obtained by sweeping gate voltage while keeping drain voltage constant.

This plot is useful for estimating threshold voltage (`VTH`).

### Procedure

* Sweep `VGS` from `0 V` to `1.8 V`
* Keep `VDS` constant
* Plot `ID` versus `VGS`

### Waveform

<p align="center">
<img src="images/transfer_characteristic.png" width="700">
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
<img src="images/output_characteristic.png" width="700">
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

### Waveform Used

<p align="center">
<img src="images/ron_calculation_curve.png" width="700">
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
