# MOSFET as a Switch

## Objective

To study the switching behavior of an NMOS transistor and investigate the effect of transistor width on ON resistance.

## Theory

An NMOS transistor behaves as:

* An open switch when VGS < VTH
* A closed switch when VGS > VTH

The ON resistance depends on the transistor dimensions and bias conditions.

## Circuit

The circuit consists of:

* Sky130 NMOS transistor
* 1 kΩ load resistor
* VDD = 1.8 V
* Input voltage = 1.8 V

## Simulations Performed

* Switching operation of NMOS
* Effect of transistor width on ON resistance
* Current variation with width

## Observations

* Increasing width increases drain current.
* Increasing width decreases ON resistance.

## Key Equations

RON = VDS / ID

ID ∝ W

RON ∝ 1/W

## Tools Used

* Xschem
* Ngspice
* Sky130 PDK
