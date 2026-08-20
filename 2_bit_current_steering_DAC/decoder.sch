v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -1120 -380 -1120 10 {lab=A}
N -1050 -380 -1050 20 {lab=B}
N -1120 -280 -620 -280 {lab=A}
N -1050 -260 -620 -260 {lab=B}
N -1120 0 -1120 190 {lab=A}
N -1050 10 -1050 200 {lab=B}
N -330 -300 -170 -300 {lab=S1'}
N -330 -300 -330 -220 {lab=S1'}
N -330 -220 -300 -220 {lab=S1'}
N -1120 -40 -130 -40 {lab=A}
N -530 60 -430 60 {lab=A}
N -530 -40 -530 60 {lab=A}
N -1120 190 -1120 330 {lab=A}
N -1050 190 -1050 330 {lab=B}
N -1120 220 -680 220 {lab=A}
N -1050 240 -680 240 {lab=B}
N -380 200 -140 200 {lab=S3'}
N -360 300 -340 300 {lab=S3'}
N -360 200 -360 300 {lab=S3'}
N -1120 -410 -1120 -380 {lab=A}
N -1050 -420 -1050 -380 {lab=B}
N -630 -570 -630 -300 {lab=VDD}
N -630 -570 -440 -570 {lab=VDD}
N -300 -570 -300 -240 {lab=VDD}
N -450 -570 -300 -570 {lab=VDD}
N -430 -140 -430 40 {lab=VDD}
N -430 -140 -330 -140 {lab=VDD}
N -330 -140 -320 -260 {lab=VDD}
N -320 -260 -300 -260 {lab=VDD}
N -680 20 -680 200 {lab=VDD}
N -680 20 -430 20 {lab=VDD}
N -340 150 -340 280 {lab=VDD}
N -680 150 -340 150 {lab=VDD}
N -630 -240 -630 -200 {lab=GND}
N -630 -200 -300 -200 {lab=GND}
N -630 80 -430 80 {lab=GND}
N -630 -200 -630 80 {lab=GND}
N -790 260 -680 260 {lab=GND}
N -790 260 -780 -180 {lab=GND}
N -780 -180 -630 -180 {lab=GND}
N -790 320 -340 320 {lab=GND}
N -790 260 -790 320 {lab=GND}
N -520 320 -520 380 {lab=GND}
C {nor.sym} -480 -270 0 0 {name=x3}
C {inverter.sym} -150 -220 0 0 {name=x1}
C {inverter.sym} -280 60 0 0 {name=x4}
C {nand.sym} -530 230 0 0 {name=x6}
C {inverter.sym} -190 300 0 0 {name=x2}
C {ipin.sym} -1120 -410 1 0 {name=p1 lab=A}
C {ipin.sym} -1050 -410 1 0 {name=p2 lab=B}
C {ipin.sym} -470 -570 1 0 {name=p5 lab=VDD}
C {ipin.sym} -520 380 3 0 {name=p9 lab=GND}
C {opin.sym} -170 -300 0 0 {name=p10 lab=S1'}
C {opin.sym} 0 -240 0 0 {name=p3 lab=S1}
C {opin.sym} -130 40 0 0 {name=p6 lab=S2'}
C {opin.sym} -40 280 0 0 {name=p8 lab=S3}
C {opin.sym} -140 200 0 0 {name=p7 lab=S3'}
