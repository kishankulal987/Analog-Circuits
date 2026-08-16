v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -70 10 -70 50 {lab=#net1}
N -70 110 -70 140 {lab=#net2}
N -70 200 -70 240 {lab=GND}
N -200 180 -110 170 {lab=#net3}
N -200 240 -200 250 {lab=GND}
N -70 -50 -20 -50 {lab=GND}
N -70 170 -40 170 {lab=GND}
N -40 170 -40 200 {lab=GND}
N -70 200 -40 200 {lab=GND}
C {vsource.sym} -70 -20 0 0 {name=V1 value=1.8 savecurrent=false}
C {res.sym} -70 80 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} -20 -50 0 0 {name=l1 lab=GND}
C {vsource.sym} -200 210 0 0 {name=V2
value="PULSE(0 1.8 0 1n 1n 5u 10u)"
savecurrent=false}
C {gnd.sym} -200 250 0 0 {name=l2 lab=GND}
C {gnd.sym} -70 240 0 0 {name=l3 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} -90 170 0 0 {name=M1
W=1
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {code_shown.sym} 150 70 0 0 {name=s1
only_toplevel=false
value="
.tran 10n 30u
.save all
"}
