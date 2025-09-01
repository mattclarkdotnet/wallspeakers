import electroacPy as ep

system = ep.load("./outputs/bem_eval")
system.plot_results()

# LP filter
system.filter_network("LP_xover", ref2bem=1, ref2study="half_space")
system.filter_addLowPassBQ("LP_xover", "lf1", 400, 0.5)
system.filter_addLowPassBQ("LP_xover", "lf2", 400, 0.5)

# HP filter
system.filter_network("HP_xover", ref2bem=2, ref2study="half_space")
system.filter_addHighPassBQ("HP_xover", "hp1", 400, 0.5)
system.filter_addHighPassBQ("HP_xover", "hp2", 400, 0.5)
system.filter_addGain("HP_xover", "db", 3)

ep.save("./outputs/xo", system)
system.plot_results()
