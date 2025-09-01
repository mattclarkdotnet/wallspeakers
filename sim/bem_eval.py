import sys

import electroacPy as ep

runid = sys.argv[1]

system = ep.load(f"./outputs/study{runid}")

system.evaluation_polarRadiation(
    "half_space", "polar_hor", -180, 180, 5, "x", "y", radius=2
)

system.run()
ep.save(f"./outputs/eval{runid}", system)
