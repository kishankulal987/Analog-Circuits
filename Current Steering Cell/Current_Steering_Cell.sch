v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 280 -40 280 -30 {lab=#net1}
N 280 -50 280 -40 {lab=#net1}
N 280 -50 370 -50 {lab=#net1}
N 560 -20 560 10 {lab=GND}
N 280 30 280 40 {lab=GND}
N 370 -50 520 -50 {lab=#net1}
N 440 -300 440 -240 {lab=out1}
N 680 -300 680 -240 {lab=out2}
N 440 -180 440 -130 {lab=#net2}
N 440 -130 680 -130 {lab=#net2}
N 680 -180 680 -130 {lab=#net2}
N 560 -130 560 -80 {lab=#net2}
N 440 -400 440 -360 {lab=#net3}
N 440 -400 680 -400 {lab=#net3}
N 680 -400 680 -360 {lab=#net3}
N 560 -440 560 -400 {lab=#net3}
N 560 -440 810 -440 {lab=#net3}
N 280 -210 280 -200 {lab=#net4}
N 280 -210 400 -210 {lab=#net4}
N 720 -210 830 -210 {lab=#net5}
N 830 -210 830 -190 {lab=#net5}
C {sky130_fd_pr/nfet3_01v8.sym} 540 -50 0 0 {name=M1
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
C {vsource.sym} 280 0 0 0 {name=V1 value=1.655626 savecurrent=false}
C {gnd.sym} 280 40 0 0 {name=l1 lab=GND}
C {gnd.sym} 560 10 0 0 {name=l2 lab=GND}
C {code_shown.sym} -180 -470 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.tran 1n 1u"}
C {sky130_fd_pr/nfet3_01v8.sym} 420 -210 0 0 {name=M2
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
C {sky130_fd_pr/nfet3_01v8.sym} 700 -210 0 1 {name=M3
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
C {res.sym} 440 -330 0 0 {name=R1
value=5k
footprint=1206
device=resistor
m=1}
C {res.sym} 680 -330 0 0 {name=R2
value=5k
footprint=1206
device=resistor
m=1}
C {vsource.sym} 280 -170 0 0 {name=V2 value="PULSE(0 1.8 0 1n 1n 100n 200n)" savecurrent=false}
C {vsource.sym} 830 -160 0 0 {name=V3 value="PULSE(1.8 0 0 1n 1n 100n 200n)" savecurrent=false}
C {vsource.sym} 810 -410 0 0 {name=V4 value=1.8 savecurrent=false}
C {gnd.sym} 280 -140 0 0 {name=l3 lab=GND}
C {gnd.sym} 830 -130 0 0 {name=l4 lab=GND}
C {gnd.sym} 810 -380 0 0 {name=l5 lab=GND}
C {lab_pin.sym} 440 -280 0 0 {name=p1 sig_type=std_logic lab=out1}
C {lab_pin.sym} 680 -280 2 0 {name=p2 sig_type=std_logic lab=out2}
