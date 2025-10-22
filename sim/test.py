import electroacPy as ep

system = ep.load("./outputs/eval21_hard")


# LP filter
system.filter_network("LP_xover", ref2bem=1, ref2study=["half_space", "free_space"])
system.filter_addLowPassBQ("LP_xover", "lf1", 400, 0.707)
system.filter_addLowPassBQ("LP_xover", "lf2", 400, 0.707)

# HP filter
system.filter_network("HP_xover", ref2bem=2, ref2study=["half_space", "free_space"])
system.filter_addHighPassBQ("HP_xover", "hp1", 400, 0.707)
system.filter_addHighPassBQ("HP_xover", "hp2", 400, 0.707)
# system.filter_addGain("HP_xover", "db", 10)
# system.filter_addPhaseFlip("HP_xover", "pi")

# %% Transfer functions
H_lf = system.crossover["LP_xover"].h
H_hf = system.crossover["HP_xover"].h
