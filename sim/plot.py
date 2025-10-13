import sys

import electroacPy as ep

from setup import bmr_bem_group, woofer_bem_group

runid = sys.argv[1]
# %% load data
system = ep.load(f"./outputs/eval{runid}")


# LP filter
system.filter_network(
    "LP_xover", ref2bem=woofer_bem_group, ref2study=["half_space", "free_space"]
)
system.filter_addLowPassBQ("LP_xover", "lf1", 300, 0.707)
system.filter_addLowPassBQ("LP_xover", "lf2", 300, 0.707)

# HP filter
system.filter_network(
    "HP_xover", ref2bem=bmr_bem_group, ref2study=["half_space", "free_space"]
)
system.filter_addHighPassBQ("HP_xover", "hp1", 300, 0.707)
system.filter_addHighPassBQ("HP_xover", "hp2", 300, 0.707)
# system.filter_addGain("HP_xover", "db", 10)
# system.filter_addPhaseFlip("HP_xover", "pi")

# # %% Transfer functions
# H_lf = system.crossover["LP_xover"].h
# H_hf = system.crossover["HP_xover"].h

# # show xo transfer functions
# gtb.plot.FRF(
#     system.frequency,
#     (H_lf, H_hf, H_lf + H_hf),
#     legend=("LF", "HF", "total"),
#     transformation="dB",
#     ylim=(-30, 10),
#     xlim=(20, 20000),
#     figsize=(6, 3),
#     xticks=(10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000),
#     yticks=np.arange(-30, 12, 6),
# )

for study in ("free_space", "half_space"):
    system.plot_system(study=study)
    system.plot_results(study=study)
    # p_lf = system.get_pMic(study, "polar_hor", radiatingElement="sealed_LF")
    # p_hf = system.get_pMic(study, "polar_hor", radiatingElement="sealed_BMR")
    # p_tot = system.get_pMic(study, "polar_hor")
    # gtb.plot.FRF(
    #     system.frequency,
    #     (
    #         p_lf[:, 35],
    #         p_hf[:, 35],
    #         p_tot[:, 35],
    #     ),
    #     ylabel="SPL [dB]",
    #     legend=("woofer", "bmr", "total"),
    #     xlim=(20, 20e3),
    #     ylim=(35, 80),
    # )

# system.run()
