v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -150 -80 -150 -60 {lab=Vx}
N -150 -80 -90 -80 {lab=Vx}
N -90 -80 -90 -30 {lab=Vx}
N -90 -30 -30 -30 {lab=Vx}
N -110 -30 -80 -30 {lab=Vx}
N -150 0 -150 20 {lab=GND}
N 10 0 10 20 {lab=GND}
N -150 -110 -150 -80 {lab=Vx}
N -270 -170 -270 -130 {lab=#net1}
N -270 -170 -150 -170 {lab=#net1}
N 10 -150 110 -150 {lab=Vout}
N 10 -150 10 -60 {lab=Vout}
C {code_shown.sym} -300 -320 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.dc V2 0 1.8 0.01
.save all
"}
C {sky130_fd_pr/nfet3_01v8.sym} -10 -30 0 0 {name=M1
W=8
L=1
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
C {sky130_fd_pr/nfet3_01v8.sym} -130 -30 0 1 {name=M2
W=1
L=1
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
C {gnd.sym} -150 20 0 0 {name=l1 lab=GND}
C {gnd.sym} 10 20 0 0 {name=l2 lab=GND}
C {vsource.sym} -270 -100 0 0 {name=V1 value=1.8 savecurrent=false}
C {vsource.sym} 110 -120 0 0 {name=V2 value=1 savecurrent=false}
C {gnd.sym} 110 -90 0 0 {name=l3 lab=GND}
C {gnd.sym} -270 -70 0 0 {name=l4 lab=GND}
C {lab_pin.sym} -150 -100 0 0 {name=p1 sig_type=std_logic lab=Vx}
C {lab_pin.sym} 10 -100 0 0 {name=p2 sig_type=std_logic lab=Vout}
C {isource.sym} -150 -140 0 0 {name=I0 value=100u}
