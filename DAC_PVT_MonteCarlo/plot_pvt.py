import matplotlib.pyplot as plt


# ==========================================================
# 1. OUTPUT CURRENT vs SUPPLY VOLTAGE
# ==========================================================

VDD = [1.62, 1.80, 1.98]

I01_VDD = [8.164934, 9.910301, 11.69227]
I10_VDD = [16.43313, 19.81632, 23.25142]
I11_VDD = [24.59134, 29.71794, 34.93278]

plt.figure(figsize=(8, 5))

plt.plot(VDD, I01_VDD, marker='o', label='Code 01')
plt.plot(VDD, I10_VDD, marker='s', label='Code 10')
plt.plot(VDD, I11_VDD, marker='^', label='Code 11')

plt.xlabel("Supply Voltage VDD (V)")
plt.ylabel("Output Current (µA)")
plt.title("DAC Output Current vs Supply Voltage")
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig("PVT_VDD.png", dpi=300)
plt.show()


# ==========================================================
# 2. OUTPUT CURRENT vs TEMPERATURE
# ==========================================================

Temperature = [-40, 27, 125]

I01_T = [9.776797, 9.910301, 10.07712]
I10_T = [19.54921, 19.81632, 20.15004]
I11_T = [29.31716, 29.71794, 30.21873]

plt.figure(figsize=(8, 5))

plt.plot(
    Temperature,
    I01_T,
    marker='o',
    label='Code 01'
)

plt.plot(
    Temperature,
    I10_T,
    marker='s',
    label='Code 10'
)

plt.plot(
    Temperature,
    I11_T,
    marker='^',
    label='Code 11'
)

plt.xlabel("Temperature (°C)")
plt.ylabel("Output Current (µA)")
plt.title("DAC Output Current vs Temperature")
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig("PVT_Temperature.png", dpi=300)
plt.show()


# ==========================================================
# 3. PROCESS CORNER ANALYSIS
# ==========================================================

corners = ['SS', 'TT', 'FF', 'SF', 'FS']

I01_corner = [
    9.362652,
    9.910301,
    10.42479,
    10.55634,
    9.238520
]

I10_corner = [
    18.72228,
    19.81632,
    20.84371,
    21.10675,
    18.47428
]

I11_corner = [
    28.07873,
    29.71794,
    31.25659,
    31.65099,
    27.70722
]

plt.figure(figsize=(8, 5))

plt.plot(
    corners,
    I01_corner,
    marker='o',
    label='Code 01'
)

plt.plot(
    corners,
    I10_corner,
    marker='s',
    label='Code 10'
)

plt.plot(
    corners,
    I11_corner,
    marker='^',
    label='Code 11'
)

plt.xlabel("Process Corner")
plt.ylabel("Output Current (µA)")
plt.title("DAC Output Current vs Process Corner")
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig("PVT_Process.png", dpi=300)
plt.show()


print()
print("PVT graphs generated successfully:")
print("  PVT_VDD.png")
print("  PVT_Temperature.png")
print("  PVT_Process.png")
