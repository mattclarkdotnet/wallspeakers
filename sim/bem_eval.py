import sys

import electroacPy as ep

runid = sys.argv[1]

system = ep.load(f"./outputs/study{runid}")

system.evaluation_polarRadiation(
    "half_space",
    "polar_hor_half",
    -90,
    90,
    5,
    on_axis="z",
    direction="x",
    radius=2,
    offset=[0, 0, 0.05],
)

system.evaluation_polarRadiation(
    "half_space",
    "polar_ver_half",
    -90,
    90,
    5,
    on_axis="z",
    direction="y",
    radius=2,
    offset=[0, 0, 0.05],
)

system.evaluation_polarRadiation(
    "free_space",
    "polar_hor_free",
    -180,
    180,
    5,
    on_axis="z",
    direction="x",
    radius=2,
    offset=[0, 0, 0.05],
)

system.evaluation_polarRadiation(
    "half_space",
    "polar_ver_free",
    -180,
    180,
    5,
    on_axis="z",
    direction="y",
    radius=2,
    offset=[0, 0, 0.05],
)

system.evaluation_sphericalRadiation(
    "half_space",
    "spherical_half",
    nMic=1000,
    radius=2,
    offset=[0, 0, 0.05],
)

system.evaluation_sphericalRadiation(
    "free_space",
    "spherical_free",
    nMic=1000,
    radius=2,
    offset=[0, 0, 0.05],
)

system.run()
ep.save(f"./outputs/eval{runid}", system)
