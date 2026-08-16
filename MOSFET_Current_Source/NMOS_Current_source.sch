v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 10 0 40 {lab=GND}
N -150 -10 -150 10 {lab=VGS}
N -150 -20 -150 -10 {lab=VGS}
N -150 -20 -40 -20 {lab=VGS}
N -0 -140 0 -50 {lab=VDS}
N -0 -20 50 -20 {lab=GND}
N 50 -20 50 20 {lab=GND}
N 0 20 50 20 {lab=GND}
N 0 -160 0 -140 {lab=VDS}
N 0 -160 110 -160 {lab=VDS}
N 170 -170 170 -160 {lab=#net1}
N 170 -170 300 -170 {lab=#net1}
C {sky130_fd_pr/nfet_01v8.sym} -20 -20 0 0 {name=M1
W=1
L=1
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
C {vsource.sym} -150 40 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} 300 -140 0 0 {name=V2 value=1.8 savecurrent=false}
C {gnd.sym} 0 40 0 0 {name=l1 lab=GND}
C {gnd.sym} -150 70 0 0 {name=l2 lab=GND}
C {gnd.sym} 300 -110 0 0 {name=l3 lab=GND}
C {code_shown.sym} -170 -240 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all
"}
C {lab_pin.sym} 0 -140 0 0 {name=p1 sig_type=std_logic lab=VDS}
C {lab_pin.sym} -150 -20 0 0 {name=p2 sig_type=std_logic lab=VGS}
C {res.sym} 140 -160 1 0 {name=R1
value=10K
footprint=1206
device=resistor
m=1}
