import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# ==========================================================
# Read Monte Carlo data
# ==========================================================

data = pd.read_csv("mc_results.txt")

# Convert current from A to microampere
I01 = data["I01"].to_numpy() * 1e6
I10 = data["I10"].to_numpy() * 1e6
I11 = data["I11"].to_numpy() * 1e6

print("Number of Monte Carlo runs:", len(data))


# ==========================================================
# 1. I01 MONTE CARLO HISTOGRAM
# ==========================================================

mean_I01 = np.mean(I01)
sigma_I01 = np.std(I01, ddof=1)

plt.figure(figsize=(8, 5))

plt.hist(
    I01,
    bins=15,
    edgecolor="black"
)

plt.axvline(
    mean_I01,
    linestyle="--",
    linewidth=2,
    label=f"Mean = {mean_I01:.3f} µA"
)

plt.axvline(
    mean_I01 + 3 * sigma_I01,
    linestyle=":",
    linewidth=2,
    label=f"+3σ = {mean_I01 + 3*sigma_I01:.3f} µA"
)

plt.axvline(
    mean_I01 - 3 * sigma_I01,
    linestyle=":",
    linewidth=2,
    label=f"-3σ = {mean_I01 - 3*sigma_I01:.3f} µA"
)

plt.xlabel("I01 Output Current (µA)")
plt.ylabel("Number of Monte Carlo Runs")
plt.title("Monte Carlo Distribution of I01")
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig("monte_carlo_I01.png", dpi=300)
plt.show()


# ==========================================================
# 2. DNL CALCULATION
# ==========================================================

# Three actual DAC step sizes
step1 = I01
step2 = I10 - I01
step3 = I11 - I10

# Average LSB for each Monte Carlo run
LSB = (step1 + step2 + step3) / 3

# DNL of each step
DNL1 = (step1 / LSB) - 1
DNL2 = (step2 / LSB) - 1
DNL3 = (step3 / LSB) - 1

# Combine all DNL values
DNL_all = np.concatenate([DNL1, DNL2, DNL3])

mean_DNL = np.mean(DNL_all)
sigma_DNL = np.std(DNL_all, ddof=1)


# ==========================================================
# 3. DNL HISTOGRAM
# ==========================================================

plt.figure(figsize=(8, 5))

plt.hist(
    DNL_all,
    bins=20,
    edgecolor="black"
)

plt.axvline(
    mean_DNL,
    linestyle="--",
    linewidth=2,
    label=f"Mean = {mean_DNL:.4f} LSB"
)

plt.axvline(
    mean_DNL + 3 * sigma_DNL,
    linestyle=":",
    linewidth=2,
    label=f"+3σ = {mean_DNL + 3*sigma_DNL:.4f} LSB"
)

plt.axvline(
    mean_DNL - 3 * sigma_DNL,
    linestyle=":",
    linewidth=2,
    label=f"-3σ = {mean_DNL - 3*sigma_DNL:.4f} LSB"
)

plt.xlabel("DNL (LSB)")
plt.ylabel("Number of Samples")
plt.title("Monte Carlo DNL Distribution")
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig("monte_carlo_DNL.png", dpi=300)
plt.show()


# ==========================================================
# 4. INL CALCULATION — ENDPOINT METHOD
# ==========================================================

# For each Monte Carlo run:
#
# Code 00 = approximately 0
# Code 11 = I11
#
# Therefore ideal LSB is:
#
# LSB_endpoint = I11 / 3
#
# Ideal outputs:
# Code 01 = 1 * LSB_endpoint
# Code 10 = 2 * LSB_endpoint

LSB_endpoint = I11 / 3

ideal_I01 = LSB_endpoint
ideal_I10 = 2 * LSB_endpoint

# INL in LSB
INL1 = (I01 - ideal_I01) / LSB_endpoint
INL2 = (I10 - ideal_I10) / LSB_endpoint

# Combine INL values
INL_all = np.concatenate([INL1, INL2])

mean_INL = np.mean(INL_all)
sigma_INL = np.std(INL_all, ddof=1)

minimum_INL = np.min(INL_all)
maximum_INL = np.max(INL_all)
maximum_abs_INL = np.max(np.abs(INL_all))


# ==========================================================
# 5. INL HISTOGRAM
# ==========================================================

plt.figure(figsize=(8, 5))

plt.hist(
    INL_all,
    bins=20,
    edgecolor="black"
)

plt.axvline(
    mean_INL,
    linestyle="--",
    linewidth=2,
    label=f"Mean = {mean_INL:.4f} LSB"
)

plt.axvline(
    mean_INL + 3 * sigma_INL,
    linestyle=":",
    linewidth=2,
    label=f"+3σ = {mean_INL + 3*sigma_INL:.4f} LSB"
)

plt.axvline(
    mean_INL - 3 * sigma_INL,
    linestyle=":",
    linewidth=2,
    label=f"-3σ = {mean_INL - 3*sigma_INL:.4f} LSB"
)

plt.xlabel("INL (LSB)")
plt.ylabel("Number of Samples")
plt.title("Monte Carlo INL Distribution")
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig("monte_carlo_INL.png", dpi=300)
plt.show()


# ==========================================================
# 6. PRINT STATISTICS
# ==========================================================

print()
print("==============================================")
print("       MONTE CARLO DAC RESULTS")
print("==============================================")

print()
print("Number of runs =", len(data))

print()
print("----------- I01 OUTPUT CURRENT ---------------")

print(f"Mean       = {mean_I01:.4f} µA")
print(f"Sigma      = {sigma_I01:.4f} µA")
print(f"Minimum    = {np.min(I01):.4f} µA")
print(f"Maximum    = {np.max(I01):.4f} µA")
print(f"-3 Sigma   = {mean_I01 - 3*sigma_I01:.4f} µA")
print(f"+3 Sigma   = {mean_I01 + 3*sigma_I01:.4f} µA")

print()
print("----------- DNL --------------------------------")

print(f"Mean       = {mean_DNL:.5f} LSB")
print(f"Sigma      = {sigma_DNL:.5f} LSB")
print(f"Minimum    = {np.min(DNL_all):.5f} LSB")
print(f"Maximum    = {np.max(DNL_all):.5f} LSB")
print(f"Max |DNL|  = {np.max(np.abs(DNL_all)):.5f} LSB")

print()
print("----------- INL --------------------------------")

print(f"Mean       = {mean_INL:.5f} LSB")
print(f"Sigma      = {sigma_INL:.5f} LSB")
print(f"Minimum    = {minimum_INL:.5f} LSB")
print(f"Maximum    = {maximum_INL:.5f} LSB")
print(f"Max |INL|  = {maximum_abs_INL:.5f} LSB")

print()
print("==============================================")
print("Graphs saved:")
print("  monte_carlo_I01.png")
print("  monte_carlo_DNL.png")
print("  monte_carlo_INL.png")
print("==============================================")
