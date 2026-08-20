v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 -140 -70 -140 {lab=Vin}
N -110 -140 -110 0 {lab=Vin}
N -110 0 -70 0 {lab=Vin}
N -30 -110 -30 -30 {lab=Vout}
N -170 -80 -110 -80 {lab=Vin}
N -30 -80 80 -80 {lab=Vout}
N -220 -80 -160 -80 {lab=Vin}
N -30 -220 -30 -170 {lab=VDD}
N -30 30 -30 70 {lab=VSS}
C {sky130_fd_pr/nfet3_01v8.sym} -50 0 0 0 {name=M1
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
C {sky130_fd_pr/pfet3_01v8.sym} -50 -140 0 0 {name=M2
W=1
L=0.15
body=VDD
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {ipin.sym} -30 -220 1 0 {name=p3 lab=VDD}
C {ipin.sym} -210 -80 0 0 {name=p2 lab=Vin}
C {ipin.sym} -30 70 3 0 {name=p4 lab=VSS}
C {opin.sym} 80 -80 0 0 {name=p5 lab=Vout}
