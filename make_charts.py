"""Create the key-findings chart for the UrbanCart README.

Usage: python make_charts.py "UrbanCart Superstore Dataset.xlsx"
Output: images/key_findings.png
"""
import os
import sys
import pandas as pd
import matplotlib.pyplot as plt

path = sys.argv[1] if len(sys.argv) > 1 else "UrbanCart Superstore Dataset.xlsx"
df = pd.read_excel(path)

GOOD, BAD, GREY = "#2E75B6", "#C0392B", "#7F7F7F"

def margin(g):
    return g["Profit"].sum() / g["Sales"].sum() * 100

bands = pd.cut(df["Discount"], [-0.001, 0, 0.1, 0.2, 0.3, 1.0],
               labels=["0%", "Up to 10%", "10-20%", "20-30%", "Above 30%"])
disc = df.groupby(bands, observed=True).apply(margin)
cat = df.groupby("Category").apply(margin).sort_values()
reg = df.groupby("Region").apply(margin).sort_values()
yr = df.groupby(df["Order Date"].dt.year)["Sales"].sum() / 1000

fig, ax = plt.subplots(2, 2, figsize=(12, 8))
fig.suptitle("UrbanCart: where profit is made and lost (Superstore data, 2014-2017)",
             fontsize=14, fontweight="bold")

def bar(a, labels, values, title, ylabel, horizontal=False, fmt="{:.1f}%"):
    colors = [BAD if v < 0 else GOOD for v in values]
    if horizontal:
        a.barh(labels, values, color=colors)
        a.axvline(0, color="black", lw=0.8)
        a.set_xlabel(ylabel)
        for i, v in enumerate(values):
            a.text(v + (0.4 if v >= 0 else -0.4), i, fmt.format(v),
                   va="center", ha="left" if v >= 0 else "right", fontsize=9)
    else:
        a.bar(labels, values, color=colors)
        a.axhline(0, color="black", lw=0.8)
        a.set_ylabel(ylabel)
        for i, v in enumerate(values):
            a.text(i, v + (1 if v >= 0 else -1), fmt.format(v),
                   ha="center", va="bottom" if v >= 0 else "top", fontsize=9)
    a.set_title(title, fontsize=11, loc="left")
    for s in ("top", "right"):
        a.spines[s].set_visible(False)

bar(ax[0, 0], list(disc.index.astype(str)), disc.values,
    "Profit margin by discount band", "Profit margin (%)")
ax[0, 0].set_ylim(min(disc.values) - 12, max(disc.values) + 8)
bar(ax[0, 1], list(cat.index), cat.values,
    "Profit margin by category", "Profit margin (%)", horizontal=True)
ax[0, 1].set_xlim(0, max(cat.values) + 4)
bar(ax[1, 0], list(reg.index), reg.values,
    "Profit margin by region", "Profit margin (%)", horizontal=True)
ax[1, 0].set_xlim(0, max(reg.values) + 4)

ax[1, 1].bar(yr.index.astype(str), yr.values, color=GREY)
ax[1, 1].set_title("Sales by year", fontsize=11, loc="left")
ax[1, 1].set_ylabel("Sales (thousands)")
for i, v in enumerate(yr.values):
    ax[1, 1].text(i, v + 8, f"{v:,.0f}K", ha="center", fontsize=9)
for s in ("top", "right"):
    ax[1, 1].spines[s].set_visible(False)

fig.text(0.01, 0.005, "Chart generated with Python (pandas, matplotlib) from the UrbanCart Superstore dataset.",
         fontsize=8, color="#555555")
plt.tight_layout(rect=[0, 0.02, 1, 0.95])
os.makedirs("images", exist_ok=True)
plt.savefig("images/key_findings.png", dpi=170)
print("Saved images/key_findings.png")
