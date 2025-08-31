import electroacPy as ep

system = ep.load("./outputs/bem_study")

system.evaluation_polarRadiation(
    "half_space", "polar_hor", -180, 180, 5, "x", "z", radius=2, offset=[0, 0, 0.05]
)

system.run()
ep.save("./outputs/bem_eval", system)
