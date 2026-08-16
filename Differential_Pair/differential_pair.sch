v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -130 -120 -130 -90 {lab=#net1}
N -130 -120 130 -120 {lab=#net1}
N 130 -120 130 -90 {lab=#net1}
N -130 -30 -130 20 {lab=OUT1}
N 130 -30 130 20 {lab=OUT2}
N -130 80 -130 150 {lab=#net2}
N -130 150 -0 150 {lab=#net2}
N 130 80 130 140 {lab=#net2}
N 130 140 130 150 {lab=#net2}
N 0 150 130 150 {lab=#net2}
N -290 50 -290 80 {lab=#net3}
N -290 50 -170 50 {lab=#net3}
N 170 50 270 50 {lab=#net4}
N 270 50 270 90 {lab=#net4}
N -290 140 -290 160 {lab=GND}
N 270 150 270 180 {lab=GND}
N -0 210 -0 230 {lab=GND}
N -250 -190 0 -190 {lab=#net1}
N 0 -190 0 -120 {lab=#net1}
C {sky130_fd_pr/nfet3_01v8.sym} -150 50 0 0 {name=M1
W=1
L=0.15
body=GND
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
C {sky130_fd_pr/nfet3_01v8.sym} 150 50 0 1 {name=M2
W=1
L=0.15
body=GND
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
C {res.sym} -130 -60 0 0 {name=R1
value=5k
footprint=1206
device=resistor
m=1}
C {res.sym} 130 -60 0 0 {name=R2
value=5k
footprint=1206
device=resistor
m=1}
C {isource.sym} 0 180 0 0 {name=I0 value=100u}
C {vsource.sym} -290 110 0 0 {name=V1 value=1 savecurrent=false}
C {vsource.sym} 270 120 0 0 {name=V2 value=0.9 savecurrent=false}
C {gnd.sym} -290 160 0 0 {name=l1 lab=GND}
C {gnd.sym} 0 230 0 0 {name=l2 lab=GND}
C {gnd.sym} 270 180 0 0 {name=l3 lab=GND}
C {vsource.sym} -250 -160 0 0 {name=VDD value=1.8 savecurrent=false}
C {gnd.sym} -250 -130 0 0 {name=l4 lab=GND}
C {lab_pin.sym} -130 -10 0 0 {name=p1 sig_type=std_logic lab=OUT1}
C {lab_pin.sym} 130 0 2 0 {name=p2 sig_type=std_logic lab=OUT2}
C {code_shown.sym} -300 -280 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.dc V1 0.7 1.1 0.01"}
