v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -360 -40 -360 -30 {lab=VGS}
N -360 -40 -280 -40 {lab=VGS}
N -240 -100 -240 -70 {lab=VDS}
N -240 -180 -240 -160 {lab=VDS}
N -240 -190 -240 -180 {lab=VDS}
N -240 -190 -110 -190 {lab=VDS}
N -240 -40 -200 -40 {lab=GND}
N -200 -40 -200 -10 {lab=GND}
N -240 -10 -200 -10 {lab=GND}
N -240 -160 -240 -90 {lab=VDS}
C {sky130_fd_pr/nfet_01v8.sym} -260 -40 0 0 {name=M2
W=20
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
C {vsource.sym} -110 -160 0 0 {name=VDS value=1.8 savecurrent=false}
C {vsource.sym} -360 0 0 0 {name=VGS
value="1.8"
savecurrent=falsename=V2 value=3 savecurrent=false}
C {gnd.sym} -110 -130 0 0 {name=l1 lab=GND}
C {gnd.sym} -240 -10 0 0 {name=l2 lab=GND}
C {gnd.sym} -360 30 0 0 {name=l3 lab=GND}
C {code_shown.sym} 30 -140 0 0 {name=s1
only_toplevel=false
value= ".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.dc VDS 0 1.8 0.01
.save all
"}
C {lab_pin.sym} -240 -180 0 0 {name=p1 sig_type=std_logic lab=VDS}
C {lab_pin.sym} -360 -30 0 0 {name=p2 sig_type=std_logic lab=VGS}
