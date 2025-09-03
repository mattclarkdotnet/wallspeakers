import sys

import electroacPy as ep
import numpy as np
from electroacPy import gtb

runid = sys.argv[1]
# %% load data
system = ep.load(f"./outputs/eval{runid}")


# LP filter
system.filter_network("LP_xover", ref2bem=1, ref2study="half_space")
system.filter_addLowPassBQ("LP_xover", "lf1", 400, 0.707)
system.filter_addLowPassBQ("LP_xover", "lf2", 400, 0.707)

# HP filter
system.filter_network("HP_xover", ref2bem=2, ref2study="half_space")
system.filter_addHighPassBQ("HP_xover", "hp1", 400, 0.707)
system.filter_addHighPassBQ("HP_xover", "hp2", 400, 0.707)
system.filter_addGain("HP_xover", "db", 10)
# system.filter_addPhaseFlip("HP_xover", "pi")

# %% Transfer functions
H_lf = system.crossover["LP_xover"].h
H_hf = system.crossover["HP_xover"].h

# show xo transfer functions
gtb.plot.FRF(
    system.frequency,
    (H_lf, H_hf, H_lf + H_hf),
    legend=("LF", "HF", "total"),
    transformation="dB",
    ylim=(-30, 10),
    xlim=(20, 20000),
    figsize=(6, 3),
    xticks=(10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000),
    yticks=np.arange(-30, 12, 6),
)

# show speaker and boundary layout
system.plot_system("half_space")

p_lf = system.get_pMic("half_space", "polar_hor", radiatingElement=1)
p_hf = system.get_pMic("half_space", "polar_hor", radiatingElement=2)
p_tot = system.get_pMic("half_space", "polar_hor")

# plot pressure response
gtb.plot.FRF(
    system.frequency,
    (
        p_lf[:, 73 // 2],
        p_hf[:, 73 // 2],
        p_tot[:, 73 // 2],
    ),
    ylabel="SPL [dB]",
    legend=("woofer", "bmr", "total"),
    xlim=(10, 10e3),
    ylim=(35, 80),
)

system.run()

# show polar responses
system.plot_results()
