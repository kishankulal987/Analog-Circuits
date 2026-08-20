v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -120 -270 -120 -210 {lab=out}
N -120 -210 50 -210 {lab=out}
N 50 -280 50 -210 {lab=out}
N -30 -210 -30 -150 {lab=out}
N -30 -90 -30 -50 {lab=#net1}
N -120 -400 -120 -330 {lab=VDD}
N -120 -400 50 -400 {lab=VDD}
N 50 -400 50 -340 {lab=VDD}
N -220 -300 -160 -300 {lab=A}
N -220 -300 -220 -120 {lab=A}
N -220 -120 -70 -120 {lab=A}
N 90 -310 120 -310 {lab=B}
N 120 -310 120 -20 {lab=B}
N 10 -20 120 -20 {lab=B}
N -30 -450 -30 -400 {lab=VDD}
N -320 -230 -220 -230 {lab=A}
N 120 -160 200 -160 {lab=B}
N -30 10 -30 50 {lab=VSS}
C {sky130_fd_pr/nfet3_01v8.sym} -10 -20 0 1 {name=M1
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
C {sky130_fd_pr/nfet3_01v8.sym} -50 -120 0 0 {name=M2
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
C {sky130_fd_pr/pfet3_01v8.sym} -140 -300 0 0 {name=M3
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
C {sky130_fd_pr/pfet3_01v8.sym} 70 -310 0 1 {name=M4
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
C {ipin.sym} -320 -230 0 0 {name=p2 lab=A}
C {ipin.sym} -30 -450 1 0 {name=p3 lab=VDD}
C {ipin.sym} 200 -160 2 0 {name=p4 lab=B}
C {ipin.sym} -30 50 3 0 {name=p1 lab=VSS}
C {opin.sym} -30 -210 3 0 {name=p5 lab=out}
