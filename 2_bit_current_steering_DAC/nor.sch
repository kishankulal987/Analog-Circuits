v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -70 0 -70 30 {lab=out}
N -70 0 110 -0 {lab=out}
N 110 -0 110 30 {lab=out}
N 30 -50 30 -0 {lab=out}
N 30 -130 30 -110 {lab=#net1}
N -70 90 -70 120 {lab=VSS}
N -70 120 110 120 {lab=VSS}
N 110 90 110 120 {lab=VSS}
N -160 -80 -10 -80 {lab=A}
N -160 -80 -160 60 {lab=A}
N -160 60 -110 60 {lab=A}
N 70 -160 200 -160 {lab=B}
N 200 -160 200 60 {lab=B}
N 150 60 200 60 {lab=B}
N -220 0 -160 -0 {lab=A}
N 200 -60 280 -60 {lab=B}
N 30 -290 30 -190 {lab=VDD}
N 10 120 10 160 {lab=VSS}
C {sky130_fd_pr/nfet3_01v8.sym} -90 60 0 0 {name=M1
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
C {sky130_fd_pr/nfet3_01v8.sym} 130 60 0 1 {name=M3
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
C {sky130_fd_pr/pfet3_01v8.sym} 10 -80 0 0 {name=M2
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
C {sky130_fd_pr/pfet3_01v8.sym} 50 -160 0 1 {name=M4
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
C {ipin.sym} -220 0 0 0 {name=p1 lab=A}
C {ipin.sym} 280 -60 2 0 {name=p2 lab=B}
C {ipin.sym} 30 -290 1 0 {name=p3 lab=VDD}
C {ipin.sym} 10 160 3 0 {name=p4 lab=VSS}
C {opin.sym} 30 -30 0 0 {name=p5 lab=out}
